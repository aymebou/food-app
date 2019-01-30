FROM ruby:2.6
RUN apt update -qq && apt-get install -y postgresql-client curl software-properties-common
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash
RUN apt install -y nodejs
RUN mkdir /food-app
WORKDIR /food-app
COPY Gemfile /food-app/Gemfile
COPY Gemfile.lock /food-app/Gemfile.lock
RUN gem install nokogiri -v '1.8.5' --source 'https://rubygems.org/'
RUN gem install nio4r -v '2.0.0' --source 'https://rubygems.org/'
RUN gem install websocket-driver -v '0.7.0' --source 'https://rubygems.org/'
RUN gem install bindex -v '0.5.0' --source 'https://rubygems.org/'
RUN gem install msgpack -v '1.2.6' --source 'https://rubygems.org/'
RUN gem install bootsnap -v '1.3.2' --source 'https://rubygems.org/'
RUN gem install byebug -v '10.0.2' --source 'https://rubygems.org/'
RUN gem install ffi -v '1.10.0' --source 'https://rubygems.org/'
RUN gem install unf_ext -v '0.0.7.5' --source 'https://rubygems.org/'
RUN gem install pg -v '1.1.4' --source 'https://rubygems.org/'
RUN gem install puma -v '3.12.0' --source 'https://rubygems.org/'
RUN bundle config build.puma --use-system-libraries
RUN bundle config build.pg --use-system-libraries
RUN bundle config build.unf_ext --use-system-libraries
RUN bundle config build.ffi --use-system-libraries
RUN bundle config build.byebug --use-system-libraries
RUN bundle config build.bootsnap --use-system-libraries
RUN bundle config build.msgpack --use-system-libraries
RUN bundle config build.bindex --use-system-libraries
RUN bundle config build.nio4r --use-system-libraries
RUN bundle config build.websocket-driver --use-system-libraries
RUN bundle config build.nokogiri --use-system-libraries
COPY Rakefile /food-app/Rakefile
RUN bundle install
RUN gem install rake
COPY . /food-app
RUN npm i -g bower && echo '{ "allow_root": true }' > /root/.bowerrc && rake bower:install

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
