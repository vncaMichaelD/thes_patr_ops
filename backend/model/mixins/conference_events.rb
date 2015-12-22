module ConferenceEvents

  def self.included(base)
        base.one_to_many :conference_event


        base.def_nested_record(:the_property => :conference_events,
                               :contains_records_of_type => :conference_event,
                               :corresponding_to_association => :conference_event)
  end

end
