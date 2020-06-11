ENV['SINATRA_ENV'] ||= "development"
ENV['RACK_ENV'] ||= "development"

require 'bundler/setup'
require 'sinatra'
#require 'pry'
require 'sinatra/json'
require 'mongoid'

Bundler.require(:default, ENV['SINATRA_ENV'])

Dir.glob('./app/{controllers,models,services,views}/*.rb').each { |file| require file }

Mongoid.load!(File.join(File.dirname(__FILE__), 'mongoid.yml'))
