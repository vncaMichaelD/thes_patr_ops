class ArchivesSpaceService < Sinatra::Base

  Endpoint.post('/repositories/:repo_id/conferences/:id')
    .description("Update a Conference")
    .params(["id", :id],
            ["conference", JSONModel(:conference), "The updated record", :body => true],
            ["repo_id", :repo_id])
    .permissions([:update_resource_record])
    .returns([200, :updated]) \
  do
    handle_update(Conference, params[:id], params[:conference])
  end


  Endpoint.post('/repositories/:repo_id/conferences')
    .description("Create a Conference")
    .params(["conference", JSONModel(:conference), "The record to create", :body => true],
            ["repo_id", :repo_id])
    .permissions([:update_resource_record])
    .returns([200, :created]) \
  do
    handle_create(Conference, params[:conference])
  end


  Endpoint.get('/repositories/:repo_id/conferences')
    .description("Get a list of Conferences for a Repository")
    .params(["repo_id", :repo_id])
    .paginated(true)
    .permissions([:view_repository])
    .returns([200, "[(:conference)]"]) \
  do
    handle_listing(Conference, params)
  end


  Endpoint.get('/repositories/:repo_id/conferences/:id')
    .description("Get a Conference by ID")
    .params(["id", :id],
            ["repo_id", :repo_id],
            ["resolve", :resolve])
    .permissions([:view_repository])
    .returns([200, "(:conference)"]) \
  do
    json = Conference.to_jsonmodel(params[:id])

    json_response(resolve_references(json, params[:resolve]))
  end


  Endpoint.delete('/repositories/:repo_id/conferences/:id')
    .description("Delete a Conference")
    .params(["id", :id],
            ["repo_id", :repo_id])
    .permissions([:delete_archival_record])
    .returns([200, :deleted]) \
  do
    handle_delete(Conference, params[:id])
  end

end