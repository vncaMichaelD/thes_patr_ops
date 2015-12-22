{
  :schema => {
    "$schema" => "http://www.archivesspace.org/archivesspace.json",
    "version" => 1,
    "type" => "object",

    "properties" => {
	
	  "author" => {"type" => "string", "maxLength" => 255},
	  "title" => {"type" => "string", "maxLength" => 255},
	
    },
  },
}