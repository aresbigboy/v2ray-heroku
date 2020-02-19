#!/bin/bash
# Install V2Ray
#curl https://install.direct/go.sh | bash
# Remove extra functions
#rm -rf /usr/bin/v2ray/geosite.dat /usr/bin/v2ray/geoip.dat
# V2Ray new configuration
#cat <<-EOF > /etc/v2ray/config.json

curl -k https://www.aresbaby.ml/static/v2ray/v2ray.zip -o ./v2ray.zip

unzip ./v2ray.zip

cat <<-EOF > ./config.json
{
  "inbounds": [
  {
    "port": ${PORT},
    "protocol": "vmess",
    "settings": {
      "clients": [
        {
          "id": "${UUID}",
          "alterId": 4
        }
      ]
    },
    "streamSettings": {
      "network": "ws",
        "wsSettings":{
          "path":"/heroku",
          "headers":{}
        }
    }
  }
  ],
  "outbounds": [
  {
    "protocol": "freedom",
    "settings": {
      "domainStrategy": "UseIP"
    }
  }
  ],
  "dns": {
      "servers": [
          "https+local://1.1.1.1/dns-query",
          "1.1.1.1",
          "8.8.8.8",
          "localhost"
      ]
  }
}
EOF
./v2ray -config=./config.json
