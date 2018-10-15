# frozen_string_literal: true

require 'logger'
require 'rainbow'
require 'sequel'

logger = Logger.new(STDOUT)
logger.formatter = proc do |_severity, _datetime, _progname, msg|
  Rainbow('PostgreSQL').bold.red + ' :: ' + Rainbow(msg).bold.magenta + "\n"
end

DB = Sequel.connect(ENV['DATABASE_URL'])
DB.loggers << logger

Sequel::Model.unrestrict_primary_key
Sequel::Model.plugin(:association_pks)

require_all 'src/models/*.rb'
