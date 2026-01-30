# Bağış verisi (donations.json)

Bu dosya Firestore `donations` koleksiyonuna eklenecek belgeleri içerir.

## Kullanım

1. **Firestore Console:** Koleksiyon `donations` → her bir JSON öğesini **Belge ekle** ile ekleyin. Belge ID olarak `id` alanını kullanın (yoksa Otomatik ID).
2. **Tek linkli kart:** `title`, `description`, `donationUrl`, `imageUrl`, `categoryId`, `extraInfo`, `infoUrl` alanlarını ekleyin. `donationOptions` eklemeyin.
3. **Çoklu seçenekli kart (Kızılay gibi):** Aynı alanlara ek olarak `donationOptions` array'i ekleyin. Her öğe: `label`, `url`, `description`, `extraInfo`, `infoUrl` (isteğe bağlı).

## categoryId

- `government` = Devlet Kurumları
- `foundation` = Vakıflar
- `association` = Dernekler
