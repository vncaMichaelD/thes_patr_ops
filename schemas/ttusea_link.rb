{
  :schema => {
    "$schema" => "http://www.archivesspace.org/archivesspace.json",
    "version" => 1,
    "type" => "object",

    "properties" => {
	  "link_link" => {"type" => "string", "maxLength" => 8192},
	  "link_text" => {"type" => "string", "maxLength" => 255},
	  "type" => {"type" => "string", "maxLength" => 255},
	  "source_link" => {"type" => "string", "maxLength" => 8192},
	  "source_text" => {"type" => "string", "maxLength" => 255},
    },
  },
}
