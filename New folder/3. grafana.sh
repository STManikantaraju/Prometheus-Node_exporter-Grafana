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

http://GRAFANA-IP:3000

Add Data Source -> Prometheus -> http://localhost:9090

Import dashboard:
1860

Stress CPU Demo
On target server:
yes > /dev/null
