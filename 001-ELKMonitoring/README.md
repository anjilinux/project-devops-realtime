# Project Name: ELK Monitoring

This instruction shows how to setup a ELK (Elasticsearch/Logstash/Kibana) stack to monitor a server.

## Project Goal

Learn how to deploy a ELK with docker-compose, as well as configuring metricbeat service to collect the system metric from a server and present them in Kibana.

## Prerequisites

- Ubuntu 20.04 OS
- [Docker](https://docs.docker.com/engine/install/ubuntu/)
- [Docker Compose](https://docs.docker.com/compose/install/)

# Clean up

Run below commands to remove docker containers and volumes

```bash
docker-compose down -v
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

[With_Mac_Ubuntu](Mac_Ubuntu.md)

[With_Windows_Ubuntu](Windows_Ubuntu.md)

[With_WindowsOnly](WindowsOnly.md)
