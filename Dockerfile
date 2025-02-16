FROM ubuntu:latest

# Install git, curl, openssh-server and nodejs
RUN apt-get update && \ 
    apt-get install -y git curl openssh-server && \ 
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \ 
    apt-get install -y nodejs

# Create directories
RUN mkdir -p /var/repo/site.git /var/www/domain.com

WORKDIR /var/repo/site.git

# Initialize a new git repository
RUN git init --bare

# Configure git hooks
RUN mkdir -p /root/.ssh && chmod 700 /root/.ssh
COPY authorized_keys /root/.ssh/authorized_keys
RUN chmod 600 /root/.ssh/authorized_keys

# Configure SSHD
RUN mkdir /var/run/sshd
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]