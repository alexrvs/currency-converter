class Rate
  include Mongoid::Document
  include Mongoid::Timestamps

  field :list, type: Object
  belongs_to :currency

end