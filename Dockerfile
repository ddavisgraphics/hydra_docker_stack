FROM ruby:2.3.3
# run update
RUN apt-get update -qq
# install dependencies
RUN apt-get install -y build-essential libpq-dev nodejs mysql-client git
# add rails
RUN gem install bundler
RUN gem install rails

# make working directory and move files over
RUN mkdir /home/hydra
WORKDIR /home/hydra

ADD /hydra/Gemfile /Gemfile
ADD /hydra /home/hydra
