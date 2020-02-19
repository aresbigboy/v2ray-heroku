#!/bin/bash
# Install V2Ray
#curl https://install.direct/go.sh | bash
# Remove extra functions
#rm -rf /usr/bin/v2ray/geosite.dat /usr/bin/v2ray/geoip.dat
# V2Ray new configuration
#cat <<-EOF > /etc/v2ray/config.json

VDIS="64"

ARCH=$(uname -m)
if [[ "$ARCH" == "i686" ]] || [[ "$ARCH" == "i386" ]]; then
    VDIS="32"
elif [[ "$ARCH" == *"armv7"* ]] || [[ "$ARCH" == "armv6l" ]]; then
    VDIS="arm"
elif [[ "$ARCH" == *"armv8"* ]] || [[ "$ARCH" == "aarch64" ]]; then
    VDIS="arm64"
elif [[ "$ARCH" == *"mips64le"* ]]; then
    VDIS="mips64le"
elif [[ "$ARCH" == *"mips64"* ]]; then
    VDIS="mips64"
elif [[ "$ARCH" == *"mipsle"* ]]; then
    VDIS="mipsle"
elif [[ "$ARCH" == *"mips"* ]]; then
    VDIS="mips"
elif [[ "$ARCH" == *"s390x"* ]]; then
    VDIS="s390x"
elif [[ "$ARCH" == "ppc64le" ]]; then
    VDIS="ppc64le"
elif [[ "$ARCH" == "ppc64" ]]; then
    VDIS="ppc64"
fi

NEW_VER=$(curl -s -k https://api.github.com/repos/v2ray/v2ray-core/releases/latest --connect-timeout 10 | grep 'tag_name' | cut -d\" -f4)
curl -k https://github.com/v2ray/v2ray-core/releases/download/${NEW_VER}/v2ray-linux-${VDIS}.zip -o v2ray.zip

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
