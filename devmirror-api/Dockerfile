FROM python:3.11-slim

WORKDIR /app

# Install system deps
RUN apt-get update && apt-get install -y curl ca-certificates bash && rm -rf /var/lib/apt/lists/*

# Install Coral CLI and symlink to system PATH
RUN curl -fsSL https://install.withcoral.com/install.sh | bash && \
    find /root -name "coral" -type f 2>/dev/null | head -1 | xargs -I{} cp {} /usr/local/bin/coral && \
    coral --version
ENV PATH="/root/.coral/bin:/usr/local/bin:${PATH}"

# Install Python deps
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy app
COPY . .

RUN chmod +x /app/start.sh

EXPOSE 8000

ENTRYPOINT ["/bin/bash", "/app/start.sh"]
