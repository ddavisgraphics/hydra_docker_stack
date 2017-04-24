# -*- encoding : utf-8 -*-
require 'blacklight/catalog'

class CatalogController < ApplicationController

  include Hydra::Catalog
  # This filter applies the hydra access controls
  # before_action :enforce_show_permissions, only: :show

  configure_blacklight do |config|
   
    ## Default parameters to send to solr for all search-like requests. See also SearchBuilder#processed_parameters
    config.default_solr_params = {
      qt: 'search',
      rows: 10
    }

    # solr field configuration for search results/index views
    config.index.title_field = 'title_tesim'
    config.index.display_type_field = 'has_model_ssim'


    config.add_facet_field solr_name('creator', :facetable), :label => 'Creator', :limit => 10
    config.add_facet_field solr_name('subject', :facetable), :label => 'Subject', :limit => 10
    
    config.add_facet_fields_to_solr_request!

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
    # The ordering of the field names is the order of the display
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

    # This one uses all the defaults set by the solr request handler. Which
    # solr request handler? The one set in config[:default_solr_parameters][:qt],
    # since we aren't specifying it otherwise.

    config.add_search_field 'all_fields', :label => 'All Fields'


    # Now we see how to over-ride Solr request handler defaults, in this
    # case for a BL "search field", which is really a dismax aggregate
    # of Solr search fields.

    config.add_search_field('collectionNumber') do |field|
      field.solr_local_parameters = {
        :qf => '$collectionNumber_qf',
        :pf => '$collectionNumber_pf'
      }
    end

    config.add_search_field('collectionName') do |field|
      field.solr_local_parameters = {
        :qf => '$collectionName_qf',
        :pf => '$collectionName_pf'
      }
    end

    config.add_search_field('identifier') do |field|
      field.solr_local_parameters = {
        :qf => '$identifier_qf',
        :pf => '$identifier_pf'
      }
    end

    config.add_search_field('title') do |field|
      field.solr_local_parameters = {
        :qf => '$title_qf',
        :pf => '$title_pf'
      }
    end

    config.add_search_field('dateCreation') do |field|
      field.solr_local_parameters = {
        :qf => '$dateCreation_qf',
        :pf => '$dateCreation_pf'
      }
    end

    config.add_search_field('creator') do |field|
      field.solr_local_parameters = {
        :qf => '$creator_qf',
        :pf => '$creator_pf'
      }
    end

    config.add_search_field('description') do |field|
      field.solr_local_parameters = {
        :qf => '$description_qf',
        :pf => '$description_pf'
      }
    end

    config.add_search_field('subject') do |field|
      field.solr_local_parameters = {
        :qf => '$subject_qf',
        :pf => '$subject_pf'
      }
    end

    config.add_search_field('physicalsize') do |field|
      field.solr_local_parameters = {
        :qf => '$physicalsize_qf',
        :pf => '$physicalsize_pf'
      }
    end

    config.add_search_field('serieslocation') do |field|
      field.solr_local_parameters = {
        :qf => '$serieslocation_qf',
        :pf => '$serieslocation_pf'
      }
    end

    config.add_search_field('boxlocation') do |field|
      field.solr_local_parameters = {
        :qf => '$boxlocation_qf',
        :pf => '$boxlocation_pf'
      }
    end

    config.add_search_field('folderlocation') do |field|
      field.solr_local_parameters = {
        :qf => '$folderlocation_qf',
        :pf => '$folderlocation_pf'
      }
    end

    config.add_search_field('acquisitionMethod') do |field|
      field.solr_local_parameters = {
        :qf => '$acquisitionMethod_qf',
        :pf => '$acquisitionMethod_pf'
      }
    end

    # "sort results by" select (pulldown)
    # label in pulldown is followed by the name of the SOLR field to sort by and
    # whether the sort is ascending or descending (it must be asc or desc
    # except in the relevancy case).
    config.add_sort_field "identifier_ssi asc", :label => 'Identifier'
    config.add_sort_field "title_ssi asc", :label => 'Title'
    config.add_sort_field "dateCreation_ssi asc", :label => 'Date'
    config.add_sort_field "creator_ssi asc", :label => 'Creator'
    config.add_sort_field 'score desc, identifier_ssi asc', :label => 'relevance'

    # If there are more than this many search results, no spelling ("did you
    # mean") suggestion is offered.
    config.spell_max = 5
  end

end
