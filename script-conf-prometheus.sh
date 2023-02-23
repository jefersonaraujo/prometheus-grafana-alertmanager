#!/bin/bash
echo $(date)
echo "############ INSTALL PROMETHEUS ###############"
wget https://github.com/prometheus/node_exporter/releases/download/v1.5.0/node_exporter-1.5.0.linux-amd64.tar.gz
tar xvfz node_exporter-1.5.0.linux-amd64.tar.gz
sudo cp node_exporter-1.5.0.linux-amd64/node_exporter /usr/local/bin/
sudo useradd node_exporter
sudo chown node_exporter:node_exporter /usr/local/bin/node_exporter

echo "############ CONFIG SYSTEMCTL SERVICE ###############"
cat << EOF > /etc/systemd/system/node_exporter.service
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target

EOF

echo "############ RELOAD SYSTEMCTL SERVICE ###############"
sudo systemctl daemon-reload
sudo systemctl start node_exporter

