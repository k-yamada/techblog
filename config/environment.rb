# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Techblog::Application.initialize!

require "pp"

require 'acts_as_mongo_taggable'
require_relative '../app/models/acts_as_mongo_taggable_ex'
