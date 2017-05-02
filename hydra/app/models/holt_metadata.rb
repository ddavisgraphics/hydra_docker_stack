class HoltMetadata < ActiveFedora::Base
  include Hydra::Works::WorkBehavior

  # title
  property :title, predicate: ::RDF::Vocab::DC.title, multiple: false do |index|
    index.as :stored_searchable # this produces the _tesim suffix
  end

  # identifier
  property :identifier, predicate: ::RDF::Vocab::DC.identifier, multiple: false do |index|
    index.as :stored_searchable # this produces the _tesim suffix
  end


  # dateCreation
  property :dateCreation, predicate: ::RDF::Vocab::DC.date, multiple: false do |index|
    index.as :stored_searchable # this produces the _tesim suffix
  end

  # creator 
  property :creator, predicate: ::RDF::Vocab::DC.creator, multiple: false do |index|
    index.as :stored_searchable # this produces the _tesim suffix
  end

  # descriptions 
  property :description, predicate: ::RDF::Vocab::DC.description, multiple: false do |index|
    index.as :stored_searchable # this produces the _tesim suffix
  end

  property :description2, predicate: ::RDF::Vocab::DC.description, multiple: false do |index|
    index.as :stored_searchable # this produces the _tesim suffix
  end

  # subjects
  property :subject, predicate: ::RDF::Vocab::DC.subject, multiple: true do |index|
    index.as :stored_searchable # this produces the _tesim suffix
  end

  # source
  property :acquisitionMethod, predicate: ::RDF::Vocab::DC.accrualMethod, multiple: false do |index|
    index.as :stored_searchable # this produces the _tesim suffix
  end

  property :collectionName, predicate: ::RDF::Vocab::DC.source, multiple: false do |index|
    index.as :stored_searchable # this produces the _tesim suffix
  end

  property :collectionNumber, predicate: ::RDF::Vocab::DC.source, multiple: false do |index|
    index.as :stored_searchable # this produces the _tesim suffix
  end

  property :physicalsize, predicate: ::RDF::Vocab::DC.source, multiple: false do |index|
    index.as :stored_searchable # this produces the _tesim suffix
  end

  property :serieslocation, predicate: ::RDF::Vocab::DC.source, multiple: false do |index|
    index.as :stored_searchable # this produces the _tesim suffix
  end

  property :boxlocation, predicate: ::RDF::Vocab::DC.source, multiple: false do |index|
    index.as :stored_searchable # this produces the _tesim suffix
  end

  property :folderlocation, predicate: ::RDF::Vocab::DC.source, multiple: false do |index|
    index.as :stored_searchable # this produces the _tesim suffix
  end

  property :project, predicate: ::RDF::Vocab::DC.isPartOf, multiple: true do |index|
    index.as :stored_searchable # this produces the _tesim suffix
  end
end
