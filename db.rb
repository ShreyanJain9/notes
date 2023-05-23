require "sequel"

DB = Sequel.sqlite("pastebin.db")

require_relative "models"
