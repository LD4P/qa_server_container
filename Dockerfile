ARG RUBY_VERSION=3.1.2
FROM ruby:$RUBY_VERSION-alpine
ARG BUNDLER_VERSION=2.3.7

## Install dependencies:
## - build-base: To ensure certain gems can be compiled
## - git: Allow bundler to fetch and install ruby gems
## - nodejs: Required by Rails
## - sqlite-dev: For running tests in the container
## - tzdata: add time zone support
## - mariadb-dev: To allow use of MySQL2 gem
## - imagemagick: for image processing
## - gcompat: to avoid architecture-specific incompatibitilies
RUN apk add --update --no-cache \
      bash \
      build-base \
      git \
      nodejs \
      sqlite-dev \
      tzdata \
      mariadb-dev \
      imagemagick6-dev imagemagick6-libs \
      gcompat


WORKDIR /app/ld4p/qa_server-webapp

RUN gem install bundler:${BUNDLER_VERSION}

ENV PATH="/app/ld4p/qa_server-webapp:$PATH"
ENV RAILS_ROOT="/app/ld4p/qa_server-webapp"

COPY Gemfile Gemfile.lock ./

RUN gem update --system
RUN bundle install

COPY . .
RUN bundle exec rake assets:precompile

ENV PATH=./bin:$PATH

EXPOSE 3000

## Script runs when container first starts
ENTRYPOINT [ "bin/docker-entrypoint.sh" ]
CMD ["bundle", "exec", "puma", "-v", "-b", "tcp://0.0.0.0:3000"]
