class OpsAunit < Sequel::Model(:ops_aunit)
  include ASModel
  corresponds_to JSONModel(:ops_aunit)

  set_model_scope :repository

end
