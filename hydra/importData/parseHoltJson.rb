#!/bin/env ruby

ENV['RAILS_ENV'] = 'development' # Set to your desired Rails environment name
require '../config/environment.rb'
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

  def changed?(db_object, object)
    if db_object.collectionNumber != object.collectionNumber   ||
       db_object.collectionName    != object.collectionName    ||
       db_object.identifier        != object.identifier        ||
       db_object.title             != object.title             ||
       db_object.dateCreation      != object.dateCreation      ||
       db_object.creator           != object.creator           ||
       db_object.description       != object.description       ||
       db_object.description2      != object.description2      ||
       db_object.subject           != object.subject           ||
       db_object.physicalsize      != object.physicalsize      ||
       db_object.serieslocation    != object.serieslocation    ||
       db_object.boxlocation       != object.boxlocation       ||
       db_object.folderlocation    != object.folderlocation    ||
       db_object.acquisitionMethod != object.acquisitionMethod
     true
    end
  end

  def changed?(db_object, object) 
    true if db_object != object
  end 

  # def parse
  #   # model = holt
  #   @objects.each do |record|
  #     # check to see if current record is new or already exists
  #     #record_exists = Holt.find(:identifier=>record['identifier'])
  #     # create new
  #
  #     record_exists = []
  #
  #     case record_exists.count
  #     when 0
  #       # Holt.create(
  #       #   collectionNumber: record.collectionNumber,
  #       #   collectionName: record.collectionName,
  #       #   identifier: record.identifier,
  #       #   title: record.title,
  #       #   dateCreation: record.dateCreation,
  #       #   creator: record.creator,
  #       #   description: record.description,
  #       #   description2: record.description2,
  #       #   subject: record.subject,
  #       #   physicalsize: record.physicalsize,
  #       #   serieslocation: record.serieslocation,
  #       #   boxlocation: record.boxlocation,
  #       #   folderlocation: record.folderlocation,
  #       #   acquisitionMethod: record.acquisitionMethod,
  #       #   project: record.project )
  #
  #       puts record['identifier']
  #     when 1
  #       # holt_record = record_exists[0]
  #       puts record.project << " test"
  #     else
  #       # Problem, We should only ever get a 0 or 1 back. if we get more
  #       # than one back we have duplicate identifiers in the system. bad.
  #       puts "Error: Duplicate identifiers #{record['identifier']}"
  #       exit
  #     end # end case
  #   end # end block
  # end  # end parse

  def parse
    @objects.each do |object|
      puts object['identifier']
      if Holt.find(:identifier => object['identifier'])
        puts "record exists"
      else
        puts "record does NOT exist"
      end
    end
  end

end  # end class


parse_holt = ParseHolt.new('./dataFiles/data/holt-data.json')
parse_holt.parse
# puts parse.readfile
