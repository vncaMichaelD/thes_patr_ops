class ConferencesController < ApplicationController

  set_access_control  "view_repository" => [:index, :show],
                      "update_resource_record" => [:new, :edit, :create, :update],
                      "transfer_archival_record" => [:transfer],
                      "suppress_archival_record" => [:suppress, :unsuppress],
                      "delete_archival_record" => [:delete],
                      "manage_repository" => [:defaults, :update_defaults]



  def index
    @search_data = Search.for_type(session[:repo_id], "conference", params_for_backend_search.merge({"facet[]" => SearchResultData.ACCESSION_FACETS}))
  end


  def show
    @conference = fetch_resolved(params[:id])
  end

  def new
    @conference = Conference.new({:conference_date => Date.today.strftime('%Y-%m-%d')})._always_valid!

    if params[:conference_id]
      tes = Conference.find(params[:conference_id], find_opts)

      if tes
        @conference.populate_from_conference(tes)
        flash.now[:info] = I18n.t("conference._frontend.messages.spawned", JSONModelI18nWrapper.new(:conference => tes))
        flash[:spawned_from_conference] = tes.id
      end

    elsif user_prefs['default_values']
      defaults = DefaultValues.get 'conference'

      if defaults
        @conference.update(defaults.values)
      end
    end

  end



  def defaults
    defaults = DefaultValues.get 'conference'

    values = defaults ? defaults.form_values : {:conference_date => Date.today.strftime('%Y-%m-%d')}

    @conference = Conference.new(values)._always_valid!

    render "defaults"
  end


  def update_defaults

    begin
      DefaultValues.from_hash({
                                "record_type" => "conference",
                                "lock_version" => params[:conference].delete('lock_version'),
                                "defaults" => cleanup_params_for_schema(
                                                                        params[:conference],
                                                                        JSONModel(:conference).schema
                                                                        )
                              }).save

      flash[:success] = I18n.t("default_values.messages.defaults_updated")

      redirect_to :controller => :conferences, :action => :defaults
    rescue Exception => e
      flash[:error] = e.message
      redirect_to :controller => :conferences, :action => :defaults
    end

  end

  def edit
    @conference = fetch_resolved(params[:id])

    if @conference.suppressed
      redirect_to(:controller => :conferences, :action => :show, :id => params[:id])
    end
  end



  def create
    handle_crud(:instance => :conference,
                :model => Conference,
                :on_invalid => ->(){ render action: "new" },
                :on_valid => ->(id){
                    flash[:success] = I18n.t("conference._frontend.messages.created", JSONModelI18nWrapper.new(:conference => @conference))
                    redirect_to(:controller => :conferences,
                                :action => :edit,
                                :id => id) })
  end

  def update
    handle_crud(:instance => :conference,
                :model => Conference,
                :obj => fetch_resolved(params[:id]),
                :on_invalid => ->(){
                  return render action: "edit"
                },
                :on_valid => ->(id){
                  flash[:success] = I18n.t("conference._frontend.messages.updated", JSONModelI18nWrapper.new(:conference => @conference))
                  redirect_to :controller => :conferences, :action => :edit, :id => id
                })
  end


  def delete
    conference = Conference.find(params[:id])
    conference.delete

    flash[:success] = I18n.t("conference._frontend.messages.deleted", JSONModelI18nWrapper.new(:conference => conference))
    redirect_to(:controller => :conferences, :action => :index, :deleted_uri => conference.uri)
  end


  private

  # refactoring note: suspiciously similar to resources_controller.rb
  def fetch_resolved(id)
    conference = Conference.find(id, find_opts)

    conference
  end


end
