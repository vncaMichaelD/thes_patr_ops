module OpsAunits

  def self.included(base)
        base.one_to_many :ops_aunit


        base.def_nested_record(:the_property => :ops_aunits,
                               :contains_records_of_type => :ops_aunit,
                               :corresponding_to_association => :ops_aunit)
  end

end
