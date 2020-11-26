#!/bin/sh
# Download and install XRay
curl -L -H "Cache-Control: no-cache" -o /xray.zip https://github.com/XTLS/Xray-core/releases/download/v1.0.0/Xray-linux-64.zip
mkdir /usr/bin/xray /etc/xray
touch /etc/xray/config.json
unzip /xray.zip -d /usr/bin/xray
chmod +x /usr/bin/xray/*
# Remove /xray.zip and other useless files
rm -rf /xray.zip /usr/bin/xray/*.sig /usr/bin/xray/doc /usr/bin/xray/*.json /usr/bin/xray/sys*
# xray new configuration
cat <<-EOF > /etc/xray/config.json
{
  "inbounds": [
    {
      "port": ${PORT},
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "${UUID}",
            "alterId": 1
          }
        ]
      },
      "streamSettings": {
        "network": "ws",
        "wsSettings": {
        "path": "/tmp" 
        }
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom"
    },
    {
      "protocol": "blackhole",
      "settings": {
        "response": {
          "type": "http"
        }
      },
      "tag": "block"
    }
  ],
  "routing": {
    "domainStrategy": "IPIfNonMatch",
    "rules": [
      {
        "domain": [
          "geosite:category-ads"
        ],
        "outboundTag": "block",
          "type": "field"
      }
    ]
  }
}
EOF
/usr/bin/xray/xray -config=/etc/xray/config.json
