FROM node:20

# Install basic tools
RUN apt-get update && \
    apt-get install -y \
        git \
        sudo \
        zsh \
        fzf \
        vim \
        nano \
        curl \
        wget \
    && rm -rf /var/lib/apt/lists/*

# Install GitHub CLI
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && apt-get update \
    && apt-get install -y gh \
    && rm -rf /var/lib/apt/lists/*

# Install mise
USER node
RUN curl https://mise.run | sh

# Add mise to PATH
ENV PATH="/home/node/.local/bin:/home/node/.local/share/mise/shims:${PATH}"

# Install Claude Code
USER root
RUN npm install -g @anthropic-ai/claude-code@latest

# Install Codex CLI (OpenAI)
RUN npm install -g @openai/codex@latest

# Install zsh-in-docker for better shell experience
RUN wget -qO- https://github.com/deluan/zsh-in-docker/releases/download/v1.2.1/zsh-in-docker.sh | zsh || true

# Install git-delta for better diff display
RUN wget -qO- https://github.com/dandavison/delta/releases/download/0.18.2/delta-0.18.2-x86_64-unknown-linux-gnu.tar.gz | tar -xz -C /usr/local/bin --strip-components=1 delta-0.18.2-x86_64-unknown-linux-gnu/delta

# Set environment variables
ENV DEVCONTAINER=true
ENV SHELL=/bin/zsh

# Switch to non-root user
USER node
WORKDIR /workspace

CMD ["/bin/zsh"]
