class Holt < ActiveFedora::Base

  has_metadata 'descMetadata',   type: HoltMetadata

  has_file_datastream "digitalImage"
  has_file_datastream "thumbnail"

  has_attributes :collectionNumber,  datastream: 'descMetadata'
  has_attributes :collectionName,    datastream: 'descMetadata'
  has_attributes :identifier,        datastream: 'descMetadata', unique: true
  has_attributes :title,             datastream: 'descMetadata'
  has_attributes :dateCreation,      datastream: 'descMetadata'
  has_attributes :creator,           datastream: 'descMetadata'

  has_attributes :description,       datastream: 'descMetadata'
  has_attributes :description2,      datastream: 'descMetadata'

  has_attributes :subject,           datastream: 'descMetadata', multiple: true
  has_attributes :physicalsize,      datastream: 'descMetadata'
  has_attributes :serieslocation,    datastream: 'descMetadata'
  has_attributes :boxlocation,       datastream: 'descMetadata'
  has_attributes :folderlocation,    datastream: 'descMetadata'
  has_attributes :acquisitionMethod, datastream: 'descMetadata'
  has_attributes :project,           datastream: 'descMetadata', multiple: true


    def getImage(type)
        if type == 'thumbnail'
            thumbnail.content
        else
            digitalImage.content
        end
    end
end