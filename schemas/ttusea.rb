{
  :schema => {
    "$schema" => "http://www.archivesspace.org/archivesspace.json",
    "version" => 1,
    "type" => "object",
    "uri" => "/repositories/:repo_id/ttuseas",
    "properties" => {
	  "primary_name" => {"type" => "string", "maxLength" => 255, "ifmissing" => "error"},
      "title" => {"type" => "string", "maxLength" => 8192},
      "prefix" => {"type" => "string", "maxLength" => 8192},
      "rest_of_name" => {"type" => "string", "maxLength" => 8192, "ifmissing" => "error"},
      "suffix" => {"type" => "string", "maxLength" => 8192},
      "fuller_form" => {"type" => "string", "maxLength" => 8192},
      "number" => {"type" => "string", "maxLength" => 255},
	  "dobirth" => {"type" => "string", "maxLength" => 255},
	  "dodeath" => {"type" => "string", "maxLength" => 255},
	  "dograd" => {"type" => "string", "maxLength" => 255},
	  "text_block" => {"type" => "string", "maxLength" => 8192},
	  "profile_img" => {"type" => "string", "maxLength" => 255},
	  "general_note" => {"type" => "string", "maxLength" => 8192},
	  "path" => {"type" => "string", "maxLength" => 8192},

      "ttusea_ttus" => {"type" => "array", "items" => {"type" => "JSONModel(:ttusea_ttu) object"}},
      "ttusea_imgs" => {"type" => "array", "items" => {"type" => "JSONModel(:ttusea_img) object"}},
      "ttusea_links" => {"type" => "array", "items" => {"type" => "JSONModel(:ttusea_link) object"}},
	  "notes" => {
            "type" => "array",
            "items" => {"type" => [{"type" => "JSONModel(:note_bibliography) object"},
                                   {"type" => "JSONModel(:note_digital_object) object"}]},
          },
	  
	  "uri" => {"type" => "string", "required" => false},
      "suppressed" => {"type" => "boolean", "default" => false},
      "display_string" => {"type" => "string", "maxLength" => 8192, "readonly" => true},
    },
  },
}