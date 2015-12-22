{
  :schema => {
    "$schema" => "http://www.archivesspace.org/archivesspace.json",
    "version" => 1,
    "type" => "object",

    "properties" => {
	  "event_type" => {"type" => "string", "dynamic_enum" => "conference_event_type", "ifmissing" => "error"},
	  "date_s" => {"type" => "string", "maxLength" => 255},
	  "time_s" => {"type" => "string", "maxLength" => 255},
	  "date_e" => {"type" => "string", "maxLength" => 255},
	  "time_e" => {"type" => "string", "maxLength" => 255},
	  "title" => {"type" => "string", "maxLength" => 255, "ifmissing" => "error"},
	  "session_num" => {"type" => "string", "maxLength" => 255},
	  "video1" => {"type" => "string", "maxLength" => 255},
	  "video2" => {"type" => "string", "maxLength" => 255},
	  "video3" => {"type" => "string", "maxLength" => 255},
	  "video4" => {"type" => "string", "maxLength" => 255},
	  "moderator" => {"type" => "string", "maxLength" => 255},
	  "alt_title" => {"type" => "string", "maxLength" => 255},
	  "association" => {"type" => "string", "maxLength" => 255},
	  "room" => {"type" => "string", "maxLength" => 255},
	  "general_note" => {"type" => "string", "maxLength" => 8192},

	  "conference_panels" => {"type" => "array", "items" => {"type" => "JSONModel(:conference_panel) object"}},
    },
  },
}
