FROM nginx:stable-alpine

ENV NGINX_ENVSUBST_OUTPUT_DIR=/usr/share/nginx/html \
    DEPLOY_ENV=local \
    APP_VERSION=1.0.0

COPY app/index.html.template /etc/nginx/templates/index.html.template

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=3s \
  CMD wget -q -O /dev/null http://127.0.0.1/ || exit 1