# SS + V2Ray-plugin on Heroku

## 概述

####fork from bclswl0827。 thanks  bclswl0827####

用于在 Heroku 上部署 ss + v2ray-plugin 模式的翻墙。

实际上并没有原作者的 v2ray + ws 的模式好用 （因为heroku没有提供udp转发，所以用ss的话，udp数据包不能翻墙。 而用v2ray的话，udp数据包默认通过tcp传输，也就是 udp over tcp，所以不影响udp数据包的转发）， 所以这里是为了实验和测试使用。


PS：本项目的部署脚本随时会因为自己实验而做出更改，请不要依赖本项目进行部署。原作者的代码较为稳定，请从原作者 bclswl0827 进行项目部署
https://github.com/bclswl0827/v2ray-heroku



**Heroku 为我们提供了免费的容器服务，我们不应该滥用它，所以本项目不宜做为长期翻墙使用。**

**可以部署两个以上的应用，实现[负载均衡](https://toutyrater.github.io/app/balance.html)，避免长时间大流量连接某一应用而被 Heroku 判定为滥用。**

**Heroku 的网络并不稳定，部署前请三思。**

## 镜像

本镜像仅 14MB，比起其他用于 Heroku 的 V2Ray 镜像，不会因为大量占用资源而被封号。

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

## ENV 设定

### UUID

`UUID` > `一个 UUID，供用户连接时验证身份使用`。

## 注意

ss的加密方式是 chacha20 ，  密码是 uuid ，  地址填  项目名.herokuapp.com  ， 端口填443

v2ray-plugin 的关键设置是  patch=/heroku;host=项目名.herokuapp.com;tls

V2Ray 将在部署时自动安装最新版本。

**出于安全考量，除非使用 CDN，否则请不要使用自定义域名，而使用 Heroku 分配的二级域名，以实现 ss + v2ray-plugin + TLS。**
