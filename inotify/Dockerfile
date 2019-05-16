FROM alpine:3.8
MAINTAINER nhdocker "<nguyenhuong791123@gmail.com>"

# [inotify-tools] Install
RUN apk --update upgrade && \
    apk add --update inotify-tools && \
    rm -rf /var/cache/apk/*

# [SSH] Install
RUN apk add bash unzip curl ca-certificates openssh sshpass && \
    rm -rf /tmp/* /usr/share/man /var/cache/apk/* && \
    apk search --update

# Add EC2 PEM key to server
# You must setting ec2 info the same witd file ec2.env
ENV EC2_PEM_FILE_PATH /root/ssh
ENV EC2_PEM_FILE_NAME SmartCRM.pem
RUN mkdir $EC2_PEM_FILE_PATH
ADD $EC2_PEM_FILE_NAME $EC2_PEM_FILE_PATH
RUN chmod 400 $EC2_PEM_FILE_PATH/$EC2_PEM_FILE_NAME

# Monitor file setting
ADD init.sh /root/init.sh
RUN chmod 750 /root/init.sh

WORKDIR /tmp

CMD ["/root/init.sh"]
