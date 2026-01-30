# Firestore'a bağış verisi yükleme

`data/donations.json` dosyasını Firestore **donations** koleksiyonuna yükler.

## Adımlar

### 1. Service Account anahtarı

1. [Firebase Console](https://console.firebase.google.com/) → **bagisyap** projesi
2. **Proje ayarları** (dişli) → **Hizmet hesapları** sekmesi
3. **Yeni özel anahtar oluştur** → Oluştur → JSON dosyası iner
4. İnen dosyayı **scripts** klasörüne kopyalayıp adını **serviceAccountKey.json** yapın  
   (`scripts/serviceAccountKey.json`)

### 2. Bağımlılık ve çalıştırma

Proje kökünde (BagisYap klasöründe) terminalde:

```bash
cd scripts
npm install firebase-admin
node import-donations-to-firestore.js
```

### 3. Sonuç

- **donations** koleksiyonuna `donations.json` içindeki her öğe bir belge olarak yazılır
- Belge ID’leri JSON’daki **id** alanından alınır (örn. `kizilay`, `mehmetcik-vakfi`)
- Mevcut aynı ID’li belgeler **üzerine yazılır**

## Güvenlik

- **serviceAccountKey.json** dosyasını Git’e eklemeyin (`.gitignore`’da olmalı)
- Anahtarı yalnızca kendi bilgisayarınızda, import için kullanın
