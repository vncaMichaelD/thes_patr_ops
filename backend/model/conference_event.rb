class ConferenceEvent < Sequel::Model(:conference_event)
  include ASModel
  corresponds_to JSONModel(:conference_event)

  include ConferencePanels

  set_model_scope :repository

end
