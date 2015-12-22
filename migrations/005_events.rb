Sequel.migration do

  up do
    $stderr.puts("Adding VVA TTUSea tables, fields, and constraints.")

    create_table(:conference) do
      primary_key :id

      Integer :lock_version, :default => 0, :null => false
      Integer :json_schema_version, :null => false
	  
	  Integer :conf_type_id
      String :title
	  String :date_s
	  String :date_e
	  String :location
	  String :city
	  String :state
	  String :zipcode
	  String :country
	  String :contact
	  String :email
	  String :phone
	  String :web_link
	  String :display_link

      apply_mtime_columns

	  Integer :star_record
    end

    create_table(:conference_event) do
      primary_key :id

      Integer :lock_version, :default => 0, :null => false
      Integer :json_schema_version, :null => false
	  
	  Integer :conference_id

      Integer :event_type_id
	  String :date_s
	  String :time_s
	  String :date_e
	  String :time_e
	  String :title
	  String :session_num
	  String :video1
	  String :video2
	  String :video3
	  String :video4
	  String :moderator
	  String :alt_title
	  String :association
	  String :room
	  TextField :general_note
	  
      apply_mtime_columns

	  Integer :star_record
    end
	
    alter_table(:conference_event) do
      add_foreign_key([:conference_id], :conference, :key => :id)
    end

    create_table(:conference_panel) do
      primary_key :id

      Integer :lock_version, :default => 0, :null => false
      Integer :json_schema_version, :null => false
	  
	  Integer :conference_event_id

      String :primary_name
      TextField :title
      TextField :prefix
      TextField :rest_of_name
      TextField :suffix
      TextField :fuller_form
      String :number
	  String :association
	  String :paper_title
	  Integer :presented
	  String :file1
	  String :file1_display
	  String :file2
	  String :file2_display
	  String :file3
	  String :file3_display
	  String :file4
	  String :file4_display
	  TextField :general_note
	  
      apply_mtime_columns

	  Integer :star_record
	  Integer :occ
    end
	
    alter_table(:conference_panel) do
      add_foreign_key([:conference_event_id], :conference_event, :key => :id)
    end
	
    create_table(:vva_event) do
      primary_key :id

      Integer :lock_version, :default => 0, :null => false
      Integer :json_schema_version, :null => false
	  
	  Integer :active
	  Integer :publish
	  String :name
	  String :department_id
	  String :date_s
	  String :time_s
	  String :date_e
	  String :time_e
	  String :title
	  String :web_link
	  String :contact
	  String :email
	  String :phone
	  String :location
	  String :city
	  String :state
	  String :zipcode
	  String :country
	  TextField :general_note

      apply_mtime_columns

	  Integer :star_record
    end
	
	create_table(:reunion) do
      primary_key :id

      Integer :lock_version, :default => 0, :null => false
      Integer :json_schema_version, :null => false
	  
	  Integer :active
	  String :name
	  Integer :department_id
	  String :date_s
	  String :time_s
	  String :date_e
	  String :time_e
	  String :title
	  String :web_link
	  String :contact
	  String :email
	  String :phone
	  String :location
	  String :city
	  String :state
	  String :zipcode
	  String :country
	  TextField :general_note
	  TextField :post_note

      apply_mtime_columns

	  Integer :star_record
    end
	
	create_editable_enum('conference_type', ["symposium","conference"])
	create_editable_enum('conference_event_type', ["plenary","session","event"])
	
  end

end
