module PatronPurposes

  def self.included(base)
        base.one_to_many :patron_purpose


        base.def_nested_record(:the_property => :patron_purposes,
                               :contains_records_of_type => :patron_purpose,
                               :corresponding_to_association => :patron_purpose)
  end

end
