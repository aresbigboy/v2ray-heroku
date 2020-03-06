#!/bin/bash

# Install V2Ray
# curl https://install.direct/go.sh | bash
curl -L -k https://github.com/v2ray/v2ray-core/releases/latest/download/v2ray-linux-64.zip -o ./v2ray.zip
mkdir -p v2ray/
unzip ./v2ray.zip -d v2ray/

# Remove extra functions
# rm -rf /usr/bin/v2ray/geosite.dat /usr/bin/v2ray/geoip.dat
cd v2ray/
rm -rf config.json doc geo* v2ctl.sig v2ray.sig vpoint_* system* ../v2ray.zip

# V2Ray new configuration
cat <<-EOF > ./config.json
{
  "inbounds": [
  {
    "port": ${PORT},        /* this is the server port for client[nginx] */
    "protocol": "dokodemo-door",
    "tag": "wsdoko",
    "settings": {
      "address": "v1.mux.cool",   /* don't change!!! */
      "followRedirect": false,
      "network": "tcp,udp"
    },
    "streamSettings": {
      "network": "ws",      /* same as v2ray-plugin */
      "wsSettings": {
      "path": "/heroku" 
      }
    }
  },
  {
    "port": $[${PORT}+1],   /* this port is not used, but you need to specific */
    "listen": "127.0.0.1",
    "protocol": "shadowsocks",
    "settings": {
      "method": "chacha20",
      "ota": false,
      "password": "${UUID}",
      "network": "tcp,udp"
    },
    "streamSettings": {
      "network": "domainsocket"
    }
  }
  ],
  "outbounds": [
    {
        "protocol": "freedom"
    },
    {
      "protocol": "freedom",
      "tag": "ssmux",
      "streamSettings": {
        "network": "domainsocket"
      }
    }
  ],
  "transport": {
    "dsSettings": {
      "path": "./ss-loop.sock"  /* the directory must exist before v2ray starts */
    }
  },
  "routing": {
    "rules": [
      {
        "type": "field",
        "inboundTag": [
          "wsdoko"
        ],
        "outboundTag": "ssmux"
      }
    ]
  }
}
EOF

# Run V2Ray
# /usr/bin/v2ray/v2ray -config=/etc/v2ray/config.json
./v2ray -config=./config.json
