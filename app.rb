require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry-byebug'
require 'better_errors'
require_relative 'cookbook'
require_relative 'recipe'

set :bind, '0.0.0.0'
configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path(__dir__)
end

csv_file = File.join(__dir__, 'recipes.csv')
cookbook = Cookbook.new(csv_file)

get '/' do
  @recipes = cookbook.all
  erb :index
end

get '/add' do
  erb :add_form
end

post '/recipes' do
  new_recipe = Recipe.new(
    name: params[:name],
    description: params[:descs],
    rating: params[:rating],
    prep_time: params[:prep_time]
  )
  cookbook.add_recipe(new_recipe)
  redirect '/'
end

get '/team/:username' do
  puts params[:username]
  "The username is #{params[:username]}"
end
