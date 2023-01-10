# Project Name: ELK Monitoring

This instruction shows how to setup a ELK (Elasticsearch/Logstash/Kibana) stack to monitor a server.

## Project Goal

Learn how to deploy a ELK with docker-compose, as well as configuring metricbeat service to collect the system metric from a server and present them in Kibana.

## Prerequisites

- Ubuntu 20.04 OS
- [Docker](https://docs.docker.com/engine/install/ubuntu/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Clean up

Run below commands to remove docker containers and volumes

```bash
sudo docker compose down -v
sudo systemctl stop metricbeat
sudo systemctl disable metricbeat
sudo apt remove metricbeat
```

## Reference

<https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html>

<https://kifarunix.com/monitor-linux-system-metrics-with-elk-stack/>

<https://github.com/elastic/beats/issues/29175>

<https://www.elastic.co/training/free>

## Environments

| #  | Env  | Y/N  | Recommended   |  Comment |
|---|---|---|---|---|
| 1 | Windows only | N | N |   |
| 2 | Windows + Ubuntu | Y | Y |   |
| 3 | Mac only | N | N |   |
| 4 | Mac + Ubuntu | Y | N |   |

[Windows Only doesn't work](01_N_WindowsOnly.md)

[With_Windows_Ubuntu](02_Y_Windows_Ubuntu.md)

[Mac Only doesn't work](03_N_MacOnly.md)

[With_Mac_Ubuntu](04_Y_Mac_Ubuntu.md)

Vagrant home:

- Windows

`c:\devbox`

- Mac

`~/devbox`
