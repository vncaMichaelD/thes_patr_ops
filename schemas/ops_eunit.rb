{
  :schema => {
    "$schema" => "http://www.archivesspace.org/archivesspace.json",
    "version" => 1,
    "type" => "object",

    "properties" => {
	
	  "unit" => {"type" => "string", "maxLength" => 8192},
	  "branch" => {"type" => "string", "maxLength" => 255},
	  "branch_abbr" => {"type" => "string", "maxLength" => 255},
	
    },
  },
}