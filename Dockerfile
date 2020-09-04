ARG RUBY_VERSION=2.5.8
FROM ruby:$RUBY_VERSION-alpine

## Install dependencies:
## - git - Allow budnler to fetch and install ruby gems
## - build-base: To ensure certain gems can be compiled
## - mariadb-dev: To allow use of MySQL gem
## - sqlite-dev: For running tests in the container
## - libxslt-dev libxml2-dev: Nokogiri native dependencies
## - imagemagick: for image processing
RUN apk add --update --no-cache \
      bash \
      build-base \
      git \
      nodejs \
      sqlite-dev \
      tzdata \
      postgresql-dev postgresql \
      imagemagick6-dev imagemagick6-libs
#       libxslt-dev \
#       libxml2-dev

RUN gem install bundler:2.1.4

WORKDIR /app/ld4p/qa_server-webapp

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

ENV PATH=./bin:$PATH

EXPOSE 3000

## Script runs when container first starts
#COPY docker-entrypoint.sh docker-entrypoint.sh
#RUN chmod +x docker-entrypoint.sh
ENTRYPOINT [ "bin/docker-entrypoint.sh" ]
CMD ["bundle", "exec", "puma", "-v", "-b", "tcp://0.0.0.0:3000"]

#CMD ["rails", "console"]
