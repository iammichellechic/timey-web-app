# Lightweight Web server. 
# It can also act as a reverse proxy, load balancer, etc. 
FROM nginx:alpine

# Let me know if this does explode.
LABEL author="Christian Ekenstedt"

# Set working directory to nginx asset directory.
# WORKDIR /usr/share/nginx/html

# Update timezone.
ENV TZ=Europe/Stockholm
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Remove default nginx static assets, default nginx web hello world web page.
# RUN rm -rf ./*

# Copy the build and put it to NGINX folder.
# NOTE: NGINX serves content from that folder
COPY . /usr/share/nginx/html

# We expose docker ports on both http https default ports.
EXPOSE 80 4040

# It sets the command and parameters that are run when the container is run.
# In other words, the container starts, and it starts nginx
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]