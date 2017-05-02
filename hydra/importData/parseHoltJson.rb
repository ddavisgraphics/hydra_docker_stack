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

  # split a subject string to array
  def split_subjects(str)
    str.split('|||')
  end

  # file exists? 
  def file_exists?(file_path)
    
  end 

  # parse that stuff 
  def parse
    message_bit = nil
    @objects.each do |record|
      project = ['holt']
      base_path = 'importData/dataFiles'
      image_path = "#{base_path}/jpg/#{record['identifier']}.jpg"
      thumb_path = "#{base_path}/thumbs/#{record['identifier']}.jpg"
      subjects =  split_subjects record['subject']
      record_exists = Holt.where(identifier: record['identifier'])

      case record_exists.count
      when 0
        holt_image = Holt.create
        holt_image.collectionNumber = record['collectionNumber']
        holt_image.collectionName = record['collectionName']
        holt_image.identifier = record['identifier']
        holt_image.title = record['title']
        holt_image.dateCreation = record['dateCreation']
        holt_image.creator = record['creator']
        holt_image.description = record['description']
        holt_image.description2 = record['description2']
        holt_image.subject = subjects
        holt_image.physicalsize = record['physicalsize']
        holt_image.serieslocation = record['serieslocation']
        holt_image.boxlocation = record['boxlocation']
        holt_image.folderlocation = record['folderlocation']
        holt_image.acquisitionMethod = record['acquisitionMethod']
        holt_image.project = project
        holt_image.save!

        files = holt_image.files.build

        if File.exists?(image_path) 
          primary_file = holt_image.build_image_file
          primary_file.content = File.open(image_path)
        end

        if File.exists?(thumb_path) 
          thumb_file = holt_image.build_thumbnail_file
          thumb_file.content = File.open(thumb_path)
        end

        holt_image.save!
        holt_image.to_solr
        message_bit = 1
      when 1
        holt_image = record_exists[0]
        if changed?(holt_image, record)
          holt_image.collectionNumber = record['collectionNumber']
          holt_image.collectionName = record['collectionName']
          holt_image.identifier = record['identifier']
          holt_image.title = record['title']
          holt_image.dateCreation = record['dateCreation']
          holt_image.creator = record['creator']
          holt_image.description = record['description']
          holt_image.description2 = record['description2']
          holt_image.subject = subjects
          holt_image.physicalsize = record['physicalsize']
          holt_image.serieslocation = record['serieslocation']
          holt_image.boxlocation = record['boxlocation']
          holt_image.folderlocation = record['folderlocation']
          holt_image.acquisitionMethod = record['acquisitionMethod']
          holt_image.project = project
        end
        message_bit = 2
      else
        # Problem, We should only ever get a 0 or 1 back. if we get more
        # than one back we have duplicate identifiers in the system. bad.
        abort "Error: Duplicate identifiers #{record['identifier']}"
      end # end case
      holt_image.save
      holt_image.to_solr
    end # end block
    Feedback.message message_bit
  end  # end parse
end  # end class


# abstract feedback class out to static class 
class Feedback
  # message
  def self.message(type)
    case type
    when 0
      'Failure to parse the document'
    when 1
      'Success parsing the document'
    when 2
      'Success updating the document'
    else
      'Something happened, I\'m not sure what'
    end
  end
end

puts ' ----------------------------------------- '
puts ' Parsing Import Now '
puts ' ----------------------------------------- '

parse_holt = ParseHolt.new('./importData/dataFiles/data/holt-data-single.json')
puts parse_holt.parse

puts ' ----------------------------------------- '
puts ' Import completed'
puts ' ----------------------------------------- '