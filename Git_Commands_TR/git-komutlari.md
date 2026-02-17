# 🧰 Git Komutları Rehberi
> Yazılım geliştiriciler için kapsamlı Git referans kılavuzu — Temel'den İleri Seviyeye

---

## İçindekiler

- [Kurulum & Yapılandırma](#-kurulum--yapılandırma)
- [Repo Başlatma & Klonlama](#-repo-başlatma--klonlama)
- [Değişiklikleri Kaydetme](#-değişiklikleri-kaydetme)
- [Branch İşlemleri](#-branch-dal-işlemleri)
- [Uzak Repo İşlemleri](#-uzak-repo-remote-işlemleri)
- [Geçmişi İnceleme](#-geçmişi-inceleme)
- [Geri Alma](#-geri-alma)
- [Stash](#-stash-geçici-saklama)
- [Merge & Rebase](#-merge--rebase)
- [Tag İşlemleri](#-tag-etiket-işlemleri)
- [Gelişmiş Komutlar](#-gelişmiş-komutlar)
- [Konfigürasyon & Alias](#-konfigürasyon--alias)
- [Tipik İş Akışları](#-tipik-i̇ş-akışları)

---

## 🔧 Kurulum & Yapılandırma

```bash
git config --global user.name "Adın Soyadın"
```
Git'e kim olduğunu tanıtır. Tüm commitlerde bu isim görünür.

```bash
git config --global user.email "email@example.com"
```
Commit geçmişinde görünecek e-posta adresini ayarlar.

```bash
git config --global core.editor "code --wait"
```
Varsayılan metin editörünü ayarlar. `vim`, `nano`, `code` gibi seçenekler kullanılabilir.

```bash
git config --global init.defaultBranch main
```
Yeni repolarda varsayılan branch adını `main` olarak ayarlar.

```bash
git config --list
```
Tüm Git ayarlarını listeler.

```bash
git config --global --edit
```
Global Git yapılandırma dosyasını editörde açar.

---

## 📁 Repo Başlatma & Klonlama

```bash
git init
```
Bulunduğun klasörü bir Git reposuna dönüştürür. Gizli `.git` klasörü oluşturulur.

```bash
git init <proje-adi>
```
Yeni bir klasör oluşturup içini repo olarak başlatır.

```bash
git clone <url>
```
Uzak bir repoyu tüm geçmişiyle birlikte bilgisayarına kopyalar.
```bash
git clone https://github.com/kullanici/proje.git
```

```bash
git clone <url> <klasor-adi>
```
Repoyu belirttiğin isimde bir klasöre klonlar.

```bash
git clone --depth 1 <url>
```
Sadece son commiti alır, tüm geçmişi indirmez. Büyük repolar için hızlıdır.

```bash
git clone --branch <branch-adi> <url>
```
Belirli bir branchi klonlar.

---

## 📸 Değişiklikleri Kaydetme

```bash
git status
```
Değişen, eklenen, silinen ve stage'deki dosyaları gösterir. En sık kullanılan komutlardan biri.

```bash
git status -s
```
Kısa ve öz çıktı verir. `M` = modified, `A` = added, `?` = untracked.

```bash
git add <dosya>
```
Belirtilen dosyayı bir sonraki commite hazırlar (stage'e alır).

```bash
git add .
```
Tüm değişiklikleri stage'e alır.

```bash
git add -p
```
Değişiklikleri parça parça (hunk) inceleyerek seçici biçimde stage'e alır. Çok güçlü bir komut.

```bash
git commit -m "Mesaj"
```
Stage'deki değişiklikleri kalıcı olarak kaydeder.
```bash
git commit -m "feat: kullanıcı giriş sayfası eklendi"
```

```bash
git commit -am "Mesaj"
```
`git add` + `git commit` işlemini tek adımda yapar. *(Yalnızca takip edilen dosyalar için geçerlidir.)*

```bash
git commit --amend -m "Yeni mesaj"
```
Son commitin mesajını değiştirir ya da unutulan dosyaları son commite ekler.

```bash
git commit --amend --no-edit
```
Son commite yeni değişiklikler ekler, mesajı değiştirmez.

```bash
git rm <dosya>
```
Dosyayı hem diskten hem de Git takibinden siler.

```bash
git rm --cached <dosya>
```
Dosyayı Git takibinden çıkarır ama diskten silmez. `.gitignore`'a eklemeden önce kullanışlıdır.

```bash
git mv <eski-ad> <yeni-ad>
```
Dosyayı yeniden adlandırır ve Git bu değişikliği otomatik takip eder.

---

## 🌿 Branch (Dal) İşlemleri

```bash
git branch
```
Yerel branchleri listeler. Üzerinde olduğun branch `*` ile işaretlenir.

```bash
git branch -a
```
Yerel ve uzak tüm branchleri listeler.

```bash
git branch <isim>
```
Yeni bir branch oluşturur ama geçmez.

```bash
git checkout <branch>
```
Belirtilen brancha geçer.

```bash
git checkout -b <isim>
```
Yeni branch oluşturup direkt ona geçer. En pratik yol.
```bash
git checkout -b feature/odeme-sistemi
```

```bash
git switch <branch>
```
Modern Git'te brancha geçmenin önerilen yolu. `checkout`'un daha temiz alternatifi.

```bash
git switch -c <isim>
```
Yeni branch oluşturup geçer. (`checkout -b` ile aynı işlev.)

```bash
git branch -d <isim>
```
Merge edilmiş bir branchi siler.

```bash
git branch -D <isim>
```
Merge edilmemiş olsa bile branchi zorla siler.

```bash
git branch -m <eski-isim> <yeni-isim>
```
Branch adını değiştirir.

```bash
git branch --merged
```
Mevcut branche merge edilmiş branchleri listeler. Silinebilecek branchleri bulmak için kullanışlıdır.

---

## 🌐 Uzak Repo (Remote) İşlemleri

```bash
git remote add origin <url>
```
Uzak repoyu projeye `origin` adıyla bağlar.

```bash
git remote -v
```
Bağlı uzak repoları ve URL'lerini listeler.

```bash
git remote remove <isim>
```
Uzak repo bağlantısını kaldırır.

```bash
git remote rename <eski> <yeni>
```
Uzak reponun adını değiştirir.

```bash
git push origin <branch>
```
Yerel commitlerini uzak repoya yükler.

```bash
git push -u origin <branch>
```
Branch'i uzak repoya yükler ve takip bağlantısı kurar. Sonraki `git push` komutlarında branch belirtmek gerekmez.

```bash
git push --force-with-lease
```
Zorla push yapar ama başkasının değişikliklerinin üzerine yazmamak için güvenli kontrol yapar. `--force`'tan daha güvenli.

```bash
git push origin --delete <branch>
```
Uzak repodaki bir branchi siler.

```bash
git pull
```
Uzak repodaki değişiklikleri çekip mevcut branchla birleştirir (`fetch` + `merge`).

```bash
git pull --rebase
```
Değişiklikleri merge yerine rebase ile birleştirir. Daha temiz bir geçmiş oluşturur.

```bash
git fetch
```
Uzak repodaki değişiklikleri indirir ama birleştirmez. Ne geldiğini önce görmek istersen kullanırsın.

```bash
git fetch --all
```
Tüm uzak repoların değişikliklerini indirir.

```bash
git fetch --prune
```
Uzak repoda silinmiş branchlerin yerel referanslarını temizler.

---

## 🔍 Geçmişi İnceleme

```bash
git log
```
Commit geçmişini ayrıntılı olarak gösterir.

```bash
git log --oneline
```
Her commiti tek satırda özet olarak gösterir.

```bash
git log --oneline --graph --all
```
Tüm branchlerin geçmişini görsel olarak dallanmış şekilde gösterir. Çok faydalıdır.

```bash
git log --author="Ad"
```
Belirli bir kişinin commitlerini filtreler.

```bash
git log --since="2 weeks ago"
```
Son 2 haftanın commitlerini gösterir.

```bash
git log --grep="fix"
```
Mesajında "fix" geçen commitleri bulur.

```bash
git log -p
```
Her commitin içinde nelerin değiştiğini gösterir (diff ile birlikte).

```bash
git log --stat
```
Her committe hangi dosyaların değiştiğini ve kaç satır eklenip çıkarıldığını gösterir.

```bash
git diff
```
Stage'e alınmamış değişiklikleri gösterir.

```bash
git diff --staged
```
Stage'e alınmış ama henüz commit edilmemiş değişiklikleri gösterir.

```bash
git diff <branch1>..<branch2>
```
İki branch arasındaki farkı gösterir.

```bash
git show <commit-id>
```
Belirli bir commitin içeriğini ve değişikliklerini gösterir.

```bash
git blame <dosya>
```
Dosyanın her satırının en son kim tarafından ne zaman değiştirildiğini gösterir.

```bash
git shortlog -sn
```
Katkıda bulunanları commit sayısına göre sıralar.

---

## ⏪ Geri Alma

```bash
git restore <dosya>
```
Dosyadaki değişiklikleri geri alır (son commite döner). ⚠️ Geri alınamaz.

```bash
git restore --staged <dosya>
```
Dosyayı stage'den çıkarır ama değişiklikleri korur.

```bash
git restore .
```
Tüm değişiklikleri geri alır.

```bash
git revert <commit-id>
```
Belirtilen commiti geri alan yeni bir commit oluşturur. Geçmişi bozmaz, takım projelerinde güvenlidir.

```bash
git revert HEAD
```
Son commiti geri alır.

```bash
git reset --soft HEAD~1
```
Son commiti geri alır ama değişiklikler stage'de kalır. Commit mesajını değiştirmek istediğinde kullanışlıdır.

```bash
git reset --mixed HEAD~1
```
Son commiti geri alır, değişiklikler çalışma dizininde kalır ama stage'e alınmamış olur.

```bash
git reset --hard HEAD~1
```
Son commiti ve tüm değişiklikleri tamamen siler. ⚠️ Dikkatli kullan, geri alınamaz.

```bash
git clean -fd
```
Takip edilmeyen dosya ve klasörleri siler. ⚠️ Dikkatli kullan.

```bash
git clean -n
```
Silinecek dosyaları gösterir ama silmez. `git clean -fd` öncesinde kontrol için kullanılır.

---

## 🗃️ Stash (Geçici Saklama)

```bash
git stash
```
Yarım kalan değişiklikleri geçici olarak saklar, çalışma alanını temizler.

```bash
git stash push -m "açıklama"
```
Açıklamalı stash oluşturur.

```bash
git stash list
```
Tüm stash'leri listeler.

```bash
git stash pop
```
En son stash'i geri getirir ve listeden siler.

```bash
git stash apply stash@{2}
```
Belirli bir stash'i uygular ama listeden silmez.

```bash
git stash drop stash@{0}
```
Belirli bir stash'i listeden siler.

```bash
git stash clear
```
Tüm stash'leri siler.

```bash
git stash branch <yeni-branch>
```
Stash'i yeni bir branchte uygular.

---

## 🔀 Merge & Rebase

```bash
git merge <branch>
```
Belirtilen branchi mevcut branchle birleştirir. Yeni bir "merge commit" oluşturur.

```bash
git merge --no-ff <branch>
```
Fast-forward mümkün olsa bile merge commit oluşturmayı zorlar. Geçmişin okunabilirliğini artırır.

```bash
git merge --squash <branch>
```
Branchteki tüm commitleri tek bir commit olarak birleştirir.

```bash
git merge --abort
```
Çakışmalı merge işlemini iptal eder, önceki duruma döner.

```bash
git rebase <branch>
```
Mevcut branch'in commit geçmişini hedef branchin üstüne taşır. Daha doğrusal bir geçmiş oluşturur.

```bash
git rebase -i HEAD~3
```
Son 3 commiti interaktif olarak düzenlemeni sağlar. Commitleri birleştirme, sıralama veya silme için güçlü bir araç.

```bash
git rebase --abort
```
Rebase işlemini iptal eder.

```bash
git rebase --continue
```
Çakışmaları çözdükten sonra rebase'e devam eder.

```bash
git cherry-pick <commit-id>
```
Başka bir branchdeki belirli bir commiti mevcut branche uygular.

```bash
git cherry-pick <commit1>..<commit2>
```
Belirli bir commit aralığını mevcut branche uygular.

---

## 🏷️ Tag (Etiket) İşlemleri

```bash
git tag
```
Tüm tagleri listeler.

```bash
git tag <isim>
```
Mevcut commite hafif (lightweight) tag ekler.
```bash
git tag v1.0.0
```

```bash
git tag -a v1.0.0 -m "Sürüm 1.0.0"
```
Açıklamalı (annotated) tag oluşturur. Yazar, tarih ve mesaj içerir.

```bash
git tag -a v1.0.0 <commit-id>
```
Belirli bir commite tag ekler.

```bash
git push origin <tag-adi>
```
Belirli bir tagi uzak repoya gönderir.

```bash
git push origin --tags
```
Tüm tagleri uzak repoya gönderir.

```bash
git tag -d <isim>
```
Yerel tagi siler.

```bash
git push origin --delete <tag-adi>
```
Uzak repodaki tagi siler.

---

## ⚙️ Gelişmiş Komutlar

```bash
git bisect start
git bisect bad
git bisect good <commit-id>
```
İkili arama ile hangi commitin bir hatayı ortaya çıkardığını bulur. Çok sayıda commit arasında hata avı için idealdir.

```bash
git reflog
```
Tüm yerel Git işlemlerinin geçmişini gösterir. Yanlışlıkla silinen commitler bile buradan kurtarılabilir.

```bash
git reflog expire --expire=now --all && git gc --prune=now
```
Gereksiz Git nesnelerini temizler ve repoyu sıkıştırır.

```bash
git submodule add <url>
```
Projeye başka bir Git reposunu alt modül olarak ekler.

```bash
git submodule update --init --recursive
```
Tüm alt modülleri başlatır ve günceller.

```bash
git worktree add <klasor> <branch>
```
Aynı repoyu farklı klasörlerde birden fazla branchle aynı anda açmayı sağlar.

```bash
git archive --format=zip HEAD > proje.zip
```
Mevcut reponun son halini zip dosyası olarak dışa aktarır.

```bash
git grep "aranacak-kelime"
```
Repodaki tüm dosyalarda belirtilen ifadeyi arar. `grep`'ten çok daha hızlıdır.

```bash
git shortlog -sn --all
```
Tüm katkıda bulunanları commit sayısına göre sıralar.

---

## 🎛️ Konfigürasyon & Alias

Sık kullandığın komutlara kısayol tanımlamak için alias'lar oluşturabilirsin:

```bash
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.lg "log --oneline --graph --all --decorate"
git config --global alias.undo "reset --soft HEAD~1"
git config --global alias.unstage "restore --staged"
```

Artık şunları kullanabilirsin:
```bash
git st         # git status
git co main    # git checkout main
git lg         # güzel geçmiş görünümü
git undo       # son commiti geri al
```

---

## 🚀 Tipik İş Akışları

### Yeni Özellik Geliştirme

```bash
git checkout main
git pull                              # En güncel kodu al
git checkout -b feature/yeni-ozellik  # Branch oluştur
# ... kodları yaz ...
git add .
git commit -m "feat: yeni özellik eklendi"
git push -u origin feature/yeni-ozellik
# Pull Request / Merge Request aç
```

### Hata Düzeltme

```bash
git checkout main
git pull
git checkout -b fix/giris-hatasi
# ... hatayı düzelt ...
git add .
git commit -m "fix: giriş ekranındaki hata düzeltildi"
git push -u origin fix/giris-hatasi
```

### Yanlışlıkla Silinen Commiti Kurtarma

```bash
git reflog                   # Kayıp commiti bul
git checkout -b kurtarma <commit-id>  # O commite dön
```

### Temiz Commit Geçmişi (Squash)

```bash
git rebase -i HEAD~4         # Son 4 commiti düzenle
# Editörde "squash" veya "s" yazarak commitleri birleştir
```

---

## 📌 Özet Tablo

| Komut | Ne Yapar |
|-------|----------|
| `git init` | Repo başlatır |
| `git clone` | Repoyu kopyalar |
| `git add` | Değişiklikleri hazırlar |
| `git commit` | Değişiklikleri kaydeder |
| `git push` | Uzak repoya gönderir |
| `git pull` | Uzak repodan çeker |
| `git branch` | Branch listeler/oluşturur |
| `git merge` | Branchleri birleştirir |
| `git rebase` | Geçmişi yeniden düzenler |
| `git stash` | Değişiklikleri saklar |
| `git log` | Geçmişi gösterir |
| `git diff` | Farkları gösterir |
| `git revert` | Commiti güvenle geri alır |
| `git reset` | Commiti siler |
| `git tag` | Sürüm etiketler |
| `git reflog` | Tüm işlem geçmişini gösterir |

---

> 💡 **İpucu:** Herhangi bir komut hakkında yardım almak için `git help <komut>` veya `git <komut> --help` kullanabilirsin.
