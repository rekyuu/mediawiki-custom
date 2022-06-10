#! /bin/sh

TIMESTAMP=$(date -u +"%y%m%d%H%M%S")
NAME="mediawiki_backup_$TIMESTAMP"
BACKUP_FOLDER="/backups"
BACKUP_TMP_FOLDER="/tmp/backup"
BACKUP_FILENAME="$NAME.tar.gz"
BACKUP_FILEPATH="$BACKUP_FOLDER/$BACKUP_FILENAME"

mkdir -p "$BACKUP_FOLDER"
mkdir -p "$BACKUP_TMP_FOLDER" && cd "$BACKUP_TMP_FOLDER" || exit 1

cp -R "/var/www/html/images" .
cp "/var/www/html/LocalSettings.php" .
cp "/var/www/html/resources/assets/logo.png" .
cp "/var/www/html/favicon.ico" .

tar zchf "$BACKUP_FILEPATH" .

rm -rf "$BACKUP_TMP_FOLDER"

echo "$BACKUP_FILENAME"