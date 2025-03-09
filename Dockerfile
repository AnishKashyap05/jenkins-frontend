# Use Node.js image to build the frontend
FROM node:18-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package.json package-lock.json ./
RUN npm install --production

# Copy all files and build the frontend
COPY . .
RUN npm run build

# Use NGINX to serve the built frontend
FROM nginx:alpine

# Copy built frontend files to NGINX default public folder
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]
