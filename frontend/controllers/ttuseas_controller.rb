class TtuseasController < ApplicationController

  set_access_control  "view_repository" => [:index, :show],
                      "update_resource_record" => [:new, :edit, :create, :update],
                      "transfer_archival_record" => [:transfer],
                      "suppress_archival_record" => [:suppress, :unsuppress],
                      "delete_archival_record" => [:delete],
                      "manage_repository" => [:defaults, :update_defaults]



  def index
    @search_data = Search.for_type(session[:repo_id], "ttusea", params_for_backend_search.merge({"facet[]" => SearchResultData.ACCESSION_FACETS}))
  end


  def show
    @ttusea = fetch_resolved(params[:id])
  end

  def new
    @ttusea = Ttusea.new({:ttusea_date => Date.today.strftime('%Y-%m-%d')})._always_valid!

    if params[:ttusea_id]
      tes = Ttusea.find(params[:ttusea_id], find_opts)

      if tes
        @ttusea.populate_from_ttusea(tes)
        flash.now[:info] = I18n.t("ttusea._frontend.messages.spawned", JSONModelI18nWrapper.new(:ttusea => tes))
        flash[:spawned_from_ttusea] = tes.id
      end

    elsif user_prefs['default_values']
      defaults = DefaultValues.get 'ttusea'

      if defaults
        @ttusea.update(defaults.values)
      end
    end

  end



  def defaults
    defaults = DefaultValues.get 'ttusea'

    values = defaults ? defaults.form_values : {:ttusea_date => Date.today.strftime('%Y-%m-%d')}

    @ttusea = Ttusea.new(values)._always_valid!

    render "defaults"
  end


  def update_defaults

    begin
      DefaultValues.from_hash({
                                "record_type" => "ttusea",
                                "lock_version" => params[:ttusea].delete('lock_version'),
                                "defaults" => cleanup_params_for_schema(
                                                                        params[:ttusea],
                                                                        JSONModel(:ttusea).schema
                                                                        )
                              }).save

      flash[:success] = I18n.t("default_values.messages.defaults_updated")

      redirect_to :controller => :ttuseas, :action => :defaults
    rescue Exception => e
      flash[:error] = e.message
      redirect_to :controller => :ttuseas, :action => :defaults
    end

  end

  def edit
    @ttusea = fetch_resolved(params[:id])

    if @ttusea.suppressed
      redirect_to(:controller => :ttuseas, :action => :show, :id => params[:id])
    end
  end



  def create
    handle_crud(:instance => :ttusea,
                :model => Ttusea,
                :on_invalid => ->(){ render action: "new" },
                :on_valid => ->(id){
                    flash[:success] = I18n.t("ttusea._frontend.messages.created", JSONModelI18nWrapper.new(:ttusea => @ttusea))
                    redirect_to(:controller => :ttuseas,
                                :action => :edit,
                                :id => id) })
  end

  def update
    handle_crud(:instance => :ttusea,
                :model => Ttusea,
                :obj => fetch_resolved(params[:id]),
                :on_invalid => ->(){
                  return render action: "edit"
                },
                :on_valid => ->(id){
                  flash[:success] = I18n.t("ttusea._frontend.messages.updated", JSONModelI18nWrapper.new(:ttusea => @ttusea))
                  redirect_to :controller => :ttuseas, :action => :edit, :id => id
                })
  end


  def delete
    ttusea = Ttusea.find(params[:id])
    ttusea.delete

    flash[:success] = I18n.t("ttusea._frontend.messages.deleted", JSONModelI18nWrapper.new(:ttusea => ttusea))
    redirect_to(:controller => :ttuseas, :action => :index, :deleted_uri => ttusea.uri)
  end


  private

  # refactoring note: suspiciously similar to resources_controller.rb
  def fetch_resolved(id)
    ttusea = Ttusea.find(id, find_opts)

    ttusea
  end


end
