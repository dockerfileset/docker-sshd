FROM jenkins/ssh-agent:latest-jdk11
USER root
RUN sed -i 's/deb.debian.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list
RUN sed -i 's/security.debian.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list
RUN apt-get update && apt-get install -y apt-transport-https \
    ca-certificates curl gnupg2
# [ install python 3.9.6
RUN apt install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libsqlite3-dev libreadline-dev libffi-dev curl libbz2-dev

WORKDIR /Downloads
RUN curl -O https://repo.huaweicloud.com/python/3.9.6/Python-3.9.6.tar.xz
RUN tar -xf Python-3.9.6.tar.xz
WORKDIR /Downloads/Python-3.9.6
RUN ./configure --enable-optimizations --enable-loadable-sqlite-extensions
RUN make
RUN make install
RUN update-alternatives --install /usr/bin/python python /usr/local/bin/python3.9 39
RUN update-alternatives --config python
RUN python -m pip install --trusted-host https://repo.huaweicloud.com \
    -i https://repo.huaweicloud.com/repository/pypi/simple \
    --no-cache-dir \
    'Jinja2==3.1.2' 'docker==5.0.2'
# ]

# [ install docker-cli
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88
RUN echo "deb [arch=amd64] https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/debian buster stable" >> /etc/apt/sources.list
RUN apt-get update && apt-get install -y docker-ce-cli
RUN python3.9 -m pip install -i https://repo.huaweicloud.com/repository/pypi/simple wheel
RUN python3.9 -m pip install -i https://repo.huaweicloud.com/repository/pypi/simple docker-compose
# ]
