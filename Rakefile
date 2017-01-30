require "bundler/gem_tasks"

require 'rspec/core/rake_task'

namespace :test do
  desc "Run the specs"
  task :spec do
    RSpec::Core::RakeTask.new("test:spec")
  end
end

task :default => "test:spec"