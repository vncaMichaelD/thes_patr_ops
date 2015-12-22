class ArchivesSpaceService < Sinatra::Base

  Endpoint.post('/repositories/:repo_id/operations/:id')
    .description("Update a Operations")
    .params(["id", :id],
            ["operation", JSONModel(:operation), "The updated record", :body => true],
            ["repo_id", :repo_id])
    .permissions([:update_resource_record])
    .returns([200, :updated]) \
  do
    handle_update(Operation, params[:id], params[:operation])
  end


  Endpoint.post('/repositories/:repo_id/operations')
    .description("Create a Operations")
    .params(["operation", JSONModel(:operation), "The record to create", :body => true],
            ["repo_id", :repo_id])
    .permissions([:update_resource_record])
    .returns([200, :created]) \
  do
    handle_create(Operation, params[:operation])
  end


  Endpoint.get('/repositories/:repo_id/operations')
    .description("Get a list of Operationss for a Repository")
    .params(["repo_id", :repo_id])
    .paginated(true)
    .permissions([:view_repository])
    .returns([200, "[(:operation)]"]) \
  do
    handle_listing(Operation, params)
  end


  Endpoint.get('/repositories/:repo_id/operations/:id')
    .description("Get a Operations by ID")
    .params(["id", :id],
            ["repo_id", :repo_id],
            ["resolve", :resolve])
    .permissions([:view_repository])
    .returns([200, "(:operation)"]) \
  do
    json = Operation.to_jsonmodel(params[:id])

    json_response(resolve_references(json, params[:resolve]))
  end


  Endpoint.delete('/repositories/:repo_id/operations/:id')
    .description("Delete a Operations")
    .params(["id", :id],
            ["repo_id", :repo_id])
    .permissions([:delete_archival_record])
    .returns([200, :deleted]) \
  do
    handle_delete(Operation, params[:id])
  end

end