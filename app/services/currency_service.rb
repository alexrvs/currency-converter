require 'json'

class CurrencyService

  LIST_CURRENCIES_API_URL = 'https://free.currconv.com/api/v7/currencies?apiKey=do-not-use-this-key'.freeze
  LATEST_RATES_API_URL = 'https://api.exchangeratesapi.io/latest'.freeze

  def initialize

  end

  def seeds
    uri = URI.parse(URI.encode(LIST_CURRENCIES_API_URL))
    api_response = Net::HTTP.get(uri)
    data = JSON.parse(api_response)
    seeds = data["results"].map(&:second)
    seeds.each{|s| create(s)}
  end

  def create(params)
    Currency.create(api_id: params["id"], name: params["currencyName"], symbol: params["currencySymbol"])
  end

  def process!
    currencies = Currency.all
    uri = URI.parse(URI.encode(LATEST_RATES_API_URL))
    currencies.each do |currency|
      begin
        uri.query = [uri.query, "base=#{currency.api_id}"].compact.join('&')
        api_response = Net::HTTP.get(uri.to_s)
        if api_response.present?
          currency.rates.create(list: '')
        else
          false
        end
      rescue Exception => e
        false
      end
    end

  end

end