class OpsSource < Sequel::Model(:ops_source)
  include ASModel
  corresponds_to JSONModel(:ops_source)

  set_model_scope :repository

end
