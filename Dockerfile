FROM alpine
FROM ruby:2.6.1

RUN apt-get update && \
    apt-get install -y nodejs \
                       vim \
                       mysql-client \
                       --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*
    

RUN mkdir /usr/src/editores
WORKDIR /usr/src/editores

COPY Gemfile /usr/src/editores/Gemfile
COPY Gemfile.lock /usr/src/editores/Gemfile.lock

# Install app dependencies
RUN gem install bundler \
  && gem install rails \
  && gem install puma \
  && bundle install

COPY . /usr/src/editores

CMD bundle exec rake assets:precompile
