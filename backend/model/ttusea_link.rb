class TtuseaLink < Sequel::Model(:ttusea_link)
  include ASModel
  corresponds_to JSONModel(:ttusea_link)

  set_model_scope :repository

end
