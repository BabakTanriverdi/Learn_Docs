#!/bin/bash

# Kullanıcıdan tarih bilgisi al
read -p "Tarih girin (örn: 2025-10-22 14:26:31 +0200): " D

# Kullanıcıdan commit mesajı al
read -p "Commit mesajı girin: " MSG

# Script'in çalıştırıldığı klasördeki değişen dosyaları listele
# Sadece değişen dosyalardan ilkini commit mesajına dahil etmek istersen:
FILE=$(git status --porcelain | awk '{print $2}')

if [ -z "$FILE" ]; then
    echo "Herhangi bir değişiklik yok!"
    exit 1
fi

echo "İşlenecek dosya: $FILE"

# Git işlemleri
git add .

GIT_AUTHOR_DATE="$D" GIT_COMMITTER_DATE="$D" git commit -m "$MSG"

# Push
git push

echo "✔ Git push tamamlandı!"
