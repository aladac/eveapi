begin
  require 'bundler/setup'
rescue LoadError => e
  abort e.message
end

require 'rake'
require 'rubygems'
require 'bundler/gem_tasks'

require 'yard'
YARD::Rake::YardocTask.new
task doc: :yard

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new

require 'pry'

desc 'Run pry console'
task :console do
  require './lib/eveapi'
  require './lib/eveapi/console'
  Pry.start
end

task c: :console
task test: :spec
task default: %i[spec]
