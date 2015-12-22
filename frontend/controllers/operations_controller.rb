class OperationsController < ApplicationController

  set_access_control  "view_repository" => [:index, :show],
                      "update_resource_record" => [:new, :edit, :create, :update],
                      "transfer_archival_record" => [:transfer],
                      "suppress_archival_record" => [:suppress, :unsuppress],
                      "delete_archival_record" => [:delete],
                      "manage_repository" => [:defaults, :update_defaults]



  def index
    @search_data = Search.for_type(session[:repo_id], "operation", params_for_backend_search.merge({"facet[]" => SearchResultData.ACCESSION_FACETS}))
  end


  def show
    @operation = fetch_resolved(params[:id])
  end

  def new
    @operation = Operation.new({:operation_date => Date.today.strftime('%Y-%m-%d')})._always_valid!

    if params[:operation_id]
      tes = Operation.find(params[:operation_id], find_opts)

      if tes
        @operation.populate_from_operation(tes)
        flash.now[:info] = I18n.t("operation._frontend.messages.spawned", JSONModelI18nWrapper.new(:operation => tes))
        flash[:spawned_from_operation] = tes.id
      end

    elsif user_prefs['default_values']
      defaults = DefaultValues.get 'operation'

      if defaults
        @operation.update(defaults.values)
      end
    end

  end



  def defaults
    defaults = DefaultValues.get 'operation'

    values = defaults ? defaults.form_values : {:operation_date => Date.today.strftime('%Y-%m-%d')}

    @operation = Operation.new(values)._always_valid!

    render "defaults"
  end


  def update_defaults

    begin
      DefaultValues.from_hash({
                                "record_type" => "operation",
                                "lock_version" => params[:operation].delete('lock_version'),
                                "defaults" => cleanup_params_for_schema(
                                                                        params[:operation],
                                                                        JSONModel(:operation).schema
                                                                        )
                              }).save

      flash[:success] = I18n.t("default_values.messages.defaults_updated")

      redirect_to :controller => :operations, :action => :defaults
    rescue Exception => e
      flash[:error] = e.message
      redirect_to :controller => :operations, :action => :defaults
    end

  end

  def edit
    @operation = fetch_resolved(params[:id])

    if @operation.suppressed
      redirect_to(:controller => :operations, :action => :show, :id => params[:id])
    end
  end



  def create
    handle_crud(:instance => :operation,
                :model => Operation,
                :on_invalid => ->(){ render action: "new" },
                :on_valid => ->(id){
                    flash[:success] = I18n.t("operation._frontend.messages.created", JSONModelI18nWrapper.new(:operation => @operation))
                    redirect_to(:controller => :operations,
                                :action => :edit,
                                :id => id) })
  end

  def update
    handle_crud(:instance => :operation,
                :model => Operation,
                :obj => fetch_resolved(params[:id]),
                :on_invalid => ->(){
                  return render action: "edit"
                },
                :on_valid => ->(id){
                  flash[:success] = I18n.t("operation._frontend.messages.updated", JSONModelI18nWrapper.new(:operation => @operation))
                  redirect_to :controller => :operations, :action => :edit, :id => id
                })
  end


  def delete
    operation = Operation.find(params[:id])
    operation.delete

    flash[:success] = I18n.t("operation._frontend.messages.deleted", JSONModelI18nWrapper.new(:operation => operation))
    redirect_to(:controller => :operations, :action => :index, :deleted_uri => operation.uri)
  end


  private

  # refactoring note: suspiciously similar to resources_controller.rb
  def fetch_resolved(id)
    operation = Operation.find(id, find_opts)

    operation
  end


end
