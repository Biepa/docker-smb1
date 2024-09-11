FROM alpine:3.12.12

RUN apk --no-cache --no-progress upgrade && \
    apk --no-cache --no-progress add bash tini && \
    # SMBv1 protocols were deprecated in 4.13 -> https://www.samba.org/samba/history/samba-4.13.0.html
    apk --no-cache --no-progress add samba=4.12.15-r0 --repository=http://dl-cdn.alpinelinux.org/alpine/v3.12/main && \
    file="/etc/samba/smb.conf" && \
    sed -i 's|^;* *\(log file = \).*|   \1/dev/stdout|' $file && \
    sed -i '/Share Definitions/,$d' $file && \
    echo '   ntlm auth = yes' >>$file && \
    echo '   min protocol = LANMAN1' >>$file

EXPOSE 137/udp 138/udp 139 445

COPY ./setup.sh /etc/setup.sh
RUN chmod +x /etc/setup.sh
ENTRYPOINT ["/sbin/tini", "--", "/etc/setup.sh"]