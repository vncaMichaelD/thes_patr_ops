class PatronPurpose < Sequel::Model(:patron_purpose)
  include ASModel
  corresponds_to JSONModel(:patron_purpose)

  set_model_scope :repository

end
