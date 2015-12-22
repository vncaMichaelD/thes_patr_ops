module TtuseaLinks

  def self.included(base)
        base.one_to_many :ttusea_link


        base.def_nested_record(:the_property => :ttusea_links,
                               :contains_records_of_type => :ttusea_link,
                               :corresponding_to_association => :ttusea_link)
  end

end
