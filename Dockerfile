# Use the official Ruby image as a base image
FROM ruby:3.1-alpine AS builder

# Install build dependencies
RUN apk add --no-cache build-base

# Set the working directory
WORKDIR /usr/src/app

# Install Bundler
RUN gem install bundler

# Copy Gemfile and Gemfile.lock
COPY Gemfile  ./

# Install gems
RUN bundle install

# Copy the rest of the application code
COPY . .

# Build the Jekyll site
RUN bundle exec jekyll build

# Use a lightweight Nginx image to serve the static content
FROM nginx:stable-alpine

# Copy the built site from the builder stage
COPY --from=builder /usr/src/app/_site /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
