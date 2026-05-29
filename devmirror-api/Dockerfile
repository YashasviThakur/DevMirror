FROM python:3.11-slim

WORKDIR /app

# Install system deps — cache bust: v3
RUN apt-get update && apt-get install -y curl ca-certificates bash findutils && rm -rf /var/lib/apt/lists/*

# Install Coral CLI
RUN curl -fsSL https://install.withcoral.com/install.sh | bash
# Debug: find where coral installed
RUN find /root /usr /home -name "coral" -type f 2>/dev/null || echo "[WARN] coral binary not found anywhere"
# Add all likely coral paths to PATH
ENV PATH="/root/.coral/bin:/root/.local/bin:/usr/local/bin:${PATH}"
# Verify coral is accessible
RUN coral --version || (echo "[ERROR] coral not in PATH after install" && exit 1)

# Install Python deps
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy app
COPY . .

RUN chmod +x /app/start.sh

EXPOSE 8000

ENTRYPOINT ["/bin/bash", "/app/start.sh"]
