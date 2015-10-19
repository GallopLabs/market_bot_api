FROM galloplabs/ruby
MAINTAINER Jonathon W. Marshall "jonathon@galloplabs.com"

WORKDIR /srv/app

COPY Gemfile      /srv/app/Gemfile
COPY Gemfile.lock /srv/app/Gemfile.lock
COPY config.ru    /srv/app/config.ru
COPY app.rb       /srv/app/app.rb

RUN addgroup app && adduser -h /srv/app -G app -D app
RUN apk --update add build-base libffi-dev ruby-dev ruby-nokogiri ruby-mini_portile \
  && bundle install \
  && apk del build-base \
  && rm -rf /var/cache/apk/*

USER app
CMD ["bundle", "exec", "rackup"]

EXPOSE 9292
