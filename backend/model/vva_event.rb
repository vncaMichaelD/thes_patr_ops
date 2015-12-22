class VvaEvent < Sequel::Model(:vva_event)
  include ASModel
  corresponds_to JSONModel(:vva_event)

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