# frozen_string_literal: true
# This presenter class provides all data needed by the view that show the list of authorities.
module PrependedPresenters::AuthorityListPresenter
  # Override QaServer::AuthorityListPresenter#urls_data method
  # @return [Array<Hash>] A list of status data for each scenario tested plus wikidata and discogs.
  def urls_data
    url_data = @urls_data
    url_data << wikidata_search
    url_data << discogs_release_term
    url_data << discogs_master_term
    url_data << discogs_release_search
    url_data << discogs_master_search
    url_data
  end

  def wikidata_search
    {:type=>:connection,
     :status=>"",
     :authority_name=>:WIKIDATA,
     :subauthority_name=>"item",
     :service=>"NOT linked data",
     :action=>"search",
     :url=>"/authorities/search/wikidata/item?q=milk",
     :expected=>nil,
     :actual=>nil,
     :target=>nil,
     :err_message=>"",
     :request_run_time=>nil,
     :normalization_run_time=>nil}
  end

  def discogs_release_term
    {:type=>:connection,
     :status=>"",
     :authority_name=>:DISCOGS,
     :subauthority_name=>"release",
     :service=>"NOT linked data",
     :action=>"term",
     :url=>"authorities/show/discogs/release/6523540",
     :expected=>nil,
     :actual=>nil,
     :target=>nil,
     :err_message=>"",
     :request_run_time=>nil,
     :normalization_run_time=>nil}
  end

  def discogs_master_term
    {:type=>:connection,
     :status=>"",
     :authority_name=>:DISCOGS,
     :subauthority_name=>"master",
     :service=>"NOT linked data",
     :action=>"term",
     :url=>"authorities/show/discogs/master/144098",
     :expected=>nil,
     :actual=>nil,
     :target=>nil,
     :err_message=>"",
     :request_run_time=>nil,
     :normalization_run_time=>nil}
  end

  def discogs_release_search
    {:type=>:connection,
     :status=>"",
     :authority_name=>:DISCOGS,
     :subauthority_name=>"release",
     :service=>"NOT linked data",
     :action=>"search",
     :url=>"authorities/search/discogs/release?q=sinatra",
     :expected=>nil,
     :actual=>nil,
     :target=>nil,
     :err_message=>"",
     :request_run_time=>nil,
     :normalization_run_time=>nil}
  end

  def discogs_master_search
    {:type=>:connection,
     :status=>"",
     :authority_name=>:DISCOGS,
     :subauthority_name=>"master",
     :service=>"NOT linked data",
     :action=>"search",
     :url=>"authorities/search/discogs/master?q=sinatra",
     :expected=>nil,
     :actual=>nil,
     :target=>nil,
     :err_message=>"",
     :request_run_time=>nil,
     :normalization_run_time=>nil}
  end
end
