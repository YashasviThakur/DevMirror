FROM python:3.11-slim

WORKDIR /app

# Install system deps
RUN apt-get update && apt-get install -y curl ca-certificates bash && rm -rf /var/lib/apt/lists/*

# Install Coral CLI
RUN curl -fsSL https://install.withcoral.com/install.sh | bash
ENV PATH="/root/.coral/bin:${PATH}"

# Install Python deps
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy app
COPY . .

RUN chmod +x /app/start.sh

EXPOSE 8000

ENTRYPOINT ["/bin/bash", "/app/start.sh"]
