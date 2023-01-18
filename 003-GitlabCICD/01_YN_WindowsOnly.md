# Project 003: Gitlab CICD Pipeline

Windows only

Works?

## Steps

## 1. Run the docker containers with **docker compose**

Docker login with the GitHub token

```bash
docker login ghcr.io -u briansu2004
```

Docker compose

```bash
git clone https://github.com/briansu2004/udemy-devops-9projects-free.git
cd udemy-devops-9projects-free/003-GitlabCICD
docker compose up -d
```

## 2. Add below entry in your **hosts** file (skip???)

Windows: `C:\Windows\System32\drivers\etc\hosts`

Unix / Mac: `/etc/hosts`

Once it is done, open your **browser** and go to <<https://<your_gitlab_domain_name>>>

(e.g. <https://gitlab.mydevopsrealprojects.com/>)

```bash
<GITLAB SERVER IP>  <YOUR DOMAIN NAME in docker-compose.yaml> 
# For example
# 192.168.2.61 gitlab.mydevopsrealprojects.com registry.gitlab.mydevopsrealprojects.com
# 127.0.0.1 gitlab.mydevopsrealprojects.com 
# 127.0.0.1 registry.gitlab.mydevopsrealprojects.com
```

NOTE: if you are trying to use `localhost` as domain name, you have to use following command to get the ip mapping of the host. see detail in [post](https://stackoverflow.com/questions/24319662/from-inside-of-a-docker-container-how-do-i-connect-to-the-localhost-of-the-mach):

```bash
# in the host machine
$ sudo ip addr show docker0
  docker0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
    link/ether 56:84:7a:fe:97:99 brd ff:ff:ff:ff:ff:ff
    inet 172.17.42.1/16 scope global docker0
       valid_lft forever preferred_lft forever
    inet6 fe80::5484:7aff:fefe:9799/64 scope link
       valid_lft forever preferred_lft forever
```

In the example, `inet 172.17.42.1/16` will be the mapping of host machine. Then in the `/etc/hosts` you can add entry as following:

```bash
# example 
# 172.17.42.1 gitlab.localhost  registry.gitlab.localhost
```

The main reason here is `localhost` or `127.0.0.1` will also be specified by containers network. if you update `/etc/hosts` with `127.0.0.1  localhost gitlab.localhost  registry.gitlab.localhost`, the container will try to treat itself as `localhost` in stead of host machine.

## 3. Login to your gitlab web

Wait for about **5 mins** for the server to fully start up.

Then login to the **Gitlab website (<<https://<YOUR_GITLAB_SERVER_IP>>>)** with the username `root` and the password defined in your `docker-compose.yaml`, which should be the value for env varible `GITLAB_ROOT_PASSWORD`.

[https://127.0.0.1](https://127.0.0.1/users/sign_in)

```dos
C:\CodeUdemy\udemy-devops-9projects-free\003-GitlabCICD>docker ps -a
CONTAINER ID   IMAGE                                 COMMAND                  CREATED          STATUS                             PORTS                                                                                    NAMES  
9f049a205ad7   gitlab/gitlab-ce:latest               "/assets/wrapper"        16 seconds ago   Up 15 seconds (health: starting)   0.0.0.0:80->80/tcp, 0.0.0.0:443->443/tcp, 0.0.0.0:8822->22/tcp, 0.0.0.0:5055->5005/tcp   003-gitlabcicd-web-1
bf6624516357   ghcr.io/briansu2004/colorweb:latest   "python app.py"          16 seconds ago   Up 15 seconds                      0.0.0.0:8080->8080/tcp                                                                   003-gitlabcicd-hello-world-1
083dcb12441c   gitlab/gitlab-runner:latest           "/usr/bin/dumb-init …"   16 seconds ago   Up 15 seconds                                                                                                               003-gitlabcicd-gitlab-runner-1

C:\CodeUdemy\udemy-devops-9projects-free\003-GitlabCICD>docker exec -it 003-gitlabcicd-web-1 ls -la /etc/gitlab/ 
total 196
drwxrwxr-x 3 root root   4096 Jan 18 21:54 .
drwxr-xr-x 1 root root   4096 Jan 18 21:53 ..
-rw------- 1 root root  19345 Jan 18 21:55 gitlab-secrets.json
-rw------- 1 root root 139976 Jan 18 21:53 gitlab.rb
-rw------- 1 root root    537 Jan 18 21:53 ssh_host_ecdsa_key
-rw-r--r-- 1 root root    198 Jan 18 21:53 ssh_host_ecdsa_key.pub
-rw------- 1 root root    432 Jan 18 21:53 ssh_host_ed25519_key
-rw-r--r-- 1 root root    118 Jan 18 21:53 ssh_host_ed25519_key.pub
-rw------- 1 root root   2635 Jan 18 21:53 ssh_host_rsa_key
-rw-r--r-- 1 root root    590 Jan 18 21:53 ssh_host_rsa_key.pub
drwxr-xr-x 2 root root   4096 Jan 18 21:54 trusted-certs

C:\CodeUdemy\udemy-devops-9projects-free\003-GitlabCICD>docker exec -it 003-gitlabcicd-web-1 bash                                             
root@gitlab:/# cat /etc/gitlab/gitlab-secrets.json | grep pass
    "admin_password": "c8db17a025a5bef188e501f62a5391f1",
    "metrics_basic_auth_password": null,

root@gitlab:/etc/gitlab# cat gitlab.rb | grep root
# gitlab_rails['initial_root_password'] = "password"
#### Toggle if root password should be printed to STDOUT during initialization
# gitlab_rails['display_initial_root_password'] = false
#### Toggle if initial root password should be written to /etc/gitlab/initial_root_password
# gitlab_rails['store_initial_root_password'] = true
# gitlab_rails['db_sslrootcert'] = nil
# registry['rootcertbundle'] = "/var/opt/gitlab/registry/certificate.crt"
# gitlab_workhorse['alt_document_root'] = nil
##! Most root CA's are included by default
# gitaly['cgroups_hierarchy_root'] = 'gitaly'
# praefect['database_sslrootcert'] = '/path/to/rootcert'
# praefect['database_direct_sslrootcert'] = '/path/to/rootcert'
# letsencrypt['group'] = 'root'
# letsencrypt['owner'] = 'root'
# letsencrypt['wwwroot'] = '/var/opt/gitlab/nginx/www'
# geo_secondary['db_sslrootcert'] = nil

root@gitlab:/etc/gitlab# vi gitlab.rb

# gitlab_rails['initial_root_password'] = "password"
->
gitlab_rails['initial_root_password'] = "password"

# gitlab_rails['display_initial_root_password'] = false
->
gitlab_rails['display_initial_root_password'] = true

# gitlab_rails['store_initial_root_password'] = true
->
gitlab_rails['store_initial_root_password'] = true

root@gitlab:/etc/gitlab# gitlab-ctl reconfigure
...
Running handlers complete
[2023-01-18T22:20:11+00:00] INFO: Report handlers complete
Infra Phase complete, 0/734 resources updated in 12 seconds
gitlab Reconfigured!

root@gitlab:/etc/gitlab# gitlab-ctl restart
ok: run: alertmanager: (pid 2534) 0s
ok: run: gitaly: (pid 2546) 0s
ok: run: gitlab-exporter: (pid 2567) 1s
ok: run: gitlab-kas: (pid 2658) 0s
ok: run: gitlab-workhorse: (pid 2670) 0s
ok: run: logrotate: (pid 2686) 0s
ok: run: nginx: (pid 2692) 1s
ok: run: postgres-exporter: (pid 2704) 0s
ok: run: postgresql: (pid 2713) 1s
ok: run: prometheus: (pid 2722) 0s
timeout: run: puma: (pid 1865) 220s
ok: run: redis: (pid 2778) 0s
ok: run: redis-exporter: (pid 2784) 1s
ok: run: sidekiq: (pid 2793) 0s
ok: run: sshd: (pid 2799) 0s
```

<https://docs.gitlab.cn/14.0/omnibus/settings/configuration.html>


```dos
docker login registry.gitlab.mydevopsrealprojects.com:5005


/etc/gitlab/initial_root_password

root@gitlab:/etc/gitlab# cat *.json | grep pass
    "admin_password": "cbbc2e845c53d8dd685938f04e6b9c2c",
    "metrics_basic_auth_password": null,
```

Click **"New project"** to create your first project -> Click **"Create blank project"** -> Type your project name in **"Project Name"** -> Select **"Public"** and click **"Create project"** -> Go to the new project you just created, and go to **"Setting"** -> **"CI/CD"** -> expand **"Runners"** section. **Make a note** of **"URL** and **registration token** in **"Specific runners"** section for below runner installation used

## 4. Update certificates

Since the initial Gitlab server **certificate** is missing some info and cannot be used by gitlab runner, we may have to **regenerate** a new one and **reconfigure** in the gitlab server. Run below commands:

```bash
docker exec -it $(docker ps -f name=web -q) bash
mkdir /etc/gitlab/ssl_backup
mv /etc/gitlab/ssl/* /etc/gitlab/ssl_backup
cd /etc/gitlab/ssl
openssl genrsa -out ca.key 2048
openssl req -new -x509 -days 365 -key ca.key -subj "/C=CN/ST=GD/L=SZ/O=Acme, Inc./CN=Acme Root CA" -out ca.crt

# Note: Make sure to replace below `YOUR_GITLAB_DOMAIN` with your own domain name. For example, mydevopsrealprojects.com.

export YOUR_GITLAB_DOMAIN=mydevopsrealprojects.com
openssl req -newkey rsa:2048 -nodes -keyout gitlab.$YOUR_GITLAB_DOMAIN.key -subj "/C=CN/ST=GD/L=SZ/O=Acme, Inc./CN=*.$YOUR_GITLAB_DOMAIN" -out gitlab.$YOUR_GITLAB_DOMAIN.csr
openssl x509 -req -extfile <(printf "subjectAltName=DNS:$YOUR_GITLAB_DOMAIN,DNS:gitlab.$YOUR_GITLAB_DOMAIN") -days 365 -in gitlab.$YOUR_GITLAB_DOMAIN.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out gitlab.$YOUR_GITLAB_DOMAIN.crt

# Certificate for nginx (container registry)
openssl req -newkey rsa:2048 -nodes -keyout registry.gitlab.$YOUR_GITLAB_DOMAIN.key -subj "/C=CN/ST=GD/L=SZ/O=Acme, Inc./CN=*.$YOUR_GITLAB_DOMAIN" -out registry.gitlab.$YOUR_GITLAB_DOMAIN.csr
openssl x509 -req -extfile <(printf "subjectAltName=DNS:$YOUR_GITLAB_DOMAIN,DNS:gitlab.$YOUR_GITLAB_DOMAIN,DNS:registry.gitlab.$YOUR_GITLAB_DOMAIN") -days 365 -in registry.gitlab.$YOUR_GITLAB_DOMAIN.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out registry.gitlab.$YOUR_GITLAB_DOMAIN.crt
# Note: You can reconfigure/restart the gitlab in next step as well if you want
gitlab-ctl reconfigure
gitlab-ctl restart
exit
```

## 5. Enable **container register**

Add below lines in the bottom of the file `/etc/gitlab/gitlab.rb`.

```bash
docker exec -it $(docker ps -f name=web -q) bash
# Note: Make sure to replace below `YOUR_GITLAB_DOMAIN` with your own domain name. For example, mydevopsrealprojects.com
export YOUR_GITLAB_DOMAIN=mydevopsrealprojects.com
cat >> /etc/gitlab/gitlab.rb <<EOF

 registry_external_url 'https://registry.gitlab.$YOUR_GITLAB_DOMAIN:5005'
 gitlab_rails['registry_enabled'] = true
 gitlab_rails['registry_host'] = "registry.gitlab.$YOUR_GITLAB_DOMAIN"
 gitlab_rails['registry_port'] = "5005"
 gitlab_rails['registry_path'] = "/var/opt/gitlab/gitlab-rails/shared/registry"
 gitlab_rails['registry_api_url'] = "http://127.0.0.1:5000"
 gitlab_rails['registry_key_path'] = "/var/opt/gitlab/gitlab-rails/certificate.key"
 registry['enable'] = true
 registry['registry_http_addr'] = "127.0.0.1:5000"
 registry['log_directory'] = "/var/log/gitlab/registry"
 registry['env_directory'] = "/opt/gitlab/etc/registry/env"
 registry['env'] = {
   'SSL_CERT_DIR' => "/opt/gitlab/embedded/ssl/certs/"
 }
 # Note: Make sure to update below 'rootcertbundle' default value 'certificate.crt" to 'gitlab-registry.crt', otherwise you may get error.
 registry['rootcertbundle'] = "/var/opt/gitlab/registry/gitlab-registry.crt"
 nginx['ssl_certificate'] = "/etc/gitlab/ssl/registry.gitlab.$YOUR_GITLAB_DOMAIN.crt"
 nginx['ssl_certificate_key'] = "/etc/gitlab/ssl/registry.gitlab.$YOUR_GITLAB_DOMAIN.key"
 registry_nginx['enable'] = true
 registry_nginx['listen_port'] = 5005
EOF

# Reconfigure the gitlab to apply above change
gitlab-ctl reconfigure
gitlab-ctl restart
exit
```

## 6. Update certificates for docker client

In order to make **docker login** work, you need to add the **certificate** in docker certs folder

```bash
# Login the host you are going to run the docker commands
export YOUR_GITLAB_DOMAIN=mydevopsrealprojects.com
sudo mkdir -p /etc/docker/certs.d/registry.gitlab.$YOUR_GITLAB_DOMAIN:5005
sudo docker cp $(docker ps -f name=web -q):/etc/gitlab/ssl/registry.gitlab.$YOUR_GITLAB_DOMAIN.crt /etc/docker/certs.d/registry.gitlab.$YOUR_GITLAB_DOMAIN:5005/
sudo ls /etc/docker/certs.d/registry.gitlab.$YOUR_GITLAB_DOMAIN:5005

# Test docker login and you should be able to login now
docker login registry.gitlab.$YOUR_GITLAB_DOMAIN:5005
Username: root
Password: 
WARNING! Your password will be stored unencrypted in /home/devops/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store

Login Succeeded

# You can also test if the docker image push works once login successfully
# Login to your gitlab server web UI and go to the project you created, and then go to "Packages and registries" -> "Container Registry", you should be able to see the valid registry URL you suppose to use in order to build and push your image. For example, `docker build -t registry.gitlab.mydevopsrealprojects.com:5005/gitlab-instance-d350f73c/first-projct .` (See below screenshot)
```

![container-registry](images/container-registry.png)

## 7. Configure **gitlab-runner**

Login to gitlab-runner and run commands below. Please note the tag below has to match with the `tags` section in `.gitlab-ci.yml` file:

```bash
export YOUR_GITLAB_DOMAIN=mydevopsrealprojects.com
docker exec $(docker ps -f name=web -q) cat /etc/gitlab/ssl/gitlab.$YOUR_GITLAB_DOMAIN.crt
docker exec $(docker ps -f name=web -q) cat /etc/gitlab/ssl/registry.gitlab.$YOUR_GITLAB_DOMAIN.crt
docker exec -it $(docker ps -f name=gitlab-runner -q) bash
cat > /usr/local/share/ca-certificates/gitlab-server.crt <<EOF
# <Paste above gitlab server certificate here>
EOF

cat > /usr/local/share/ca-certificates/registry.gitlab-server.crt <<EOF
# <Paste above gitlab registry certificate here>
EOF

update-ca-certificates
gitlab-runner register 
# Enter the GitLab instance URL (for example, https://<YOUR_GITLAB_DOMAIN>(i.g. https://gitlab.mydevopsrealprojects.com)

Enter the registration token:
<Paste the token retrieved in Step 3>

Enter a description for the runner:
[bad518d25b44]: test

# HERE tag below has to match with tags in .gitlab-ci.yml
Enter tags for the runner (comma-separated):
test

Enter optional maintenance note for the runner:
test

Registering runner... succeeded                     runner=GR1348941Pjv5Qzaz
Enter an executor: ssh, docker+machine, docker-ssh, docker, parallels, shell, virtualbox, docker-ssh+machine, kubernetes, custom:
shell
```

If success, you will see below message:

```bash
Runner registered successfully. Feel free to start it, but if it's running already the config should be automatically reloaded!

Configuration (with the authentication token) was saved in "/etc/gitlab-runner/config.toml" 
root@bad518d25b44:/usr/local/share/ca-certificates# cat /etc/gitlab-runner/config.toml 
```

Once you finish above step, you should be able to see an available running in the project's CICD Runners section (see below screenshoot).
![gitlab-runner](images/gitlab-runner.jpg)

## 8. Copy necessary files into gitlab project repo

**Git clone** from your gitlab project repo to your local and copy necessary files from our devopsdaydayup lab repo (in the same folder as this README.md)

```bash
git clone <URL from your gitlab server repo>
cd <your project name folder>
cp /path/to/devopsdaydayup/003-GitlabCICD/{app.py,Dockerfile,requirements.txt,.gitlab-ci.yaml,.gitlab-ci.yml}  <your gitlab repo>
git add .
git commit -am "First commit"
git push
```

Once you push the code, you should be able to see the pipeline is automatically triggered under the project -> "CI/CD" -> "Jobs"
![gitlab-ci-pipeline](images/gitlab-ci-pipeline.png)

## 9. Verification

a. Check your hello-world container by visiting the **website** <http://<HOST> IP which is running the docker-compose.yaml>:8080

b. In your **gitlab repo**, update `return "Hello World!"` in `app.py` file. For example, update to `return "Hello World 2022!"`. Save the change and `git add .` and `git commit -am "Update code"` and then `git push`.

c. Once the CICD pipeline is completed, you can visit your hello-world web again to see if the content is changed. <http://<HOST> IP which is running the docker-compose.yaml>:8080
