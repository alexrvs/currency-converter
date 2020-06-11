class Rate
  include Mongoid::Document
  include Mongoid::Timestamps

  field :symbol, type: Object
  field :coefficient, type: Float

  belongs_to :currency, inverse_of: :currency

end