# encoding: utf-8

require 'rubygems'

begin
  require 'bundler/setup'
rescue LoadError => e
  abort e.message
end

require 'rake'

require 'bundler/gem_tasks'

require 'rdoc/task'
RDoc::Task.new
task :doc => :rdoc

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new

require 'pry'

desc 'Run pry console'
task :console do
  require './lib/eveapi'
  require './lib/eveapi/console'
  Pry.start
end

task :c => :console
task :test    => :spec
task :default => :spec
