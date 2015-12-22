class Ttusea < Sequel::Model(:ttusea)
  include ASModel
  corresponds_to JSONModel(:ttusea)

  include TtuseaTtus
  include TtuseaImgs
  include TtuseaLinks

  set_model_scope :repository


  def self.sequel_to_jsonmodel(objs, opts = {})
    jsons = super

    jsons.zip(objs).each do |json, obj|
      p json
      subject = json['rest_of_name']
	  
      terms = json['primary_name']
	  if json['prefix']
	    honor = json['prefix']
		
		json['display_string'] = honor
	  
        json['display_string'] += " #{subject} #{terms}"
	  else
	    json['display_string'] = subject
	  
        json['display_string'] += " #{terms}"
	  end
    end

    jsons
  end

end