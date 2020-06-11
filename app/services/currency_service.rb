require 'json'
require 'net/http'

class CurrencyService

  LIST_CURRENCIES_API_URL = 'https://free.currconv.com/api/v7/currencies?apiKey=do-not-use-this-key'.freeze
  LATEST_RATES_API_URL = 'https://api.exchangeratesapi.io/latest'.freeze

  def initialize

  end

  def get_calculated_rates_by_currency(currency)

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
        create_rates(currency, api_response) if api_response.present?
      rescue Exception => e
        next
      end
    end
  end

  private

  def create(params)
    Currency.create(api_id: params["id"], name: params["currencyName"], symbol: params["currencySymbol"])
  end

  def create_rates(obj, response)
    data = JSON.parse(response)
    if !data["error"].present?
      insert_data = data["rates"].map{|item| {symbol: item.first, coefficient: item.last}}
      obj.rates.create(insert_data)
    end
  end

end
