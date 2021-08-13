# base image
FROM ruby:3.0.1-alpine

# environment variables
ENV APP_PATH /app
ENV BUNDLE_VERSION 2.2.18
ENV BUNDLE_PATH /usr/local/bundle/gems
ENV TMP_PATH /tmp/
ENV RAILS_LOG_TO_STDOUT true
ENV RAILS_PORT 3000

COPY ./dev-docker-entrypoint.sh /usr/local/bin/dev-entrypoint.sh
COPY ./test-docker-entrypoint.sh /usr/local/bin/test-entrypoint.sh
RUN chmod +x /usr/local/bin/dev-entrypoint.sh && chmod +x /usr/local/bin/test-entrypoint.sh

# install dependencies
RUN apk -U add --no-cache \
build-base \
git \
postgresql-dev \
postgresql-client \
libxml2-dev \
libxslt-dev \
nodejs \
yarn \
imagemagick \
tzdata \
less \
&& rm -rf /var/cache/apk/* \
&& mkdir -p $APP_PATH

RUN gem install bundler --version "$BUNDLE_VERSION" && \
rm -rf $GEM_HOME/cache/*
COPY Gemfile $APP_PATH/
COPY Gemfile.lock $APP_PATH/

WORKDIR $APP_PATH

RUN bundle install

EXPOSE $RAILS_PORT

ENTRYPOINT ["bundle", "exec"]
