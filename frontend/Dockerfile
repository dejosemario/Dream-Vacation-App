# Stage 1: Build the React app
FROM node:18-alpine AS build

# Accept build-time API URL
ARG REACT_APP_API_URL
ENV REACT_APP_API_URL=$REACT_APP_API_URL

# Set working directory
WORKDIR /app

COPY package*.json ./

# Install dependencies
RUN npm ci

# Copy source code
COPY . .

# Build the React app
ENV NODE_OPTIONS="--openssl-legacy-provider"
RUN npm run build


# Stage 2: Serve with nginx
FROM nginx:alpine

# Copy built app from previous stage
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]