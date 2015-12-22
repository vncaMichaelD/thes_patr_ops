module ConferencePanels

  def self.included(base)
        base.one_to_many :conference_panel


        base.def_nested_record(:the_property => :conference_panels,
                               :contains_records_of_type => :conference_panel,
                               :corresponding_to_association => :conference_panel)
  end

end
