#!/bin/env ruby
require 'nokogiri'
require 'json'

# parse 
class ParseRecord
  # init
  def initialize(id)
    @record_id = id
  end

  # record
  def record
    holt_record = Holt.where(identifier: @record_id).first
    holt_record.thumbnail_file.content
 end
end

usage = 'Usage: ruby ./record-finder.rb {id}'
abort "Error: Expected filename.\n #{usage}" if ARGV.empty?
abort "Error: Too many arguments.\n #{usage}" if ARGV.length > 1

parse = ParseRecord.new(ARGV[0])
puts parse.record
