FROM ruby:3.2

# Install Node.js and build tools
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
 && apt-get update -qq \
 && apt-get install -y nodejs build-essential

WORKDIR /usr/src/app

# Copy package and Gemfile first (for layer caching)
COPY Gemfile Gemfile.lock package.json ./

RUN bundle install
RUN npm install
# RUN npm uninstall esbuild && npm install --platform=linux --arch=x64 esbuild

# Copy the full project (including SCSS, JS, etc.)
COPY . .

# Now that everything is in place, build assets
# RUN npm run build
RUN npm uninstall esbuild && npm install --platform=linux --arch=x64 esbuild

# Jekyll runs on port 4000
EXPOSE 4000

CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0"]