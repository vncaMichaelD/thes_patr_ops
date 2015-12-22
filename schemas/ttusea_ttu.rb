{
  :schema => {
    "$schema" => "http://www.archivesspace.org/archivesspace.json",
    "version" => 1,
    "type" => "object",

    "properties" => {
	  "date_s" => {"type" => "string", "maxLength" => 255},
      "date_e" => {"type" => "string", "maxLength" => 255},
    },
  },
}
