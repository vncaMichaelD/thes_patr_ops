class TtuseaTtu < Sequel::Model(:ttusea_ttu)
  include ASModel
  corresponds_to JSONModel(:ttusea_ttu)

  set_model_scope :repository

end
