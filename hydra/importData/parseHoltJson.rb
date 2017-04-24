#!/bin/env ruby
require 'nokogiri'
require 'json'

# This is the intializer or parser for hydra holt project
# Author:: David J. Davis  (mailto:djdavis@mail.wvu.edu)
# The goal of this class is to process the holt
class ParseHolt
  # init
  def initialize(filename)
    json = File.read(filename)
    @objects = JSON.parse(json)
  end

  # looks to see if a record is changed
  def changed?(db_object, object)
    db_object != object ? true : false
  end

  def parse
    @objects.each do |record|
      # check to see if current record is new or already exists
      record_exists = Holt.find(:identifier=>record['identifier'])
      # case 
      case record_exists.count
      when 0
        holt_image = Holt.create(
          collectionNumber: record.collectionNumber,
          collectionName: record.collectionName,
          identifier: record.identifier,
          title: record.title,
          dateCreation: record.dateCreation,
          creator: record.creator,
          description: record.description,
          description2: record.description2,
          subject: record.subject,
          physicalsize: record.physicalsize,
          serieslocation: record.serieslocation,
          boxlocation: record.boxlocation,
          folderlocation: record.folderlocation,
          acquisitionMethod: record.acquisitionMethod,
          project: record.project 
        )  
      when 1
        holt_image = record_exists[0]
        if changed?(holt_image, record)
          holt_image.collectionNumber = record.collectionNumber
          holt_image.collectionName = record.collectionName
          holt_image.identifier = record.identifier
          holt_image.title = record.title
          holt_image.dateCreation = record.dateCreation
          holt_image.creator = record.creator
          holt_image.description = record.description
          holt_image.description2 = record.description2
          holt_image.subject = record.subject
          holt_image.physicalsize = record.physicalsize
          holt_image.serieslocation = record.serieslocation
          holt_image.boxlocation = record.boxlocation
          holt_image.folderlocation = record.folderlocation
          holt_image.acquisitionMethod = record.acquisitionMethod
        end
      else
        # Problem, We should only ever get a 0 or 1 back. if we get more
        # than one back we have duplicate identifiers in the system. bad.
        abort "Error: Duplicate identifiers #{record['identifier']}"
      end # end case
    end # end block
  end  # end parse
end  # end class

puts ' ----------------------------------------- '
puts ' Parsing Import Now '
puts ' ----------------------------------------- '

parse_holt = ParseHolt.new('./importData/dataFiles/data/holt-data.json')
parse_holt.parse 

puts ' ----------------------------------------- '
puts ' Import completed'
puts ' ----------------------------------------- '