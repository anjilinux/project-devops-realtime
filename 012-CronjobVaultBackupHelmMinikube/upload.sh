#/bin/sh

ls -trl /backup

VAULT_BACKUP_FILE=/backup/$(ls /backup|grep vault)
if [ -f "$VAULT_BACKUP_FILE" ] && [ -s "$VAULT_BACKUP_FILE" ]  
then 
    cat $VAULT_BACKUP_FILE
    echo "$VAULT_BACKUP_FILE exists! Backing up now..." 
else 
    echo "Backup fails! Either the file doesn't exist or it is empty. Please check your script!" && exit 2
fi

mc alias set local-minio http://$MINIO_ADDR:9000 $MINIO_USERNAME $MINIO_PASSWORD
mc cp --recursive /backup/* local-minio/$BUCKET_NAME