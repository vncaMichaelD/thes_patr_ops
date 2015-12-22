class ConferencePanel < Sequel::Model(:conference_panel)
  include ASModel
  corresponds_to JSONModel(:conference_panel)

  set_model_scope :repository

end
