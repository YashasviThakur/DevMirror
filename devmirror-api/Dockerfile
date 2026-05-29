FROM python:3.11-slim

WORKDIR /app

# Install system deps
RUN apt-get update && apt-get install -y curl ca-certificates bash && rm -rf /var/lib/apt/lists/*

# Install Coral CLI — cache bust: v2
RUN curl -fsSL https://install.withcoral.com/install.sh | bash
RUN echo "=== coral install check ===" && \
    ls /root/.coral/bin/ 2>/dev/null || echo "no /root/.coral/bin" && \
    find /root /home -name "coral" -type f 2>/dev/null && \
    find /root/.coral/bin /usr/local/bin -name "coral" 2>/dev/null | head -5
ENV PATH="/root/.coral/bin:/usr/local/bin:${PATH}"
RUN which coral && coral --version

# Install Python deps
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy app
COPY . .

RUN chmod +x /app/start.sh

EXPOSE 8000

ENTRYPOINT ["/bin/bash", "/app/start.sh"]
