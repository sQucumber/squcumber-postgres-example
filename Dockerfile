FROM ruby:2.3.1

COPY ./Gemfile Gemfile
COPY ./Rakefile Rakefile
RUN bundle install

COPY ./features features
COPY ./sql sql

ENTRYPOINT ["bundle", "exec", "rake"]
CMD ["test:sql::features"]
