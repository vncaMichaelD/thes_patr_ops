class OpsEunit < Sequel::Model(:ops_eunit)
  include ASModel
  corresponds_to JSONModel(:ops_eunit)

  set_model_scope :repository

end
