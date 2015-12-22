class ArchivesSpaceService < Sinatra::Base

  Endpoint.post('/repositories/:repo_id/ttuseas/:id')
    .description("Update a Techsan")
    .params(["id", :id],
            ["ttusea", JSONModel(:ttusea), "The updated record", :body => true],
            ["repo_id", :repo_id])
    .permissions([:update_resource_record])
    .returns([200, :updated]) \
  do
    handle_update(Ttusea, params[:id], params[:ttusea])
  end


  Endpoint.post('/repositories/:repo_id/ttuseas')
    .description("Create a Techsan")
    .params(["ttusea", JSONModel(:ttusea), "The record to create", :body => true],
            ["repo_id", :repo_id])
    .permissions([:update_resource_record])
    .returns([200, :created]) \
  do
    handle_create(Ttusea, params[:ttusea])
  end


  Endpoint.get('/repositories/:repo_id/ttuseas')
    .description("Get a list of Techsans for a Repository")
    .params(["repo_id", :repo_id])
    .paginated(true)
    .permissions([:view_repository])
    .returns([200, "[(:ttusea)]"]) \
  do
    handle_listing(Ttusea, params)
  end


  Endpoint.get('/repositories/:repo_id/ttuseas/:id')
    .description("Get a Techsan by ID")
    .params(["id", :id],
            ["repo_id", :repo_id],
            ["resolve", :resolve])
    .permissions([:view_repository])
    .returns([200, "(:ttusea)"]) \
  do
    json = Ttusea.to_jsonmodel(params[:id])

    json_response(resolve_references(json, params[:resolve]))
  end


  Endpoint.delete('/repositories/:repo_id/ttuseas/:id')
    .description("Delete a Techsan")
    .params(["id", :id],
            ["repo_id", :repo_id])
    .permissions([:delete_archival_record])
    .returns([200, :deleted]) \
  do
    handle_delete(Ttusea, params[:id])
  end

end