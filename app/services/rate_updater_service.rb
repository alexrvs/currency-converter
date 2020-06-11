class RateUpdaterService

  def process(obj, response)
    update_rates(obj, response)
  end

  private

  def update_rates(obj, response)
    data = JSON.parse(response)
    if !data["error"].present?
      update_data = data["rates"].map{|item| {symbol: item.first, coefficient: item.last}}
      obj.rates.update(update_data)
    end
  end

end