ARG RUBY_VERSION=2.6.2
FROM ruby:$RUBY_VERSION-alpine

ARG RAILS_ENV=production
ARG APP_NAME=qa_server_app
ARG BUNDLE_WITHOUT=development:test
ARG EXTRA_APK_PACKAGES="git sqlite-dev"

# Install dependencies:
# - git - Allow budnler to fetch and install ruby gems
# - build-base: To ensure certain gems can be compiled
# - mariadb-dev: To allow use of MySQL gem
# - sqlite-dev: For running tests in the container
# - libxslt-dev libxml2-dev: Nokogiri native dependencies
# - imagemagick: for image processing
RUN apk add --update --no-cache \
      git \
      bash \
      build-base \
      mariadb-dev \
      sqlite-dev \
      tzdata \
      libxslt-dev libxml2-dev \
      imagemagick6-dev imagemagick6-libs

## Install image preview generator tools
#RUN apk add --no-cache file
#RUN apk --update add imagemagick

RUN gem install bundler:2.1.4
#RUN gem update bundler

ENV RAILS_ENV $RAILS_ENV
ENV RACK_ENV $RAILS_ENV
ENV RAILS_LOG_TO_STDOUT=true
ENV RAILS_ROOT=/app
ENV LANG=C.UTF-8
ENV GEM_HOME=/bundle
ENV BUNDLE_PATH=$GEM_HOME
ENV BUNDLE_APP_CONFIG=$BUNDLE_PATH
ENV BUNDLE_BIN=$BUNDLE_PATH/bin
ENV PATH=/app/bin:$BUNDLE_BIN:$PATH




ENV BUNDLE_WITHOUT $BUNDLE_WITHOUT





ENV APP_HOME /app-data/ld4p/$APP_NAME
RUN mkdir -p APP_HOME

ENV BUNDLE_PATH /usr/local/bundle
ENV BUNDLE_GEMFILE $APP_HOME/Gemfile
ENV BUNDLE_JOBS 4

COPY . $APP_HOME
WORKDIR $APP_HOME

COPY Gemfile Gemfile.lock ./

RUN gem install bundler \
  && bundle install -j "$(getconf _NPROCESSORS_ONLN)"  \
  && rm -rf $BUNDLE_PATH/cache/*.gem \
  && find $BUNDLE_PATH/gems/ -name "*.c" -delete \
  && find $BUNDLE_PATH/gems/ -name "*.o" -delete

ADD https://time.is/just /app-data/build-time

CMD ["bundle", "exec", "puma", "-v", "-b", "tcp://0.0.0.0:3000"]

#WORKDIR /usr/src/app
#
#COPY . .
#
#RUN bundle install
#
#CMD ["rails", "console"]
