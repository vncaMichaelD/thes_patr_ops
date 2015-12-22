Sequel.migration do

  up do
    $stderr.puts("Adding VVA TTUSea tables, fields, and constraints.")

    create_table(:ttusea) do
      primary_key :id

      Integer :lock_version, :default => 0, :null => false
      Integer :json_schema_version, :null => false
	  
	  String :primary_name
      TextField :title
      TextField :prefix
      TextField :rest_of_name
      TextField :suffix
      TextField :fuller_form
	  String :number
	  String :dobirth
	  String :dodeath
	  String :dograd
	  TextField :text_block
	  String :profile_img
	  TextField :general_note
	  TextField :path

      apply_mtime_columns

	  Integer :star_record
    end
	
    alter_table(:linked_agents_rlshp) do
      add_column(:ttusea_id, :integer)
    end
	
    alter_table(:note) do
      add_column(:ttusea_id, :integer)
    end

    create_table(:ttusea_ttu) do
      primary_key :id

      Integer :lock_version, :default => 0, :null => false
      Integer :json_schema_version, :null => false
	  
	  Integer :ttusea_id

      String :date_s
	  String :date_e
	  
      apply_mtime_columns

	  Integer :star_record
	  Integer :occ
    end
	
    alter_table(:ttusea_ttu) do
      add_foreign_key([:ttusea_id], :ttusea, :key => :id)
    end
	
    create_table(:ttusea_img) do
      primary_key :id

      Integer :lock_version, :default => 0, :null => false
      Integer :json_schema_version, :null => false
	  
	  Integer :ttusea_id

      TextField :image_link
      TextField :description
	  
      apply_mtime_columns

	  Integer :star_record
	  Integer :occ
    end
	
    alter_table(:ttusea_img) do
      add_foreign_key([:ttusea_id], :ttusea, :key => :id)
    end

    create_table(:ttusea_link) do
      primary_key :id

      Integer :lock_version, :default => 0, :null => false
      Integer :json_schema_version, :null => false
	  
	  Integer :ttusea_id

	  TextField :link_link
	  String :link_text
	  String :type
	  TextField :source_link
	  String :source_text
	  
      apply_mtime_columns

	  Integer :star_record
	  Integer :occ
    end
	
    alter_table(:ttusea_link) do
      add_foreign_key([:ttusea_id], :ttusea, :key => :id)
    end

  end

end
