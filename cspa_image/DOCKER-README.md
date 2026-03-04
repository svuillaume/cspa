# 🐳 Docker Deployment Guide
## Hybrid and Multi-Cloud Security Assessment

This guide shows you how to run the Security Assessment application in a Docker container.

---

## 📋 Prerequisites

- Docker installed on your system
  - **Windows/Mac**: [Docker Desktop](https://www.docker.com/products/docker-desktop/)
  - **Linux**: [Docker Engine](https://docs.docker.com/engine/install/)
- Docker Compose (included with Docker Desktop)

---

## 🚀 Quick Start

### Option 1: Using Docker Compose (Recommended)

```bash
# Navigate to the directory containing the files
cd /path/to/security-assessment

# Start the application
docker-compose up -d

# The app is now running at: http://localhost:8080
```

### Option 2: Using Docker Directly

```bash
# Build the image
docker build -t security-assessment .

# Run the container
docker run -d -p 8080:80 --name security-assessment-app security-assessment

# The app is now running at: http://localhost:8080
```

---

## 🌐 Accessing the Application

Once running, open your web browser and navigate to:

```
http://localhost:8080
```

Or if accessing from another computer on the network:

```
http://[YOUR-IP-ADDRESS]:8080
```

---

## 🛠️ Managing the Container

### View running containers
```bash
docker ps
```

### View logs
```bash
docker logs security-assessment-app
```

### Stop the application
```bash
docker-compose down
# OR
docker stop security-assessment-app
```

### Restart the application
```bash
docker-compose restart
# OR
docker restart security-assessment-app
```

### Remove the container
```bash
docker-compose down
docker rm security-assessment-app
```

### Remove the image
```bash
docker rmi security-assessment
```

---

## 🔧 Customization

### Change the Port

Edit `docker-compose.yml`:
```yaml
ports:
  - "3000:80"  # Change 3000 to your desired port
```

Or with Docker command:
```bash
docker run -d -p 3000:80 --name security-assessment-app security-assessment
```

### Enable HTTPS (Production)

For production with SSL/TLS, you'll need to:
1. Add an nginx configuration file
2. Include SSL certificates
3. Expose port 443

Example nginx configuration with SSL (create `nginx.conf`):
```nginx
server {
    listen 80;
    server_name your-domain.com;
    return 301 https://$server_name$request_uri;
}

server {
    listen 443 ssl;
    server_name your-domain.com;
    
    ssl_certificate /etc/nginx/ssl/cert.pem;
    ssl_certificate_key /etc/nginx/ssl/key.pem;
    
    location / {
        root /usr/share/nginx/html;
        index index.html;
    }
}
```

Update Dockerfile:
```dockerfile
FROM nginx:alpine
COPY security-assessment-standalone.html /usr/share/nginx/html/index.html
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY ssl/ /etc/nginx/ssl/
EXPOSE 80 443
CMD ["nginx", "-g", "daemon off;"]
```

---

## 📦 What's Included

- **Dockerfile**: Container configuration
- **docker-compose.yml**: Easy deployment configuration
- **.dockerignore**: Excludes unnecessary files
- **security-assessment-standalone.html**: The application

---

## 🏗️ Architecture

```
┌─────────────────────────────────────┐
│   Docker Container                  │
│                                     │
│  ┌──────────────────────────────┐  │
│  │  Nginx Web Server            │  │
│  │  (Port 80)                   │  │
│  │                              │  │
│  │  Serves:                     │  │
│  │  index.html (standalone app) │  │
│  └──────────────────────────────┘  │
│                                     │
└─────────────────────────────────────┘
           │
           │ Port Mapping
           ▼
    Host Port 8080
```

---

## 🔒 Security Considerations

### For Internal Use:
- Default configuration is fine
- Access only via localhost or internal network

### For Production/External Access:
1. **Enable HTTPS** with valid SSL certificates
2. **Use a reverse proxy** (nginx, Traefik, or Caddy)
3. **Implement authentication** (Basic Auth, OAuth, etc.)
4. **Use a firewall** to restrict access
5. **Regular updates** to the base image

Example with Basic Auth:
```bash
# Create password file
htpasswd -c .htpasswd admin

# Update nginx config to require authentication
```

---

## 🌍 Deploying to Cloud

### AWS (EC2 or ECS)
```bash
# On EC2 instance
sudo yum install docker -y
sudo service docker start
sudo docker-compose up -d
```

### Google Cloud (Cloud Run)
```bash
gcloud builds submit --tag gcr.io/PROJECT-ID/security-assessment
gcloud run deploy --image gcr.io/PROJECT-ID/security-assessment --platform managed
```

### Azure (Container Instances)
```bash
az container create \
  --resource-group myResourceGroup \
  --name security-assessment \
  --image security-assessment \
  --ports 80 \
  --dns-name-label security-assessment-app
```

### DigitalOcean (App Platform)
- Push to GitHub
- Connect to DigitalOcean App Platform
- Auto-deploy from Dockerfile

---

## 📊 Resource Usage

**Container Size**: ~25 MB (nginx:alpine base)
**Memory**: ~10-20 MB
**CPU**: Minimal (static content)

---

## ❓ Troubleshooting

### Port already in use
```bash
# Change the port in docker-compose.yml or use different port:
docker run -d -p 9090:80 --name security-assessment-app security-assessment
```

### Container won't start
```bash
# Check logs
docker logs security-assessment-app

# Check if container exists
docker ps -a
```

### Permission denied
```bash
# On Linux, run with sudo or add user to docker group
sudo usermod -aG docker $USER
# Log out and back in
```

### Cannot access from other computers
```bash
# Make sure firewall allows traffic on port 8080
# Windows: Windows Defender Firewall
# Linux: sudo ufw allow 8080
```

---

## 🔄 Updating the Application

```bash
# Stop and remove old container
docker-compose down

# Rebuild with new version
docker-compose up -d --build

# Or with Docker commands
docker stop security-assessment-app
docker rm security-assessment-app
docker build -t security-assessment .
docker run -d -p 8080:80 --name security-assessment-app security-assessment
```

---

## 💾 Data Persistence

**Note**: This application stores data in the browser (LocalStorage if enabled) and exports to Excel/PDF. No server-side data storage is configured. All assessment data is client-side only.

If you need server-side storage:
1. Add a backend service (Node.js, Python, etc.)
2. Add a database (MongoDB, PostgreSQL)
3. Update the application to send data to the backend

---

## 📞 Support

For issues or questions:
1. Check Docker logs: `docker logs security-assessment-app`
2. Verify container is running: `docker ps`
3. Test locally first: Open `security-assessment-standalone.html` directly
4. Check firewall settings
5. Ensure port 8080 is not blocked

---

## 🎯 Next Steps

- ✅ Access the app at http://localhost:8080
- ✅ Complete your security assessment
- ✅ Export to PDF or Excel
- ✅ Share with your team

**Enjoy your containerized Security Assessment! 🔴⚫🐳**
