{
  :schema => {
    "$schema" => "http://www.archivesspace.org/archivesspace.json",
    "version" => 1,
    "type" => "object",

    "properties" => {
	
	  "date_signed" => {"type" => "string", "ifmissing" => "error", "maxLength" => 255},
	  "type_of_mat" => {"type" => "string", "dynamic_enum" => "patron_material"},
      "signed_by" => {"type" => "string", "dynamic_enum" => "patron_signed_by"},
	  "signed_by_name" => {"type" => "string", "maxLength" => 255},
	  "coll_title" => {"type" => "string", "maxLength" => 255},
	  "coll_author" => {"type" => "string", "maxLength" => 255},
	  "coll_location" => {"type" => "string", "maxLength" => 255},
	  "box_nums" => {"type" => "string", "maxLength" => 8192},
	  "pulled_by" => {"type" => "string", "maxLength" => 255},
	  "general_note" => {"type" => "string", "maxLength" => 8192},
	
    },
  },
}