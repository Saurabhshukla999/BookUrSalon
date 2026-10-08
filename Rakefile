require "active_record"
require "yaml"
require "erb"
require "dotenv/load"

ROOT = File.expand_path(__dir__)
DB_CONFIG_PATH = File.join(ROOT, "config", "database.yml")

def db_config(env = ENV["RACK_ENV"] || "development")
  yaml = ERB.new(File.read(DB_CONFIG_PATH)).result
  YAML.safe_load(yaml, aliases: true).fetch(env)
end

def establish(env = ENV["RACK_ENV"] || "development")
  ActiveRecord::Base.establish_connection(db_config(env).merge("database" => "postgres"))
end

namespace :db do
  desc "Create the database"
  task :create do
    env = ENV["RACK_ENV"] || "development"
    cfg = db_config(env)
    establish(env)
    ActiveRecord::Base.connection.create_database(cfg["database"])
    puts "Created database #{cfg['database']}"
  rescue ActiveRecord::DatabaseAlreadyExists
    puts "Database #{cfg['database']} already exists"
  end

  desc "Migrate the database"
  task :migrate do
    env = ENV["RACK_ENV"] || "development"
    ActiveRecord::Base.establish_connection(db_config(env))
    ActiveRecord::MigrationContext.new(
      [File.join(ROOT, "db", "migrate")]
    ).migrate
    puts "Migrated #{env}"
  end

  desc "Rollback last migration"
  task :rollback do
    env = ENV["RACK_ENV"] || "development"
    ActiveRecord::Base.establish_connection(db_config(env))
    ActiveRecord::MigrationContext.new(
      [File.join(ROOT, "db", "migrate")]
    ).rollback
  end

  desc "Check migration status"
  task :status do
    env = ENV["RACK_ENV"] || "development"
    ActiveRecord::Base.establish_connection(db_config(env))
    ctx = ActiveRecord::MigrationContext.new(
      [File.join(ROOT, "db", "migrate")]
    )
    ctx.migrations_status.each { |s, v, _| puts "#{s} #{v}" }
  end
end
