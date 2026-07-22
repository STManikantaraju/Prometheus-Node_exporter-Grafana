#!/bin/bash

sudo useradd --no-create-home --shell /bin/false prometheus
wget https://github.com/prometheus/prometheus/releases/download/v3.4.1/prometheus-3.4.1.linux-amd64.tar.gz

tar -xvf prometheus-3.4.1.linux-amd64.tar.gz

sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus

sudo cp prometheus-3.4.1.linux-amd64/prometheus /usr/local/bin/
sudo cp prometheus-3.4.1.linux-amd64/promtool /usr/local/bin/

cat << 'EOF' > /etc/prometheus/prometheus.yml
global:
  scrape_interval: 15s

scrape_configs:

  - job_name: "prometheus"

    static_configs:
      - targets: ["localhost:9090"]

  - job_name: "linux-servers"

    static_configs:
      - targets:
          - "TARGET1_PRIVATE_IP:9100"
          - "TARGET2_PRIVATE_IP:9100"
EOF

sudo chown -R prometheus:prometheus /var/lib/prometheus
sudo chown -R prometheus:prometheus /etc/prometheus
sudo chown prometheus:prometheus /usr/local/bin/prometheus

cat << 'EOF' > /etc/systemd/system/prometheus.service

[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple

ExecStart=/usr/local/bin/prometheus \
  --config.file=/etc/prometheus/prometheus.yml \
  --storage.tsdb.path=/var/lib/prometheus

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable prometheus
sudo systemctl start prometheus
sudo systemctl status prometheus
