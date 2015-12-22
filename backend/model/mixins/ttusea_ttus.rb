module TtuseaTtus

  def self.included(base)
        base.one_to_many :ttusea_ttu


        base.def_nested_record(:the_property => :ttusea_ttus,
                               :contains_records_of_type => :ttusea_ttu,
                               :corresponding_to_association => :ttusea_ttu)
  end

end
