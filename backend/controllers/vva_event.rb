class ArchivesSpaceService < Sinatra::Base

  Endpoint.post('/repositories/:repo_id/vva_events/:id')
    .description("Update an Event")
    .params(["id", :id],
            ["vva_event", JSONModel(:vva_event), "The updated record", :body => true],
            ["repo_id", :repo_id])
    .permissions([:update_resource_record])
    .returns([200, :updated]) \
  do
    handle_update(VvaEvent, params[:id], params[:vva_event])
  end


  Endpoint.post('/repositories/:repo_id/vva_events')
    .description("Create an Event")
    .params(["vva_event", JSONModel(:vva_event), "The record to create", :body => true],
            ["repo_id", :repo_id])
    .permissions([:update_resource_record])
    .returns([200, :created]) \
  do
    handle_create(VvaEvent, params[:vva_event])
  end


  Endpoint.get('/repositories/:repo_id/vva_events')
    .description("Get a list of Events for a Repository")
    .params(["repo_id", :repo_id])
    .paginated(true)
    .permissions([:view_repository])
    .returns([200, "[(:vva_event)]"]) \
  do
    handle_listing(VvaEvent, params)
  end


  Endpoint.get('/repositories/:repo_id/vva_events/:id')
    .description("Get an Event by ID")
    .params(["id", :id],
            ["repo_id", :repo_id],
            ["resolve", :resolve])
    .permissions([:view_repository])
    .returns([200, "(:vva_event)"]) \
  do
    json = VvaEvent.to_jsonmodel(params[:id])

    json_response(resolve_references(json, params[:resolve]))
  end


  Endpoint.delete('/repositories/:repo_id/vva_events/:id')
    .description("Delete an Event")
    .params(["id", :id],
            ["repo_id", :repo_id])
    .permissions([:delete_archival_record])
    .returns([200, :deleted]) \
  do
    handle_delete(VvaEvent, params[:id])
  end

end