configure alert
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

# Apply load on Tarket node
yes > /dev/null

# then check in Grafana portal for load update, also u may get mail laert when load high & resolved / load get down.


