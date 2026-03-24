ARG REGISTRY=""
ARG BASE_IMAGE_NGINX=nginx:1.29.6-alpine

FROM ${REGISTRY}${REGISTRY:+/}${BASE_IMAGE_NGINX}

WORKDIR /usr/share/nginx/html

COPY ./configs/nginx.conf /etc/nginx/conf.d/default.conf
COPY ./src /usr/share/nginx/html

RUN nginx -t

EXPOSE 80

ENTRYPOINT ["nginx", "-g", "daemon off;"]
