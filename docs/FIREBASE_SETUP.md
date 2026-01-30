# Firebase ile Bağış Verilerini Dinamik Çekme

Bu rehber, BağışYap uygulamasında bağış listesini Firebase Firestore'dan dinamik olarak çekmek için baştan sona yapmanız gerekenleri anlatır.

---

## 1. Firebase projesi oluşturma

1. [Firebase Console](https://console.firebase.google.com/) adresine gidin.
2. **Proje ekle** → Proje adı: `bagisyap` (veya istediğiniz ad).
3. Google Analytics isteğe bağlı; isterseniz kapatıp devam edin.
4. Proje oluştuktan sonra **Firestore Database** → **Veritabanı oluştur** → **Test modunda başlat** (geliştirme için). Canlıya alırken kuralları güncelleyin.

---

## 2. Flutter projesine Firebase ekleme

### 2.1 FlutterFire CLI

Terminalde proje kökünde:

```bash
# FlutterFire CLI (bir kez)
dart pub global activate flutterfire_cli

# Firebase’e giriş (tarayıcı açılır)
firebase login

# Projeyi Firebase ile eşleştir, firebase_options.dart oluşturur
dart run flutterfire configure
```

`dart run flutterfire configure` çalışınca:

- Hangi Firebase projesini kullanacağınızı seçin.
- Android / iOS / Web için gerekli dosyalar eklenir veya güncellenir.
- `lib/firebase_options.dart` gerçek API anahtarlarıyla oluşturulur.

### 2.2 Android

- `flutterfire configure` genelde `android/app/google-services.json` dosyasını ekler veya günceller.
- Eğer yoksa: Firebase Console → Proje ayarları → Genel → Android uygulamanızı ekleyin, `google-services.json` indirip `android/app/` altına koyun.

### 2.3 iOS

- Firebase Console’da iOS uygulaması ekleyin, `GoogleService-Info.plist` indirin.
- Dosyayı Xcode’da `ios/Runner/` altına sürükleyip projeye ekleyin (Copy items if needed işaretli).

---

## 3. Firestore veri yapısı

### Koleksiyon: `donations`

Her belge bir bağış kaydıdır. Alan adları **tam olarak** aşağıdaki gibi yazılmalıdır (büyük/küçük harf dahil).

| Firestore alanı | Tip    | Zorunlu | Açıklama |
|-----------------|--------|--------|----------|
| `title` | string | Evet | Bağış başlığı (örn. Mehmetçik Vakfı). |
| `description` | string | Evet | Kısa açıklama metni. |
| `donationUrl` | string | Hayır | Bağış sayfası linki; dialog'da "Bağış sayfasına git" butonu bu adrese gider. |
| `imageUrl` | string | Hayır | Logo / görsel URL; kartta gösterilir. |
| `categoryId` | string | Hayır | Sekme: `government` = Devlet Kurumları, `foundation` = Vakıflar, `association` = Dernekler. |
| `extraInfo` | string | Hayır | SMS / ek bilgi. Varsa kartta ikonla gösterilir; yoksa alan eklemeyin veya boş bırakın. |
| `infoUrl` | string | Hayır | Dialog en altındaki "Bilgiler \"X\" resmi internet sitesinden alınmıştır." cümlesinde X (başlık) tıklanınca açılacak link. |
 | `donationOptions` | array (map) | Hayır | Birden fazla bağış türü (örn. Kızılay: aşevi, kan). Varsa karta tıklanınca önce "Bağış türünü seçin" listesi açılır; **en üstte "Genel"** gelir (Genel = belge seviyesindeki title, description, donationUrl, extraInfo, infoUrl). Her öğe bir **map**; alanlar: `label`, `url`, `description` (isteğe bağlı), `extraInfo`, `infoUrl` (isteğe bağlı). Seçilen öğenin alanları dialog’da gösterilir (dialog’da görsel yok). |

**Belge ID:** Otomatik ID kullanın; uygulama `doc.id` ile okur.

**Not:** `extraInfo` sadece SMS / ek bilgisi olan bağışlarda doldurulur. Diğerlerinde alan eklemeyebilir veya boş bırakabilirsiniz.

**donationOptions:** Kızılay gibi birden fazla bağış türü olan kurumlarda kullanın. Karta tıklanınca listede **en üstte "Genel"** görünür; Genel seçilirse normal kart (belgedeki title, description, donationUrl, extraInfo, infoUrl) dialog’da gösterilir. Diğer satırlar donationOptions içindeki her map’in `label` değeridir; birini seçince o map’teki `description`, `url`, `extraInfo`, `infoUrl` dialog’da kullanılır. Tek linkli kartlarda bu alanı eklemeyin; `donationUrl` kullanın.

### Örnek belge (Firestore Console’da)

Koleksiyon: **donations** → **Belge ekle** → **Otomatik ID** → Aşağıdaki alanları ekleyin (Field = alan adı, Type = string, Value = değer):

| Field | Type | Value |
|-------|------|-------|
| title | string | Mehmetçik Vakfı |
| description | string | TSK Mehmetçik Vakfı – Şehit ve gazi ailelerine destek. |
| donationUrl | string | https://www.mehmetcik.org.tr/bagis |
| imageUrl | string | https://www.mehmetcik.org.tr/uploads/sayfaResim/997918-yeni-logo-web.png |
| categoryId | string | foundation |
| extraInfo | string | SMS ile bağış: "Mesajım Mehmetçik İçin Olsun" yazıp 1234'e gönderin. |
| infoUrl | string | https://www.mehmetcik.org.tr |

**Çoklu bağış türü örneği (Kızılay):** Aynı kartta birden fazla seçenek için `donationOptions` ekleyin. Firestore’da alan tipi **array**, her öğe bir **map**. Map içinde dialog’da kullandığımız alanlar: `label`, `url`, `description`, `extraInfo`, `infoUrl` (hepsi isteğe bağlı; girilmezse belge seviyesindeki değer kullanılır; özellikle infoUrl option’da yoksa ana yapıdaki infoUrl kullanılır). Dialog’da görsel gösterilmediği için option’da `imageUrl` yok. Listede **en üstte "Genel"** uygulama tarafından eklenir; Genel seçilince belgedeki title, description, donationUrl, extraInfo, infoUrl gösterilir.

Belge seviyesi: title, description, donationUrl, imageUrl, categoryId, infoUrl, extraInfo (Genel için). donationOptions array’indeki her map örneği:

| Map içi alan | Type | Açıklama |
|--------------|------|----------|
| label | string | Listede görünen ad (örn. "Kızılay aşevi bağış") |
| url | string | Bu türün bağış sayfası linki |
| description | string | (İsteğe bağlı) Bu türe özel açıklama |
| extraInfo | string | (İsteğe bağlı) SMS / ek bilgi |
| infoUrl | string | (İsteğe bağlı) "Bilgiler X tarafından alınmıştır" linki. Girilmezse belge seviyesindeki infoUrl kullanılır. |

Örnek: `donationOptions` = [ { "label": "Kızılay aşevi bağış", "url": "https://...", "description": "Aşevi bağışı", "extraInfo": "SMS: ...", "infoUrl": "https://..." }, { "label": "Kızılay kan bağışı", "url": "https://...", "description": "Kan bağışı", "infoUrl": "https://..." } ]

---

## 4. Uygulama tarafındaki yapı (özet)

- **main.dart:** `Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)` ile Firebase başlatılır.
- **DonationFirestoreDatasource:** `donations` koleksiyonunu okur, her belgeyi `DonationModel.fromJson` ile modele çevirir.
- **DonationRepository:** Bu datasource’u kullanır; `getDonations()` liste döner.
- **DonationProvider:** Sayfa açıldığında `loadDonations()` ile repository’den veriyi çeker; liste ekranda gösterilir.

Veri akışı: **Firestore → DonationFirestoreDatasource → DonationRepository → DonationProvider → DonationListPage / DonationCard.**

---

## 5. Firestore güvenlik kuralları (örnek)

Geliştirme sonrası kuralları mutlaka sıkılaştırın. Sadece okuma örneği:

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /donations/{docId} {
      allow read: if true;
      allow write: if false;
    }
  }
}
```

Yazma (create/update/delete) sadece Firebase Admin veya güvenli bir backend üzerinden yapılmalı; mobil istemcide `write: if false` bırakılabilir.

---

## 6. Test

1. Firebase Console’da `donations` koleksiyonuna en az bir belge ekleyin (yukarıdaki örnek gibi).
2. Uygulamayı çalıştırın: `flutter run`.
3. Bağışlar sekmesinde (özellikle “Vakıflar”) eklediğiniz kayıt görünmeli.
4. `categoryId`: `foundation` → Vakıflar, `government` → Devlet Kurumları, `association` → Dernekler sekmesinde listelenir.

---

## 7. Sorun giderme

- **Firebase initialize hatası:** `dart run flutterfire configure` çalıştırdınız mı? `lib/firebase_options.dart` güncel mi?
- **Android’de çökme:** `android/app/google-services.json` var mı? Proje ayarlarında Android paket adı (örn. `com.example.bagisyap`) Firebase’deki ile aynı mı?
- **iOS’ta çökme:** `GoogleService-Info.plist` Xcode projesine eklendi mi?
- **Boş liste:** Firestore’da `donations` koleksiyonu ve en az bir belge var mı? Alan adları (`title`, `description`, `categoryId` vb.) yukarıdaki tabloyla uyumlu mu?

Bu adımlarla bağış listesi tamamen Firebase’den dinamik olarak gelir; yeni kayıt ekledikçe uygulama bir sonraki `loadDonations()` çağrısında güncel listeyi gösterir.
