
sudo useradd --no-create-home --shell /bin/false node_exporter

wget https://github.com/prometheus/node_exporter/releases/download/v1.9.1/node_exporter-1.9.1.linux-amd64.tar.gz

tar -xvf node_exporter-1.9.1.linux-amd64.tar.gz

sudo cp node_exporter-1.9.1.linux-amd64/node_exporter /usr/local/bin/

sudo vi /etc/systemd/system/node_exporter.service

[Unit]
Description=Node Exporter

[Service]
User=node_exporter
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=default.target

sudo systemctl daemon-reload
sudo systemctl enable node_exporter
sudo systemctl start node_exporter

systemctl status node_exporter

http://TARGET-IP:9100/metrics


