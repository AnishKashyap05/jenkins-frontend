# Stage 1: Build React App
FROM node:18 AS build

# Set working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy all files into the container
COPY . .

# Build the project
RUN npm run build

# Stage 2: Serve React App using Nginx
FROM nginx:alpine

# Remove default Nginx static files and copy our build files
RUN rm -rf /usr/share/nginx/html/*
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80 for HTTP traffic
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
