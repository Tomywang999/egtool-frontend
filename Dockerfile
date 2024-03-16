# Use Nginx image from Docker Hub
FROM nginx:1.21.1-alpine

# Remove the default Nginx configuration file
RUN rm /etc/nginx/conf.d/default.conf

# Add our custom Nginx configuration file
COPY nginx.conf /etc/nginx/conf.d

# Copy the build files from your local build directory to the Nginx html directory
COPY ./build/web /usr/share/nginx/html