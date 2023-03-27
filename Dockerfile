# Use an official Node.js runtime as a parent image
FROM node:14-alpine as build

# Set the working directory to /app
WORKDIR /app

# Copy the package.json and package-lock.json files to the container
COPY package*.json ./

# Install app dependencies
RUN npm install

# Copy the rest of the application files to the container
COPY . .

# Build the Angular app
RUN npm run build --prod

# Use a smaller base image for production
FROM nginx:stable-alpine

# Copy the build output to the nginx web server directory
COPY --from=build /app/dist/tran-san-web-app /usr/share/nginx/html

# Expose the container's port to the host
EXPOSE 80

# Start the nginx server
CMD ["nginx", "-g", "daemon off;"]

