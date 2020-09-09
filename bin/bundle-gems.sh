#! /bin/sh

# For development check if the gems as installed. If not, install them.
if ! [ bundle check ];  then
  gem install bundler:2.1.4
  bundle install
fi

echo "Bundle complete!"
