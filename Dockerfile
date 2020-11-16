FROM alpine:3.5

RUN apk add --no-cache --virtual .build-deps ca-certificates curl bash

#ADD configure.sh.ss+v2ray-plugin /configure.sh
#ADD configure.sh.ws /configure.sh
ADD configure.sh.gost /configure.sh

RUN chmod +x /configure.sh
CMD /configure.sh
