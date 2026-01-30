# .gitignore'a eklenen dosyaları Git takibinden çıkar (dosyalar diskte kalır)
# PowerShell - proje kökünden çalıştır: .\scripts\untrack-ignored.ps1

$ErrorActionPreference = "SilentlyContinue"

git rm --cached scripts/serviceAccountKey.json 2>$null
git rm --cached lib/firebase_options.dart 2>$null
git rm --cached android/app/google-services.json 2>$null
git rm --cached ios/Runner/GoogleService-Info.plist 2>$null
git rm -r --cached docs/ 2>$null
git rm --cached .env 2>$null
git rm --cached .env.* 2>$null
git rm -r --cached node_modules/ 2>$null
git rm -r --cached scripts/node_modules/ 2>$null

Write-Host "Tamam. Simdi: git status ile kontrol et, sonra git add .gitignore && git commit -m 'chore: ignore edilen dosyalari takipten cikar' && git push"
