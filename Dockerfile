FROM ruby:2.4.0

RUN printf "deb http://archive.debian.org/debian/ jessie main\n \
            deb-src http://archive.debian.org/debian/ jessie main\n \
            deb http://security.debian.org jessie/updates main\n \
            deb-src http://security.debian.org jessie/updates main" > /etc/apt/sources.list

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

ENV RAILS_ROOT /var/www/flashcards
RUN mkdir -p $RAILS_ROOT

# Set working directory
WORKDIR $RAILS_ROOT

COPY Gemfile Gemfile.lock ./

RUN gem install bundler  -v 1.3.0
RUN bundle update
# RUN gem install bundler -v 1.3.0
# RUN bundle _1.3.0_ install
RUN bundle install

COPY . .

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]