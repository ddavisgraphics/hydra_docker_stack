# -*- encoding : utf-8 -*-
require 'blacklight/catalog'

class CatalogController < ApplicationController

  include Hydra::Catalog
  # This filter applies the hydra access controls
  # before_action :enforce_show_permissions, only: :show

  configure_blacklight do |config|
    ## Class for sending and receiving requests from a search index
    # config.repository_class = Blacklight::Solr::Repository
    
    ## Class for converting Blacklight's url parameters to into request parameters for the search index
    config.search_builder_class = ::SearchBuilder
    
    ## Model that maps search index responses to the blacklight response model
    # config.response_model = Blacklight::Solr::Response

    ## Default parameters to send to solr for all search-like requests. See also SearchBuilder#processed_parameters
    config.default_solr_params = {
      qf: 'identifier_tesim collectionNumber_tesim collectionName_tesim title_tesim dateCreation_tesim creator_tesim description_tesim description2_tesim subject_tesim physicalsize_tesim serieslocation_tesim boxlocation_tesim folderlocation_tesim acquisitionMethod_tesim project_tesim',
      qt: 'search',
      rows: 12,
      facet: true
    }

    # solr field configuration for search results/index views
    config.index.title_field        = 'title_tesim'
    config.index.display_type_field = 'has_model_ssim'

    # solr fields that will be treated as facets by the blacklight application
    #   The ordering of the field names is the order of the display
    # :show may be set to false if you don't want the facet to be drawn in the
    # facet bar
    config.add_facet_field solr_name('creator', :facetable), :label => 'Creator', :limit => 10
    config.add_facet_field solr_name('subject', :facetable), :label => 'Subject', :limit => 10

    # Have BL send all facet field names to Solr, which has been the default
    # previously. Simply remove these lines if you'd rather use Solr request
    # handler defaults, or have no facets.
    config.default_solr_params[:'facet.field'] = config.facet_fields.keys
    #use this instead if you don't want to query facets marked :show=>false
    #config.default_solr_params[:'facet.field'] = config.facet_fields.select{ |k, v| v[:show] != false}.keys


    # solr fields to be displayed in the index (search results) view
    #   The ordering of the field names is the order of the display
    config.add_index_field solr_name('identifier',    :stored_searchable, type: :string), :label => 'Identifier:'
    config.add_index_field solr_name('title',         :stored_searchable, type: :string), :label => 'Title:'
    config.add_index_field solr_name('dateCreation', :stored_searchable, type: :string), :label => 'Creation Date:'

    # solr fields to be displayed in the show (single result) view
    #   The ordering of the field names is the order of the display
    config.add_show_field solr_name('collectionNumber', :stored_searchable, type: :string), :label => 'A&M Number:'
    config.add_show_field solr_name('collectionName', :stored_searchable, type: :string), :label => 'Collection Name:'
    config.add_show_field solr_name('identifier', :stored_searchable, type: :string), :label => 'Identifier:'
    config.add_show_field solr_name('title', :stored_searchable, type: :string), :label => 'Title:'
    config.add_show_field solr_name('dateCreation', :stored_searchable, type: :string), :label => 'Creation Date:'
    config.add_show_field solr_name('creator', :stored_searchable, type: :string), :label => 'Creator:'
    config.add_show_field solr_name('description', :stored_searchable, type: :string), :label => 'Transcript:'
    config.add_show_field solr_name('subject', :stored_searchable, type: :string), :label => 'Subjects:'
    config.add_show_field solr_name('physicalsize', :stored_searchable, type: :string), :label => 'Physical Size:'
    config.add_show_field solr_name('serieslocation', :stored_searchable, type: :string), :label => 'Series Location:'
    config.add_show_field solr_name('boxlocation', :stored_searchable, type: :string), :label => 'Box Location:'
    config.add_show_field solr_name('folderlocation', :stored_searchable, type: :string), :label => 'Folder Location:'
    config.add_show_field solr_name('acquisitionMethod', :stored_searchable, type: :string), :label => 'Acquisition Method:'

    # "fielded" search configuration. Used by pulldown among other places.
    # For supported keys in hash, see rdoc for Blacklight::SearchFields
    #
    # Search fields will inherit the :qt solr request handler from
    # config[:default_solr_parameters], OR can specify a different one
    # with a :qt key/value. Below examples inherit, except for subject
    # that specifies the same :qt as default for our own internal
    # testing purposes.
    #
    # The :key is what will be used to identify this BL search field internally,
    # as well as in URLs -- so changing it after deployment may break bookmarked
    # urls.  A display label will be automatically calculated from the :key,
    # or can be specified manually to be different.

    # This one uses all the defaults set by the solr request handler. Which
    # solr request handler? The one set in config[:default_solr_parameters][:qt],
    # since we aren't specifying it otherwise.

    config.add_search_field 'all_fields', label: 'All Fields'


    # Now we see how to over-ride Solr request handler defaults, in this
    # case for a BL "search field", which is really a dismax aggregate
    # of Solr search fields.

    config.add_search_field('identifier') do |field|
      identifier_field = Solrizer.solr_name("identifier", :stored_searchable)
      field.solr_local_parameters = {
        qf: identifier_field,
        pf: identifier_field
      }
    end

    config.add_search_field('subject') do |field|
      subject_field = Solrizer.solr_name("subject", :stored_searchable)
      field.solr_local_parameters = { 
        qf: subject_field,
        pf: subject_field
      }
    end

    config.add_search_field('title') do |field|
      title_field = Solrizer.solr_name("title", :stored_searchable)
      field.solr_local_parameters = { 
        qf: title_field,
        pf: title_field
      }
    end

    config.add_search_field('description') do |field|
      description_field = Solrizer.solr_name("description", :stored_searchable)
      field.solr_local_parameters = {
        qf: description_field,
        pf: description_field
      }
    end

     config.add_search_field('creator') do |field|
      creator_field = Solrizer.solr_name("creator", :stored_searchable)
      field.solr_local_parameters = {
        qf: creator_field,
        pf: creator_field
      }
    end

    config.add_search_field('dateCreation') do |field|
      date_creation_field = Solrizer.solr_name("dateCreation", :stored_searchable)
      field.solr_local_parameters = {
        qf: date_creation_field,
        pf: date_creation_field
      }
    end

    config.add_search_field('collectionNumber') do |field|
      collection_number = Solrizer.solr_name("collectionNumber", :stored_searchable)
      field.solr_local_parameters = {
        qf: collection_number,
        pf: collection_number
      }
    end

    config.add_search_field('physical_size') do |field|
      physicalsize_field = Solrizer.solr_name("physicalsize", :stored_searchable)
      field.solr_local_parameters = {
        qf: physicalsize_field,
        pf: physicalsize_field
      }
    end

    config.add_search_field('series_location') do |field|
      serieslocation_field = Solrizer.solr_name("serieslocation", :stored_searchable)
      field.solr_local_parameters = {
        qf: serieslocation_field,
        pf: serieslocation_field
      }
    end

    config.add_search_field('box_location') do |field|
      boxlocation_field = Solrizer.solr_name("boxlocation", :stored_searchable)
      field.solr_local_parameters = {
        qf: boxlocation_field,
        pf: boxlocation_field
      }
    end

    config.add_search_field('folder_location') do |field|
      folderlocation_field = Solrizer.solr_name("folderlocation", :stored_searchable)
      field.solr_local_parameters = {
        qf: folderlocation_field,
        pf: folderlocation_field
      }
    end

    config.add_search_field('acquisition_method') do |field|
      acquisition_method_field = Solrizer.solr_name("acquisitionMethod", :stored_searchable)
      field.solr_local_parameters = {
        qf: acquisition_method_field,
        pf: acquisition_method_field
      }
    end

    sort_date = Solrizer.solr_name('dateCreation', :stored_sortable, type: :string)
    sort_title = Solrizer.solr_name('title', :stored_sortable, type: :string)
    sort_creator = Solrizer.solr_name('creator', :stored_sortable, type: :string)
    sort_identifier = Solrizer.solr_name('identifier', :stored_sortable, type: :string)

    # "sort results by" select (pulldown)
    # label in pulldown is followed by the name of the SOLR field to sort by and
    # whether the sort is ascending or descending (it must be asc or desc
    # except in the relevancy case).
    config.add_sort_field "#{sort_identifier} asc", :label => 'Identifier (asc)'
    config.add_sort_field "#{sort_identifier} desc", :label => 'Identifier (desc)'
    config.add_sort_field "#{sort_title} asc", :label => 'Title (A-Z)'
    config.add_sort_field "#{sort_title} desc", :label => 'Title (Z-A)'
    config.add_sort_field "#{sort_date} asc", :label => 'Date (newest first)'
    config.add_sort_field "#{sort_creator} asc", :label => 'Creator (A-Z)'
    config.add_sort_field "#{sort_creator} desc", :label => 'Creator (Z-A)'
    config.add_sort_field "score desc, #{sort_identifier} asc", :label => 'Relevance'

    # If there are more than this many search results, no spelling ("did you
    # mean") suggestion is offered.
    config.spell_max = 5
  end
end