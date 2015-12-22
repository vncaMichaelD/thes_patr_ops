class PatronStat < Sequel::Model(:patron_stat)
  include ASModel
  corresponds_to JSONModel(:patron_stat)

  set_model_scope :repository


  def self.sequel_to_jsonmodel(objs, opts = {})
    jsons = super

    jsons.zip(objs).each do |json, obj|
      p json
      subject = json['type_of_patron']
	  if subject == "researcher"
	    subject = "Researcher"
	  elsif subject == "veteran"
	    subject = "Veteran"
	  elsif subject == "general_public"
	    subject = "General Public"
	  elsif subject == "media"
	    subject = "Media"
	  elsif subject == "donor"
	    subject = "Donor"
	  elsif subject == "oral_history"
	    subject = "Oral History"
	  elsif subject == "students_class"
	    subject = "Students/Class"
	  elsif subject == "other"
	    subject = "Other"
	  end
      if json['questions']
	    terms = json['questions']
	  else
	    terms = json['answers_provided']
	  end
      json['display_string'] = subject
      json['display_string'] += " -- #{terms}"
    end

    jsons
  end

end