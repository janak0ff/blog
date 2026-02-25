---
title: Building a Production-Grade Observability Stack from Scratch - A Week in the Trenches
date: 2026-02-25
categories: [observability]
image:
  path: /assets/img/Screenshot_20250627_141614.png
  lqip: data:image/webp;base64,UklGRpoAAABXRUJQVlA4WAoAAAAQAAAADwAABwAAQUxQSDIAAAARL0AmbZurmr57yyIiqE8oiG0bejIYEQTgqiDA9vqnsUSI6H+oAERp2HZ65qP/VIAWAFZQOCBCAAAA8AEAnQEqEAAIAAVAfCWkAALp8sF8rgRgAP7o9FDvMCkMde9PK7euH5M1m6VWoDXf2FkP3BqV0ZYbO6NA/VFIAAAA
  alt: Building a Production-Grade Observability Stack from Scratch - A Week in the Trenches
tags:
  - observability
  - Hands On Lab
  - grafana
  - prometheus
  - loki
  - alertmanager
  - alloy


pin: true
description: A deep dive into building a full-featured monitoring and logging system using Prometheus, Grafana, Loki, Alertmanager, and more.
---

# Building a Production-Grade Observability Stack from Scratch: A Week in the Trenches

*A deep dive into building a full-featured monitoring and logging system using Prometheus, Grafana, Loki, Alertmanager, and more.*

---

## Why I Built This

Modern infrastructure is only as reliable as your ability to observe it. After weeks of running workloads across distributed servers without real insight into what they were doing, I decided to invest a full week building a production-grade observability stack from scratch.

The goal was clear: a single, centralized monitoring platform that could tell me — in real time — exactly what is happening on every server, inside every Docker container, and across every key application. If something breaks, I want an email the moment it happens. When it recovers, I want to know that too.

One week later, I have exactly that.

---

## The Architecture

At the heart of the project is a **Client-Server architecture**. A central Monitor Server runs the core observability components. Any number of client nodes — whether on AWS EC2, on-premise, or anywhere else — run lightweight agents that push metrics and logs to the Monitor.

```
[Client Node]
  Node Exporter       → Prometheus (CPU, RAM, disk, network)
  Process Exporter    → Prometheus (per-process metrics)
  cAdvisor            → Prometheus (container metrics)
  Grafana Alloy       → Loki (logs) + Prometheus (metrics)
  Jenkins Exporter    → Prometheus (jenkins metrics)
  Nginx Exporter      → Prometheus (nginx metrics)
  MongoDB Exporter    → Prometheus (mongodb metrics)
```

![output](/assets/img/monitoring/lazydocker-client.png)

```
[Monitor Server]
  Prometheus          → Grafana (visualize)
  Loki                → Grafana (logs)
  Alertmanager        → Email (alerts)
  Grafana             → Dashboards
```

![output](/assets/img/monitoring/server-lazydocker.png)

Everything lives inside Docker Compose for clean, reproducible deployments. One `.env` file per node controls the entire configuration — endpoints, credentials, environments, ports, storage backends — everything.

---

## What Gets Monitored

### System & OS Metrics (Node Exporter)
Every client node exposes CPU usage, RAM utilization, disk I/O, filesystem usage, and network throughput in real time. These are the metrics that trigger CPUUsageHigh and MemoryUsageHigh alerts when sustained thresholds are crossed.

![output](/assets/img/monitoring/node-exporter-full.png)

### Per-Process Metrics (Process Exporter)
Beyond top-level CPU and RAM, the process exporter tracks individual processes — how much CPU a specific daemon is consuming, its open file descriptors, its memory footprint — giving a surgical view into what exactly is causing load.

![output](/assets/img/monitoring/process-exporter.png)

### Container Metrics (cAdvisor)
Rather than just seeing that "Docker is using too much memory", cAdvisor breaks down resource usage **per container**: CPU throttling, network I/O per container, and memory limits vs. actual usage. Jenkins eating your RAM? cAdvisor catches it.

![output](/assets/img/monitoring/cAdvisor-dashboard.png)

### Container Logs and Metrics (Grafana Alloy)
Grafana Alloy is the Swiss Army knife of the client stack. It:
- Reads `/var/log/*` and pushes system logs to Loki.
- Reads Docker container logs (via the Docker socket) and pushes them to Loki, labeled by container name.
- Scrapes Docker daemon metrics (`127.0.0.1:9323`) and remote-writes them to Prometheus.

Every log line from every container on every node lands in a central Loki instance, queryable via LogQL in Grafana.


### Grafana Alloy Graph
![output](/assets/img/monitoring/alloy.png)

### Application-Layer Metrics
The stack ships with optional exporters for the most common workloads, enabled via Docker Compose profiles:
- **Nginx Exporter** — Request rates, connection counts, active worker count. Uses Nginx's built-in `stub_status` endpoint.

![output](/assets/img/monitoring/nginx-dashboard.png)

- **Jenkins Exporter** — Build queue depth, job health, executor utilization.

![output](/assets/img/monitoring/jenkins-dashboard.png)

- **MongoDB Exporter** — Connection pool, query performance, operation counters (via `percona/mongodb_exporter`).

![output](/assets/img/monitoring/grafana-mongodb-dashboard.png)

- **PostgreSQL, MySQL, Redis** — All pre-wired and disabled by default. Enable with a single profile flag.

---

## Log Management with Loki

All logs — system logs, application logs, Docker container logs — are aggregated by Grafana Alloy and pushed into Loki. Loki indexes logs by **labels** (hostname, environment, container name, log level) rather than the full text, making it incredibly storage-efficient.

![output](/assets/img/monitoring/loki-explorer.png)

