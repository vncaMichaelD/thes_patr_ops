class CommonIndexer

  @@record_types << :vva_event

  add_indexer_initialize_hook do |indexer|

    indexer.add_document_prepare_hook {|doc, record|
      if record['record']['jsonmodel_type'] == 'vva_event'
        doc['title'] = record['record']['display_string']
      end
    }

  end

end