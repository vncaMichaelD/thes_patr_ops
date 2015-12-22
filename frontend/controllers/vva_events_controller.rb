class VvaEventsController < ApplicationController

  set_access_control  "view_repository" => [:index, :show],
                      "update_resource_record" => [:new, :edit, :create, :update],
                      "transfer_archival_record" => [:transfer],
                      "suppress_archival_record" => [:suppress, :unsuppress],
                      "delete_archival_record" => [:delete],
                      "manage_repository" => [:defaults, :update_defaults]



  def index
    @search_data = Search.for_type(session[:repo_id], "vva_event", params_for_backend_search.merge({"facet[]" => SearchResultData.ACCESSION_FACETS}))
  end


  def show
    @vva_event = fetch_resolved(params[:id])
  end

  def new
    @vva_event = VvaEvent.new({:vva_event_date => Date.today.strftime('%Y-%m-%d')})._always_valid!

    if params[:vva_event_id]
      tes = VvaEvent.find(params[:vva_event_id], find_opts)

      if tes
        @vva_event.populate_from_vva_event(tes)
        flash.now[:info] = I18n.t("vva_event._frontend.messages.spawned", JSONModelI18nWrapper.new(:vva_event => tes))
        flash[:spawned_from_vva_event] = tes.id
      end

    elsif user_prefs['default_values']
      defaults = DefaultValues.get 'vva_event'

      if defaults
        @vva_event.update(defaults.values)
      end
    end

  end



  def defaults
    defaults = DefaultValues.get 'vva_event'

    values = defaults ? defaults.form_values : {:vva_event_date => Date.today.strftime('%Y-%m-%d')}

    @vva_event = VvaEvent.new(values)._always_valid!

    render "defaults"
  end


  def update_defaults

    begin
      DefaultValues.from_hash({
                                "record_type" => "vva_event",
                                "lock_version" => params[:vva_event].delete('lock_version'),
                                "defaults" => cleanup_params_for_schema(
                                                                        params[:vva_event],
                                                                        JSONModel(:vva_event).schema
                                                                        )
                              }).save

      flash[:success] = I18n.t("default_values.messages.defaults_updated")

      redirect_to :controller => :vva_events, :action => :defaults
    rescue Exception => e
      flash[:error] = e.message
      redirect_to :controller => :vva_events, :action => :defaults
    end

  end

  def edit
    @vva_event = fetch_resolved(params[:id])

    if @vva_event.suppressed
      redirect_to(:controller => :vva_events, :action => :show, :id => params[:id])
    end
  end



  def create
    handle_crud(:instance => :vva_event,
                :model => VvaEvent,
                :on_invalid => ->(){ render action: "new" },
                :on_valid => ->(id){
                    flash[:success] = I18n.t("vva_event._frontend.messages.created", JSONModelI18nWrapper.new(:vva_event => @vva_event))
                    redirect_to(:controller => :vva_events,
                                :action => :edit,
                                :id => id) })
  end

  def update
    handle_crud(:instance => :vva_event,
                :model => VvaEvent,
                :obj => fetch_resolved(params[:id]),
                :on_invalid => ->(){
                  return render action: "edit"
                },
                :on_valid => ->(id){
                  flash[:success] = I18n.t("vva_event._frontend.messages.updated", JSONModelI18nWrapper.new(:vva_event => @vva_event))
                  redirect_to :controller => :vva_events, :action => :edit, :id => id
                })
  end


  def delete
    vva_event = VvaEvent.find(params[:id])
    vva_event.delete

    flash[:success] = I18n.t("vva_event._frontend.messages.deleted", JSONModelI18nWrapper.new(:vva_event => vva_event))
    redirect_to(:controller => :vva_events, :action => :index, :deleted_uri => vva_event.uri)
  end


  private

  # refactoring note: suspiciously similar to resources_controller.rb
  def fetch_resolved(id)
    vva_event = VvaEvent.find(id, find_opts)

    vva_event
  end


end
