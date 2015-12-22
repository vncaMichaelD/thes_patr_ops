{
  :schema => {
    "$schema" => "http://www.archivesspace.org/archivesspace.json",
    "version" => 1,
    "type" => "object",
    "uri" => "/repositories/:repo_id/conferences",
    "properties" => {
	  "conf_type" => {"type" => "string", "dynamic_enum" => "conference_type", "ifmissing" => "error"},
      "title" => {"type" => "string", "maxLength" => 255, "ifmissing" => "error"},
	  "date_s" => {"type" => "string", "maxLength" => 255},
	  "date_e" => {"type" => "string", "maxLength" => 255},
	  "location" => {"type" => "string", "maxLength" => 255},
	  "city" => {"type" => "string", "maxLength" => 255},
	  "state" => {"type" => "string", "maxLength" => 255},
	  "zipcode" => {"type" => "string", "maxLength" => 255},
	  "country" => {"type" => "string", "maxLength" => 255},
	  "contact" => {"type" => "string", "maxLength" => 255},
	  "email" => {"type" => "string", "maxLength" => 255},
	  "phone" => {"type" => "string", "maxLength" => 255},
	  "web_link" => {"type" => "string", "maxLength" => 255},
	  "display_link" => {"type" => "string", "maxLength" => 255},

      "conference_events" => {"type" => "array", "items" => {"type" => "JSONModel(:conference_event) object"}},
	  
	  "uri" => {"type" => "string", "required" => false},
      "suppressed" => {"type" => "boolean", "default" => false},
      "display_string" => {"type" => "string", "maxLength" => 8192, "readonly" => true},
    },
  },
}