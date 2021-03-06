FROM ruby:2.6.6
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /venues-info-api
RUN gem install bundler -v '2.1.4'
COPY Gemfile /venues-info-api/Gemfile
COPY Gemfile.lock /venues-info-api/Gemfile.lock
RUN bundle install
COPY . /venues-info-api

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
COPY database.sh /usr/bin
RUN chmod +x /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/database.sh
ENTRYPOINT ["entrypoint.sh", "database.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]