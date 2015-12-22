Sequel.migration do

  up do
    $stderr.puts("Adding VVA Operations tables, fields, and constraints.")

    create_table(:operation) do
      primary_key :id

      Integer :lock_version, :default => 0, :null => false
      Integer :json_schema_version, :null => false
	  
	  String :title
	  String :title_viet
	  TextField :objective
	  TextField :description
	  String :date_s
	  String :date_e
	  TextField :ctz
	  TextField :tao
	  String :aos_str
	  String :aos_kia
	  String :aos_mia
	  String :aos_wia
	  String :aos_pow
	  String :eos_str
	  String :eos_kia
	  String :eos_mia
	  String :eos_wia
	  String :eos_pow

      apply_mtime_columns

	  Integer :star_record
    end

    create_table(:ops_aunit) do
      primary_key :id

      Integer :lock_version, :default => 0, :null => false
      Integer :json_schema_version, :null => false
	  
	  Integer :operation_id

      TextField :unit
      String :branch
	  String :branch_abbr
	  
      apply_mtime_columns

	  Integer :star_record
	  Integer :occ
    end
	
    create_table(:ops_eunit) do
      primary_key :id

      Integer :lock_version, :default => 0, :null => false
      Integer :json_schema_version, :null => false
	  
	  Integer :operation_id

      TextField :unit
      String :branch
	  String :branch_abbr
	  
      apply_mtime_columns

	  Integer :star_record
	  Integer :occ
    end

    create_table(:ops_source) do
      primary_key :id

      Integer :lock_version, :default => 0, :null => false
      Integer :json_schema_version, :null => false
	  
	  Integer :operation_id

	  String :author
	  String :title
	  
      apply_mtime_columns

	  Integer :star_record
	  Integer :occ
    end
	
    alter_table(:ops_aunit) do
      add_foreign_key([:operation_id], :operation, :key => :id)
    end
	
    alter_table(:ops_eunit) do
      add_foreign_key([:operation_id], :operation, :key => :id)
    end
	
    alter_table(:ops_source) do
      add_foreign_key([:operation_id], :operation, :key => :id)
    end

  end

end
