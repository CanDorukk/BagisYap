/**
 * data/donations.json dosyasını Firestore donations koleksiyonuna yükler.
 *
 * Kullanım:
 * 1. Firebase Console → Proje ayarları → Hizmet hesapları → Yeni özel anahtar oluştur
 *    → JSON indir → Bu projede serviceAccountKey.json olarak scripts/ klasörüne koy
 * 2. Terminal: cd scripts && npm install firebase-admin && node import-donations-to-firestore.js
 *
 * Not: .gitignore'a serviceAccountKey.json ekleyin (gizli kalmalı).
 */

const admin = require('firebase-admin');
const fs = require('fs');
const path = require('path');

const keyPath = path.join(__dirname, 'serviceAccountKey.json');
if (!fs.existsSync(keyPath)) {
  console.error('Hata: scripts/serviceAccountKey.json bulunamadı.');
  console.error('Firebase Console → Proje ayarları → Hizmet hesapları → Yeni özel anahtar oluştur → JSON indir → scripts/ içine serviceAccountKey.json adıyla kaydedin.');
  process.exit(1);
}

const serviceAccount = require(keyPath);

admin.initializeApp({ credential: admin.credential.cert(serviceAccount) });
const db = admin.firestore();

const jsonPath = path.join(__dirname, '..', 'data', 'donations.json');
const data = JSON.parse(fs.readFileSync(jsonPath, 'utf8'));

async function main() {
  const collection = db.collection('donations');
  for (const doc of data) {
    const id = doc.id;
    const { id: _, ...fields } = doc;
    await collection.doc(id).set(fields);
    console.log('Yazıldı:', id);
  }
  console.log('Tamamlandı. Toplam', data.length, 'belge.');
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});
