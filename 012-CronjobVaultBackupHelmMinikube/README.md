# Lab 012: Backup Vault in Minio with a cronjob

## Lab Goal

In this lab, we will deploy a helm chart with a cronjob to backup vault periodically into the Minio storage.

<!--
## Clean up

Run below commands to remove docker containers and volumes

```bash
sudo docker compose down -v
sudo systemctl stop metricbeat
sudo systemctl disable metricbeat
sudo apt remove metricbeat
```
-->

## Environments

| #  | Env  | Y/N  | Recommended   |  Comment |
|---|---|---|---|---|
| 1 | Windows only | YN | YN |   |
| 2 | Windows + Ubuntu | N | N |   |
| 3 | Mac only | YN | YN |   |
| 4 | Mac + Ubuntu | N | N |   |

[Windows Only](01_Y_WindowsOnly.md)

<!--
[With_Windows_Ubuntu](02_N_Windows_Ubuntu.md)

[Mac Only doesn't work](03_N_MacOnly.md)

[With_Mac_Ubuntu](04_N_Mac_Ubuntu.md)
-->

<!--

PS C:\devbox\udemy-devops-14-real-projects\012-CronjobVaultBackupHelmMinikube>
>> helm install --set resources.requests.memory=512Mi --set replicas=1 --set mode=standalone --set rootUser=rootuser,rootPassword=rootpass123 --generate-name --namespace=minio minio/minio --version 5.0.5
NAME: minio-1681672110
LAST DEPLOYED: Sun Apr 16 15:08:31 2023
NAMESPACE: minio
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
MinIO can be accessed via port 9000 on the following DNS name from within your cluster:
minio-1681672110.minio.svc.cluster.local

To access MinIO from localhost, run the below commands:

  1. export POD_NAME=$(kubectl get pods --namespace minio -l "release=minio-1681672110" -o jsonpath="{.items[0].metadata.name}")

  2. kubectl port-forward $POD_NAME 9000 --namespace minio

Read more about port forwarding here: http://kubernetes.io/docs/user-guide/kubectl/kubectl_port-forward/

You can now access MinIO server on http://localhost:9000. Follow the below steps to connect to MinIO server with mc client:

  1. Download the MinIO mc client - https://min.io/docs/minio/linux/reference/minio-mc.html#quickstart

  2. export MC_HOST_minio-1681672110-local=http://$(kubectl get secret --namespace minio minio-1681672110 -o jsonpath="{.data.rootUser}" | base64 --decode):$(kubectl get secret --namespace minio minio-1681672110 -o jsonpath="{.data.rootPassword}" | base64 --decode)@localhost:9000

  3. mc ls minio-1681672110-local

MINIO_USERNAME is rootuser
MINIO_PASSWORD is rootpass123
Minio service name is minio-1681672110

MINIO_SERVICE_NAME=$(kubectl get svc -n minio -o=jsonpath={.items[0].metadata.name})
echo Minio service name is $MINIO_SERVICE_NAME

PS C:\devbox\udemy-devops-14-real-projects\012-CronjobVaultBackupHelmMinikube>
>> kubectl -n vault-test exec vault-0 -- vault operator init
Unseal Key 1: u8gyWxnd1bA//Z0j7hG19njwypXEzugFFfd19M/qFVsQ
Unseal Key 2: /CtlfZsItmqVOJiSAbqfqfNAY77nj2sTZ4EuhQ9XxQoB
Unseal Key 3: lGAQpNm2q4PlQCPDDKpAf06jp5Nr9MQ09DqrMOjATxL8
Unseal Key 4: 2YNM46IeOQVmOWeWoHsNCe5hswwOZtlQJ/0s9MFQR6c1
Unseal Key 5: m1n+PPlMrxODkShHU2OQe1UqAWAkWdMIINQUqIl+cFju

Initial Root Token: hvs.bUFbrx9qiACLK4U25lBQGvNA

Vault initialized with 5 key shares and a key threshold of 3. Please securely
distribute the key shares printed above. When the Vault is re-sealed,
restarted, or stopped, you must supply at least 3 of these keys to unseal it
before it can start servicing requests.

Vault does not store the generated root key. Without at least 3 keys to
reconstruct the root key, Vault will remain permanently sealed!

It is possible to generate new unseal keys, provided you have a quorum of
existing unseal keys shares. See "vault operator rekey" for more information.

kubectl -n vault-test exec vault-0 -- vault operator unseal u8gyWxnd1bA//Z0j7hG19njwypXEzugFFfd19M/qFVsQ
kubectl -n vault-test exec vault-0 -- vault operator unseal /CtlfZsItmqVOJiSAbqfqfNAY77nj2sTZ4EuhQ9XxQoB
kubectl -n vault-test exec vault-0 -- vault operator unseal lGAQpNm2q4PlQCPDDKpAf06jp5Nr9MQ09DqrMOjATxL8

kubectl -n vault-test exec vault-0 -- vault login hvs.bUFbrx9qiACLK4U25lBQGvNA

/tmp $ export ROLE_ID="$(vault read -field=role_id auth/approle/role/first-role/role-id)"
/tmp $
/tmp $ echo Role_ID is $ROLE_ID
Role_ID is 0f9b2e63-595c-8de5-85a7-ee5dcc64a1eb
/tmp $
/tmp $ export SECRET_ID="$(vault write -f -field=secret_id auth/approle/role/first-role/secret-id)"
/tmp $
/tmp $ echo SECRET_ID is $SECRET_ID
SECRET_ID is c8919222-5751-3324-75fd-bb13d921f7cf

https://play.min.io
https://play.min.io:9443/browser/briansutest
-->
