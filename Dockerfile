FROM ruby:3.2

# Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
 && apt-get update -qq \
 && apt-get install -y nodejs build-essential

# Set working directory
WORKDIR /usr/src/app

# Copy dependencies
COPY Gemfile Gemfile.lock ./
COPY package.json ./

# Install Ruby and Node packages
RUN bundle install
RUN npm install

# Copy project files
COPY . .

# Expose Jekyll port
EXPOSE 4000

# Serve Jekyll site
CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0"]