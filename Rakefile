# Rakefile
require "sequel"
require_relative "db"

namespace :db do
  desc "Run database migrations"
  task :migrate do
    Sequel.extension :migration
    Sequel::Migrator.run(DB, "db/migrations")
  end
end
