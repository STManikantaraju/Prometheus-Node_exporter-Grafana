#!/bin/bash
# 1. Update and upgrade packages cleanly in non-interactive mode
# export DEBIAN_FRONTEND=noninteractive
apt-get update && apt-get upgrade -y

# 2. Create the system user safely
useradd --no-create-home --shell /bin/false node_exporter

# 3. Download and extract Node Exporter
cd /tmp
wget https://github.com/prometheus/node_exporter/releases/download/v1.9.1/node_exporter-1.9.1.linux-amd64.tar.gz
tar -xvf node_exporter-1.9.1.linux-amd64.tar.gz

# 4. Install the binary
cp node_exporter-1.9.1.linux-amd64/node_exporter /usr/local/bin/
chown node_exporter:node_exporter /usr/local/bin/node_exporter

# 5. Create the systemd service file directly (removed interactive 'vi' command)
cat << 'EOF' > /etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter
After=network.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# 6. Reload systemd, enable and start the service
systemctl daemon-reload
systemctl enable node_exporter
systemctl start node_exporter

echo "================================================================================"
echo "================================================================================"
echo "================================================================================"
echo "YOUR SYSTEM PUBLIC_IP = $(curl s ifconfig.me)"
echo "http://$(curl -s ifconfig.me):9100/metrics"
echo "================================================================================"
echo "================================================================================"
echo "================================================================================"
systemctl status node_exporter
