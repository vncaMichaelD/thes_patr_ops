{
  :schema => {
    "$schema" => "http://www.archivesspace.org/archivesspace.json",
    "version" => 1,
    "type" => "object",

    "properties" => {
	
	  "status" => {"type" => "string", "dynamic_enum" => "patron_status"},
	  "purpose" => {"type" => "string", "dynamic_enum" => "patron_purpose"},
	  "status_note" => {"type" => "string", "maxLength" => 65000},
	  "purpose_note" => {"type" => "string", "maxLength" => 65000},
	  "research_topic" => {"type" => "string", "maxLength" => 65000},
	  "date_signed" => {"type" => "string", "maxLength" => 255},
	
    },
  },
}