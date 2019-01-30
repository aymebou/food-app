FROM ruby:2.6
RUN apt update -qq && apt-get install -y postgresql-client curl software-properties-common
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash
RUN apt install -y nodejs
RUN mkdir /food-app
WORKDIR /food-app
COPY Gemfile /food-app/Gemfile
COPY Gemfile.lock /food-app/Gemfile.lock
COPY Rakefile /food-app/Rakefile
RUN bundle install
COPY . /food-app
RUN gem install rake && npm i -g bower && rake bower:install

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
