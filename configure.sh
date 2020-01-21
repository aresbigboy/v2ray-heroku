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
     "protocol": "shadowsocks",
     "listen":"127.0.0.1",
     "port": 8081,
     "settings": {
      "method": "chacha20-ietf-poly1305",
      "password": "ssfromheroku20200121",
      "udp": true
     },
      "sniffing": {
        "enabled": true,
        "destOverride": ["http", "tls"]
      }
   }
  ],
  "outbounds": [
  {
    "protocol": "freedom",
    "settings": {}
  }
  ]
}
EOF
/usr/bin/v2ray/v2ray -config=/etc/v2ray/config.json &

git clone https://github.com/shadowsocks/simple-obfs.git
cd simple-obfs
git submodule update --init --recursive
./autogen.sh
./configure && make
sudo make install

/usr/local/bin/obfs-server -s 0.0.0.0 -p ${PORT} --obfs http -r 127.0.0.1:8081 --failover huawei.com:80
