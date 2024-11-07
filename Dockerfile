# Use an official Node.js runtime as a parent image for building the application
FROM node:18 AS build
 
# Set the working directory in the container
WORKDIR /app
 
# Copy package.json and package-lock.json
COPY package.json package-lock.json ./
 
# Install dependencies
RUN npm install
 
# Install aws-sdk if it's not already in package.json
RUN npm install aws-sdk
 
# Copy the rest of the application code
COPY . .
 
# Build the application
RUN npm run build
 
# Use a lightweight web server to serve the built files
FROM nginx:alpine
 
# Copy the built files from the previous stage
COPY --from=build /app/dist /usr/share/nginx/html
 
# Copy custom Nginx configuration file
COPY nginx.conf /etc/nginx/conf.d/default.conf
 
# Expose port 80 to the outside world
EXPOSE 4173
 
#test KT
# Start the nginx server
CMD ["nginx", "-g", "daemon off;"]
 