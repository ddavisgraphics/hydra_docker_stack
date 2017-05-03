class Holt < ActiveFedora::Base
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

  property :collectionName, predicate: ::RDF::Vocab::DC.alternative, multiple: false do |index|
    index.as :stored_searchable # this produces the _tesim suffix
  end
  
  property :collectionNumber, predicate: ::RDF::Vocab::DC.source, multiple: false do |index|
    index.as :stored_searchable # this produces the _tesim suffix
  end
  
  property :physicalsize, predicate: ::RDF::Vocab::DC.format, multiple: false do |index|
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

  # reference from mgiarlo and jconyne on hydra slack 
  # spec https://github.com/projecthydra/active_fedora/blob/a641a8f0d65e7c01f395eeb58c5e87c638395e2e/spec/integration/directly_contains_one_association_spec.rb 
  directly_contains :files, has_member_relation: ::RDF::URI("http://pcdm.org/models#File"), class_name: "HoltFile"
  directly_contains_one :image_file, through: :files, type: ::RDF::URI('http://pcdm.org/use#ServiceFile'), class_name: "HoltFile"
  directly_contains_one :thumbnail_file, through: :files, type: ::RDF::URI('http://pcdm.org/use#ThumbnailImage'), class_name: "HoltFile"
end