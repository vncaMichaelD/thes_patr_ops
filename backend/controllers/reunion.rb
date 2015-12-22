class ArchivesSpaceService < Sinatra::Base

  Endpoint.post('/repositories/:repo_id/reunions/:id')
    .description("Update a Reunion")
    .params(["id", :id],
            ["reunion", JSONModel(:reunion), "The updated record", :body => true],
            ["repo_id", :repo_id])
    .permissions([:update_resource_record])
    .returns([200, :updated]) \
  do
    handle_update(Reunion, params[:id], params[:reunion])
  end


  Endpoint.post('/repositories/:repo_id/reunions')
    .description("Create a Reunion")
    .params(["reunion", JSONModel(:reunion), "The record to create", :body => true],
            ["repo_id", :repo_id])
    .permissions([:update_resource_record])
    .returns([200, :created]) \
  do
    handle_create(Reunion, params[:reunion])
  end


  Endpoint.get('/repositories/:repo_id/reunions')
    .description("Get a list of Reunions for a Repository")
    .params(["repo_id", :repo_id])
    .paginated(true)
    .permissions([:view_repository])
    .returns([200, "[(:reunion)]"]) \
  do
    handle_listing(Reunion, params)
  end


  Endpoint.get('/repositories/:repo_id/reunions/:id')
    .description("Get a Reunion by ID")
    .params(["id", :id],
            ["repo_id", :repo_id],
            ["resolve", :resolve])
    .permissions([:view_repository])
    .returns([200, "(:reunion)"]) \
  do
    json = Reunion.to_jsonmodel(params[:id])

    json_response(resolve_references(json, params[:resolve]))
  end


  Endpoint.delete('/repositories/:repo_id/reunions/:id')
    .description("Delete a Reunion")
    .params(["id", :id],
            ["repo_id", :repo_id])
    .permissions([:delete_archival_record])
    .returns([200, :deleted]) \
  do
    handle_delete(Reunion, params[:id])
  end

end