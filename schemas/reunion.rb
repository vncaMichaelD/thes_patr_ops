{
  :schema => {
    "$schema" => "http://www.archivesspace.org/archivesspace.json",
    "version" => 1,
    "type" => "object",
    "uri" => "/repositories/:repo_id/reunions",
    "properties" => {
	  "active" => {"type" => "boolean", "default" => false},
	  "name" => {"type" => "string", "maxLength" => 255, "ifmissing" => "error"},
	  "department" => {"type" => "string", "dynamic_enum" => "staff_department", "ifmissing" => "error"},
	  "date_s" => {"type" => "string", "maxLength" => 255},
	  "time_s" => {"type" => "string", "maxLength" => 255},
	  "date_e" => {"type" => "string", "maxLength" => 255},
	  "time_e" => {"type" => "string", "maxLength" => 255},
	  "title" => {"type" => "string", "maxLength" => 255, "ifmissing" => "error"},
	  "web_link" => {"type" => "string", "maxLength" => 255},
	  "contact" => {"type" => "string", "maxLength" => 255},
	  "email" => {"type" => "string", "maxLength" => 255},
	  "phone" => {"type" => "string", "maxLength" => 255},
	  "location" => {"type" => "string", "maxLength" => 255},
	  "city" => {"type" => "string", "maxLength" => 255},
	  "state" => {"type" => "string", "maxLength" => 255},
	  "zipcode" => {"type" => "string", "maxLength" => 255},
	  "country" => {"type" => "string", "maxLength" => 255},
	  "general_note" => {"type" => "string", "maxLength" => 8192},
	  "post_note" => {"type" => "string", "maxLength" => 8192},

	  "uri" => {"type" => "string", "required" => false},
      "suppressed" => {"type" => "boolean", "default" => false},
      "display_string" => {"type" => "string", "maxLength" => 8192, "readonly" => true},
    },
  },
}