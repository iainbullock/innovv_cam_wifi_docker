FROM alpine:3.20.2

# install dependencies
RUN apk update && apk add --no-cache \
  wireless-tools \
  wpa_supplicant \
  dhclient \
  curl

# Copy configs and scripts
COPY conf/* /conf/
COPY app liblog.sh libproduct.sh /app/
RUN chmod +x /app/start.sh

CMD [ "/app/start.sh" ]
