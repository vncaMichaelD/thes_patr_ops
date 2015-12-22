class CommonIndexer

  @@record_types << :conference

  add_indexer_initialize_hook do |indexer|

    indexer.add_document_prepare_hook {|doc, record|
      if record['record']['jsonmodel_type'] == 'conference'
        doc['title'] = record['record']['display_string']
      end
    }

  end

end