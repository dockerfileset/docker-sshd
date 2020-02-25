FROM centos/systemd

# ###### SSH CONFIG ######
RUN yum -y install openssh-server
RUN mkdir /var/run/sshd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config \
    && sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
RUN echo 'root:toor123$' | chpasswd
RUN /usr/bin/ssh-keygen -A
EXPOSE 22 80
RUN systemctl enable sshd.service
CMD ["/usr/sbin/init"]
