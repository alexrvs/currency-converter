class ApplicationController < Sinatra::Base
  configure do
    set :views, "app/views"
    set :public_dir, "public"
  end

  get '/currency/converter' do
    erb :'converter/index'
  end

  get '/currency/update' do
    CurrencyService.new.process!
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