FROM ubuntu:18.04

# ###### SSH CONFIG ######
COPY sources.list /etc/apt/sources.list
RUN apt-get update && apt-get install --no-install-recommends -y openssh-server
RUN mkdir /var/run/sshd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes\nRSAAuthentication yes\n/' /etc/ssh/sshd_config \
    && sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
RUN echo 'root:toor123$' | chpasswd

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
