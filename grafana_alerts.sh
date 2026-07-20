100 - (avg by(instance)(rate(node_cpu_seconds_total{mode="idle"}[1m]))* 100)


add contact point

create app password for gmail

sudo vi /etc/grafana/grafana.ini

[smtp]
enabled = true
host = smtp.gmail.com:587
user = yourmail@gmail.com
password = gmail_app_password
from_address = yourmail@gmail.com
from_name = Grafana

sudo systemctl restart grafana-server
sudo systemctl status grafana-server

configure alert


