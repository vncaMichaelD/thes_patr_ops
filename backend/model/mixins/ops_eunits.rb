module OpsEunits

  def self.included(base)
        base.one_to_many :ops_eunit


        base.def_nested_record(:the_property => :ops_eunits,
                               :contains_records_of_type => :ops_eunit,
                               :corresponding_to_association => :ops_eunit)
  end

end
