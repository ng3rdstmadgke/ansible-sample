FROM python:3.8.12-bullseye

ENV PATH $PATH:/root/.local/bin

# update & install package
RUN apt update && apt install -y sshpass gosu

# ansible install
RUN pip install ansible==4.8.0

# aws cli install
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-2.0.30.zip" -o "awscliv2.zip"; \
    unzip awscliv2.zip; \
    ./aws/install

# ansible mount dir
RUN mkdir /ansible
WORKDIR /ansible

# entrypoint
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
