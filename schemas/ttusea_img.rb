{
  :schema => {
    "$schema" => "http://www.archivesspace.org/archivesspace.json",
    "version" => 1,
    "type" => "object",

    "properties" => {
	  "image_link" => {"type" => "string", "maxLength" => 8192},
      "description" => {"type" => "string", "maxLength" => 8192},
    },
  },
}
