module TtuseaImgs

  def self.included(base)
        base.one_to_many :ttusea_img


        base.def_nested_record(:the_property => :ttusea_imgs,
                               :contains_records_of_type => :ttusea_img,
                               :corresponding_to_association => :ttusea_img)
  end

end
