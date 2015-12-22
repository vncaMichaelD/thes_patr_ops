class CommonIndexer

  @@record_types << :reunion

  add_indexer_initialize_hook do |indexer|

    indexer.add_document_prepare_hook {|doc, record|
      if record['record']['jsonmodel_type'] == 'reunion'
        doc['title'] = record['record']['display_string']
      end
    }

  end

end