class Reunion < Sequel::Model(:reunion)
  include ASModel
  corresponds_to JSONModel(:reunion)

  set_model_scope :repository


  def self.sequel_to_jsonmodel(objs, opts = {})
    jsons = super

    jsons.zip(objs).each do |json, obj|
      p json
      subject = json['title']
	  
	  json['display_string'] = subject
    end

    jsons
  end

end