class ApplicationController < Sinatra::Base
  configure do
    set :views, "app/views"
    set :public_dir, "public"
  end

  get '/currency/converter' do
    @currencies = Currency.includes(:rates).select{|c| c.rates.present?}
    @info =  CurrencyService.new.info
    erb :'converter/index'
  end

  get '/currency/rates/create' do
    creator = RateCreatorService.new
    CurrencyService.new(creator).process!
    json :data => {result: :ok}
  end

  get '/currency/rates/update' do
    updater = RateUpdaterService.new
    CurrencyService.new(updater).process!
    json :data => {result: :ok}
  end

  post '/convert' do
    @result = ConverterService.new(params).retrieve
    json :data => {result_sum: @result}
  end

end