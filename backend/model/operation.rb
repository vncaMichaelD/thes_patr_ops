class Operation < Sequel::Model(:operation)
  include ASModel
  corresponds_to JSONModel(:operation)

  include OpsAunits
  include OpsEunits
  include OpsSources

  set_model_scope :repository


  def self.sequel_to_jsonmodel(objs, opts = {})
    jsons = super

    jsons.zip(objs).each do |json, obj|
      p json
      subject = json['title']
	  
      terms = json['title_viet']
	  
      json['display_string'] = subject
	  
      json['display_string'] += " -- #{terms}"
    end

    jsons
  end

end