# logic 

# installation s3

userdatascript:
# Access_Link: wget https://github.com/STManikantaraju/Prometheus-Node_exporter-Grafana/blob/main/install_nodeexpo.sh

#!/bin/bash
sudo su

# Raw_link for download or run script:
wget https://raw.githubusercontent.com/STManikantaraju/Prometheus-Node_exporter-Grafana/refs/heads/main/install_nodeexpo.sh
# (replace wiht latest version of node-exporter, if any issue with mentioned version)

chmod +x install_nodeexpo.sh && ./install_nodeexpo.sh

# To print PUBLIC_IP
echo "================================================================================"
echo "================================================================================"
echo "================================================================================"
echo "YOUR SYSTEM PUBLIC_IP = $(curl s ifconfig.me)"
echo "http://$(curl -s ifconfig.me):9100/metrics"
echo "================================================================================"
echo "================================================================================"
echo "================================================================================"

OR one more command to generae Public_IP after instance launch
echo "$(wget -qO- icanhazip.com)"
# launch template

---------------------------------------------------------------------------

# Without storing script file in S3 storage (paste all at a time, after connecting instance thru SSH)

sudo apt update && sudo apt upgrade -y
sudo useradd --no-create-home --shell /bin/false node_exporter

wget https://github.com/prometheus/node_exporter/releases/download/v1.9.1/node_exporter-1.9.1.linux-amd64.tar.gz
(replace wiht latest version of node-exporter, if any issue with mentioned version)

tar -xvf node_exporter-1.9.1.linux-amd64.tar.gz

sudo cp node_exporter-1.9.1.linux-amd64/node_exporter /usr/local/bin/

sudo vi /etc/systemd/system/node_exporter.service

cat << 'EOF' > vi /etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter

[Service]
User=node_exporter
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=default.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable node_exporter
sudo systemctl start node_exporter

-------------------------------------------------------------------------------

# Without storing script file in S3 storage (User Data Script)

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
systemctl status node_exporter

# to check the output complete
sudo cat /var/log/cloud-init-output.log
or
# to check the output page-by-page
sudo less /var/log/cloud-init-output.log
or
# View the downloaded raw script:
sudo cat /var/lib/cloud/instance/user-data.txt

