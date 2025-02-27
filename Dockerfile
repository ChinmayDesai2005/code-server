# Start from the code-server Debian base image
FROM codercom/code-server:3.9.3  

USER coder

# Apply VS Code settings 
COPY settings.json .local/share/code-server/User/settings.json

# Use bash shell
ENV SHELL=/bin/bash

# Install unzip + rclone (support for remote filesystem)
RUN sudo apt-get update && sudo apt-get install unzip -y
RUN curl https://rclone.org/install.sh | sudo bash

# Fix permissions for code-server
RUN sudo chown -R coder:coder /home/coder/.local

# You can add custom software and dependencies for your environment below
# -----------

# Install a VS Code extension:
# Note: we use a different marketplace than VS Code. See https://github.com/cdr/code-server/blob/main/docs/FAQ.md#differences-compared-to-vs-code
# RUN code-server --install-extension esbenp.prettier-vscode

# Install apt packages:
# RUN sudo apt-get install -y ubuntu-make

# Copy files: 
# COPY deploy-container/myTool /home/coder/myTool

# -----------

RUN sudo curl -fsSL https://deb.nodesource.com/setup_15.x | sudo bash -
RUN sudo apt-get install -y nodejs
RUN sudo apt-get install -y software-properties-common
RUN sudo apt-get install -y python3-pip
RUN sudo apt-get update
RUN sudo add-apt-repository ppa:deadsnakes/ppa -y && \
  sudo apt-get install python3.9
RUN sudo pip3 install nest-asyncio
RUN sudo pip3 install requests
RUN sudo pip3 install discord.py
RUN sudo pip3 install chess.com
RUN sudo pip3 install pymongo
RUN sudo pip3 install deta
RUN sudo pip3 install pytz
RUN code-server --install-extension ms-python.python
RUN git config --global user.name "Kavin Shanbhag"
RUN git config --global user.email "kavinplays@icloud.com"

# Port
ENV PORT=8080

# Use our custom entrypoint script first
COPY entrypoint.sh /usr/bin/deploy-container-entrypoint.sh
ENTRYPOINT ["/usr/bin/deploy-container-entrypoint.sh"]
