require 'json'
require 'net/http'

class CurrencyService
  attr_reader :service

  LIST_CURRENCIES_API_URL = 'https://free.currconv.com/api/v7/currencies?apiKey=do-not-use-this-key'.freeze
  LATEST_RATES_API_URL = 'https://api.exchangeratesapi.io/latest'.freeze

  def initialize(service=nil)
    @service = service
  end

  def info
    usd_currency = Currency.where(api_id: "USD").first
    usd_currency.rates.map do |r|
      {symbol: r.symbol, sum: ConverterService.new({from: usd_currency._id,to: r.symbol, sum: 1}).retrieve}
    end
  end

  def seeds
    uri = URI.parse(URI.encode(LIST_CURRENCIES_API_URL))
    api_response = Net::HTTP.get(uri)
    data = JSON.parse(api_response)
    seeds = data["results"].map(&:second)
    seeds.each{|s| create(s)}
  end

  def process!
    currencies = Currency.all
    currencies.each do |currency|
      uri = URI.parse(LATEST_RATES_API_URL)
      begin
        uri.query = [uri.query, "base=#{currency.api_id}"].compact.join('&')
        uri = URI.parse(uri.to_s)
        api_response = Net::HTTP.get(uri)
        @service.process(currency, api_response) if api_response.present?
      rescue Exception => e
        next
      end
    end
  end

  private

  def create(params)
    Currency.create(api_id: params["id"], name: params["currencyName"], symbol: params["currencySymbol"])
  end

end
