module OpsSources

  def self.included(base)
        base.one_to_many :ops_source


        base.def_nested_record(:the_property => :ops_sources,
                               :contains_records_of_type => :ops_source,
                               :corresponding_to_association => :ops_source)
  end

end
