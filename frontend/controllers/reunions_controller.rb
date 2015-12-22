class ReunionsController < ApplicationController

  set_access_control  "view_repository" => [:index, :show],
                      "update_resource_record" => [:new, :edit, :create, :update],
                      "transfer_archival_record" => [:transfer],
                      "suppress_archival_record" => [:suppress, :unsuppress],
                      "delete_archival_record" => [:delete],
                      "manage_repository" => [:defaults, :update_defaults]



  def index
    @search_data = Search.for_type(session[:repo_id], "reunion", params_for_backend_search.merge({"facet[]" => SearchResultData.ACCESSION_FACETS}))
  end


  def show
    @reunion = fetch_resolved(params[:id])
  end

  def new
    @reunion = Reunion.new({:reunion_date => Date.today.strftime('%Y-%m-%d')})._always_valid!

    if params[:reunion_id]
      tes = Reunion.find(params[:reunion_id], find_opts)

      if tes
        @reunion.populate_from_reunion(tes)
        flash.now[:info] = I18n.t("reunion._frontend.messages.spawned", JSONModelI18nWrapper.new(:reunion => tes))
        flash[:spawned_from_reunion] = tes.id
      end

    elsif user_prefs['default_values']
      defaults = DefaultValues.get 'reunion'

      if defaults
        @reunion.update(defaults.values)
      end
    end

  end



  def defaults
    defaults = DefaultValues.get 'reunion'

    values = defaults ? defaults.form_values : {:reunion_date => Date.today.strftime('%Y-%m-%d')}

    @reunion = Reunion.new(values)._always_valid!

    render "defaults"
  end


  def update_defaults

    begin
      DefaultValues.from_hash({
                                "record_type" => "reunion",
                                "lock_version" => params[:reunion].delete('lock_version'),
                                "defaults" => cleanup_params_for_schema(
                                                                        params[:reunion],
                                                                        JSONModel(:reunion).schema
                                                                        )
                              }).save

      flash[:success] = I18n.t("default_values.messages.defaults_updated")

      redirect_to :controller => :reunions, :action => :defaults
    rescue Exception => e
      flash[:error] = e.message
      redirect_to :controller => :reunions, :action => :defaults
    end

  end

  def edit
    @reunion = fetch_resolved(params[:id])

    if @reunion.suppressed
      redirect_to(:controller => :reunions, :action => :show, :id => params[:id])
    end
  end



  def create
    handle_crud(:instance => :reunion,
                :model => Reunion,
                :on_invalid => ->(){ render action: "new" },
                :on_valid => ->(id){
                    flash[:success] = I18n.t("reunion._frontend.messages.created", JSONModelI18nWrapper.new(:reunion => @reunion))
                    redirect_to(:controller => :reunions,
                                :action => :edit,
                                :id => id) })
  end

  def update
    handle_crud(:instance => :reunion,
                :model => Reunion,
                :obj => fetch_resolved(params[:id]),
                :on_invalid => ->(){
                  return render action: "edit"
                },
                :on_valid => ->(id){
                  flash[:success] = I18n.t("reunion._frontend.messages.updated", JSONModelI18nWrapper.new(:reunion => @reunion))
                  redirect_to :controller => :reunions, :action => :edit, :id => id
                })
  end


  def delete
    reunion = Reunion.find(params[:id])
    reunion.delete

    flash[:success] = I18n.t("reunion._frontend.messages.deleted", JSONModelI18nWrapper.new(:reunion => reunion))
    redirect_to(:controller => :reunions, :action => :index, :deleted_uri => reunion.uri)
  end


  private

  # refactoring note: suspiciously similar to resources_controller.rb
  def fetch_resolved(id)
    reunion = Reunion.find(id, find_opts)

    reunion
  end


end