### Switching Storage Backends with One Line
By default, Loki stores logs locally. Switching to AWS S3 for persistent, scalable cloud storage requires only updating a single variable in the `.env` file:

```env
LOKI_STORAGE_TYPE=s3       # was: filesystem
LOKI_BUCKET_NAME=my-bucket
AWS_REGION=us-east-1
```

Restart Loki, and all new logs go directly to S3. The bucket also has a 30-day lifecycle policy attached, automatically expiring old log chunks without manual cleanup.

![output](/assets/img/monitoring/awss2lokibuccket.png)
![output](/assets/img/monitoring/clis3bucket.png)
---

## Service Discovery — Two Modes

### File SD (Manual / On-Premise)
For nodes not on AWS, the stack uses Prometheus File Service Discovery. The Monitor server maintains a single JSON file, `prometheus/targets/clients.json`. Two shell scripts manage it:

#### Adding and removing nodes

```bash
# Register a new node (or add optional exporters)
./scripts/add-node.sh 34.230.91.8 web-frontend production --nginx

# Decommission a node
./scripts/remove-node.sh web-frontend
```

Prometheus detects the JSON file change within 30 seconds. No restarts, no downtime.

### EC2 Service Discovery (Automated)
For AWS-native deployments, Prometheus can self-discover EC2 instances based on resource tags:
- Tag an instance with `Scrape=true` and `Name=aws-node-01`.
- Prometheus queries the EC2 API every 60 seconds and automatically begins scraping it.
- Remove the tag, and scraping stops — automatically.

No static IPs. No manual config file edits.
![output](/assets/img/monitoring/aws-ec2-sd.png)

#### AWS ec2 console
![output](/assets/img/monitoring/aws-ec2-clonsole.png)


#### File Service Discovery
![output](/assets/img/monitoring/promethus-file-sd.png)

### Prometheus targets
![output](/assets/img/monitoring/promethus-target.png)

---

## Alerting

### Grafana Alertmanager
This is where the project really comes together. Alertmanager handles all alert routing. It is configured via SMTP to send emails for every event — and it distinguishes between two lifecycle states for every alert:

![output](/assets/img/monitoring/alert-pending-and-fireing.png)
![output](/assets/img/monitoring/alertmanager-nodedown.png)

Alertmanager sends a mail when the alert is **FIRING** and another mail when the alert is **RESOLVED**.

![output](/assets/img/monitoring/email.png)

### Firing Alerts (Something is Wrong)
| Alert | Condition |
|---|---|
| `HighCPUUsage` | CPU above 80% sustained for 5 minutes |
| `HighMemoryUsage` | RAM above 85% sustained for 5 minutes |
| `HighDiskUsage` | Filesystem above 85% used |
| `NodeDown` | A target becomes unreachable for 2 minutes |
| `ContainerDown` | A Docker container exits unexpectedly |

#### Mail Alert for NodeDown and high CPU Usage
![output](/assets/img/monitoring/alert-node-down.jpg)
![output](/assets/img/monitoring/alert-high-cpu-warn.jpg)

### Resolved Alerts (Issue Recovered)
When the condition returns to normal, Alertmanager sends a second email automatically flagging the alert as **RESOLVED** — so there's no guessing whether the issue is still ongoing or not. You get a clear timeline: when it broke, and exactly when it fixed itself.

This behaviour required no extra code. Alertmanager's `send_resolved: true` configuration handles it natively.

![output](/assets/img/monitoring/alert-node-up.jpg)
![output](/assets/img/monitoring/alert-highcpu-resolved.jpg)

---

## Dashboards

On day one of the project being live, I had immediate visibility across the entire infrastructure through pre-imported Grafana dashboards:

| Dashboard | Grafana ID |
|---|---|
| Full Node Exporter (OS Metrics) | 1860 |
| Docker Container & Node Overview | 16314 |
| cAdvisor Docker Insights | 19908 |
| Jenkins Health & Performance | 9964 |
| Nginx Request Rates | 12708 |
| SSH Login Audit Logs | 17514 |
| Application Log Explorer | 13639 |
| MongoDB Overview | 2583 |

### Docker container overview
![output](/assets/img/monitoring/server-grafana.png)

### Auth logs dashboard
![output](/assets/img/monitoring/ssh-log-dashboard.png)

---

## What I Learned

**1. Complexity hides in credentials.** AWS Academy's short-lived session tokens (`AWS_SESSION_TOKEN`) were my biggest headache — they expire every 4 hours, which breaks Loki's S3 connection silently. Building a pattern for rotating them quickly became critical.

**2. Prometheus does not expand environment variables inside `ec2_sd_configs`.** Unlike the rest of `prometheus.yml`, the `region` field inside EC2 SD must be hardcoded — `${VAR}` syntax is silently ignored. Spent more time on this than I care to admit.

**3. `host.docker.internal` is your best friend.** Without it, no Docker container can reach services running on the host OS. This was the root cause of `nginx_up 0` that had me confused for longer than it should have.

**4. Labeling is everything in Loki.** A well-labeled log is worth 100 unlabeled ones. Setting `NODE_HOSTNAME`, `environment`, and `container_name` labels correctly on every log stream is what makes Grafana's log queries fast and readable.

---

## Wrapping Up

This project isn't a toy. It's a fully battle-hardened, modular monitoring system that I now run on production infrastructure. The `.env`-driven configuration model means it deploys cleanly to any new server in minutes.

If you want to explore the full source code, configuration breakdown, and step-by-step deployment guides, the complete project is available on GitHub.

**GitHub Repo:** [github.com/janak0ff/observability](https://github.com/janak0ff/observability)

---