class ApplicationController < Sinatra::Base
  configure do
    set :views, "app/views"
    set :public_dir, "public"
    set :public_folder, File.dirname(__FILE__) + '/static'
  end

  get '/' do
    "Hello from Sinatra on Heroku!"
  end

  get '/currency/converter' do
    @currencies = Currency.includes(:rates).select{|c| c.rates.present?}
    erb :'converter/index'
  end

  get '/currency/update' do
    CurrencyService.new.process!
    json :data => {result: :ok}
  end

  get '/seeds' do
    @seeds = CurrencyService.new.seeds
    json :data => @seeds
  end

  post '/convert' do
    @result = ConverterService.new(params).retrieve
    json :data => @result
  end

end