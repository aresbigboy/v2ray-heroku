#!/bin/bash
# Install V2Ray
curl https://install.direct/go.sh | bash
# Remove extra functions
rm -rf /usr/bin/v2ray/geosite.dat /usr/bin/v2ray/geoip.dat
# V2Ray new configuration
cat <<-EOF > /etc/v2ray/config.json
{
  "inbounds": [
  {
    "port": ${PORT},
    "protocol": "vmess",
    "settings": {
      "clients": [
        {
          "id": "${UUID}",
          "alterId": 64
        }
      ]
    },
    "streamSettings": {
        "network":"ws",
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
    "settings": {}
  }
  ],
  "dns": {
      "servers": [
          "https+local://1.1.1.1/dns-query",
          "1.1.1.1",
          "223.5.5.5",
          "8.8.8.8",
          "119.29.29.29",
          "localhost"
      ]
  }
}
EOF
/usr/bin/v2ray/v2ray -config=/etc/v2ray/config.json
