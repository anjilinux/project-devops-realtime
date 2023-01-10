# The solutions for known issues

## [Vagrant] DNS issue

- Issue

```bash
vagrant@vagrant:~$  git clone https://github.com/briansu2004/udemy-devops-9projects-free.git
Cloning into 'udemy-devops-9projects-free'...
fatal: unable to access 'https://github.com/briansu2004/udemy-devops-9projects-free.git/': Could not resolve host: github.com
```

- Solution

Run below commands to stop `systemd-resolved`

```bash
sudo systemctl disable systemd-resolved
sudo systemctl stop systemd-resolved
```

Add below entry to `/etc/resolv.conf`

```bash
nameserver 8.8.8.8 
nameserver 8.8.4.4
```

## [Vagrant] Port 53 error

- Issue

...

- Solution

Same as above `[Vagrant] DNS issue`

## docker permission denied

- Issue

```bash
vagrant@vagrant:~/udemy-devops-9projects-free/001-ELKMonitoring$ docker compose up -d
permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Get "http://%2Fvar%2Frun%2Fdocker.sock/v1.24/containers/json?all=1&filters=%7B%22label%22%3A%7B%22com.docker.compose.project%3D001-elkmonitoring%22%3Atrue%7D%7D": dial unix /var/run/docker.sock: connect: permission denied
```

- Solution

`sudo chmod 666 /var/run/docker.sock`

## ?
