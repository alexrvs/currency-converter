class ConverterService
  attr_reader :base_currency, :convert_currency

  def initialize(args)
    @from = args[:from]
    @to = args[:to]
    @sum = args[:sum]
  end

  def retrieve
    begin
      base_currency
      rate
      calculate
    rescue StandardError => e
      puts "#{e.full_message}"
    end
  end

  private

  def base_currency
    Currency.find_by(_id: @from)
  end

  def rate
    base_currency.rates.where(symbol: @to).first
  end

  def calculate
    (@sum.to_f * rate.coefficient).round(2)
  end

end