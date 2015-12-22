class TtuseaImg < Sequel::Model(:ttusea_img)
  include ASModel
  corresponds_to JSONModel(:ttusea_img)

  set_model_scope :repository

end
