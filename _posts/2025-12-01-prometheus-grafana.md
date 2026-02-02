---
layout: post
title: "Monitoring the server and database with prometheus."
date: 2025-12-02 14:28 +0545
categories: ["Monitoring"]
tags: ["grafana", "prometheus"]
author: sudiplun
excerpt:
---

**litte story in short**
Have Monitoring the any system with any tool?
Alright, cool..! as in title _Prometheus_ is open-source monitoring and alerting tool that collect data and stores metric as time-series data.
How did the prometheus gets host data or specific server ? That's where the exporter comes into play.

- [node_exporter](https://github.com/prometheus/node_exporter) : for host monitoring especially the linux for the windows vm [windows_exporter](https://github.com/prometheus-community/windows_exporter)
- [mysql_exporter](https://github.com/prometheus/mysqld_exporter): for mysqld/mariadb-server monitoring

exporter expose collected date via specific url endpoint and prometheus collect process and Expose the process data via similar end-point.

to show the process data in friendly way [Grafana](https://github.com/grafana/grafana)
