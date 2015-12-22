{
  :schema => {
    "$schema" => "http://www.archivesspace.org/archivesspace.json",
    "version" => 1,
    "type" => "object",

    "properties" => {
	  "primary_name" => {"type" => "string", "maxLength" => 255, "ifmissing" => "error"},
      "title" => {"type" => "string", "maxLength" => 16384},
      "prefix" => {"type" => "string", "maxLength" => 65000},
      "rest_of_name" => {"type" => "string", "maxLength" => 65000, "ifmissing" => "error"},
      "suffix" => {"type" => "string", "maxLength" => 65000},
      "fuller_form" => {"type" => "string", "maxLength" => 65000},
      "number" => {"type" => "string", "maxLength" => 255},
	  "association" => {"type" => "string", "maxLength" => 255},
	  "paper_title" => {"type" => "string", "maxLength" => 255},
	  "presented" => {"type" => "boolean", "default" => false},
	  "file1" => {"type" => "string", "maxLength" => 255},
	  "file1_display" => {"type" => "string", "maxLength" => 255},
	  "file2" => {"type" => "string", "maxLength" => 255},
	  "file2_display" => {"type" => "string", "maxLength" => 255},
	  "file3" => {"type" => "string", "maxLength" => 255},
	  "file3_display" => {"type" => "string", "maxLength" => 255},
	  "file4" => {"type" => "string", "maxLength" => 255},
	  "file4_display" => {"type" => "string", "maxLength" => 255},
	  "general_note" => {"type" => "string", "maxLength" => 8192},
    },
  },
}
