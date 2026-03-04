# Use nginx alpine for minimal image size
FROM nginx:alpine

# Copy the HTML file to nginx web root
COPY security-assessment-standalone.html /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80

# nginx starts automatically with the base image
CMD ["nginx", "-g", "daemon off;"]
