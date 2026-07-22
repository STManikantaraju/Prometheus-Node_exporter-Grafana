#!/bin/bash
sudo su
wget https://raw.githubusercontent.com/STManikantaraju/Prometheus-Node_exporter-Grafana/refs/heads/main/install_Prometheus_Grafana.sh

chmod +x install_Prometheus_Grafana.sh && ./install_Prometheus_Grafana.sh

# To print PUBLIC_IP
echo "================================================================================"
echo "YOUR SYSTEM PUBLIC_IP = $(curl s ifconfig.me)"
echo "http://$(curl -s ifconfig.me):9090"
echo "================================================================================"

# after Prometheus installation need to update the Target_System's_Pubic_IP in 
sudo vi /etc/prometheus/prometheus.yml

# & then, may need to run the below commands again
sudo systemctl daemon-reload
sudo systemctl restart prometheus
sudo systemctl status prometheus

sudo systemctl restart grafana-server
sudo systemctl status grafana-server

# To print PUBLIC_IP with Grafana port
echo "================================================================================"
echo "YOUR SYSTEM PUBLIC_IP for Grafana access = $(curl s ifconfig.me)"
echo "http://$(curl -s ifconfig.me):3000"
echo "================================================================================"

Add Data Source -> Prometheus -> http://localhost:9090

Import dashboard:
1860

Stress CPU Demo On target server:
yes > /dev/null
--------------------------------------------------------------------------------------------------------------------------------

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

# To print PUBLIC_IP Prometheus port
echo "================================================================================"
echo "================================================================================"
echo "================================================================================"
echo "YOUR SYSTEM PUBLIC_IP for Prometheus access = $(curl s ifconfig.me)"
echo "http://$(curl -s ifconfig.me):9090"
echo "================================================================================"
echo "================================================================================"
echo "================================================================================"

#      **********************Grafana Installation********************************

sudo apt update
wget https://dl.grafana.com/enterprise/release/grafana-enterprise_12.0.1_amd64.deb
sudo apt-get install -y adduser libfontconfig1 musl
sudo dpkg -i grafana-enterprise_12.0.1_amd64.deb
sudo apt install -y musl
sudo apt install -f

sudo systemctl daemon-reload
sudo systemctl enable grafana-server
sudo systemctl start grafana-server
sudo systemctl status grafana-server

# To print PUBLIC_IP with Grafana port
echo "================================================================================"
echo "================================================================================"
echo "================================================================================"
echo "YOUR SYSTEM PUBLIC_IP for Grafana access = $(curl s ifconfig.me)"
echo "http://$(curl -s ifconfig.me):3000"
echo "================================================================================"
echo "================================================================================"
echo "================================================================================"

----------------------------------------------------------------------------------------------------------------------

# to check the output complete
sudo cat /var/log/cloud-init-output.log
or
# to check the output page-by-page
sudo less /var/log/cloud-init-output.log
or
# View the downloaded raw script:
sudo cat /var/lib/cloud/instance/user-data.txt
