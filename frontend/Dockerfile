# Stage 1: Build the React app
FROM node:18-alpine AS build

# Set working directory
WORKDIR /app

COPY package*.json ./

# Install dependencies
RUN npm ci

# Copy source code
COPY . .

# Build the React app
RUN npm run build


# Stage 2: Serve with nginx
FROM nginx:alpine

# Copy built app from previous stage
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]