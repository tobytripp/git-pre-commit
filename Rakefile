require "rake"
require "rdoc/task"

begin
  require 'bundler/setup'
  Bundler::GemHelper.install_tasks
rescue LoadError
  puts "Bundler not available. Install it with: gem install bundler"
end

Dir["./tasks/**/*.rake"].each { |task| load task }

require "git_precommit"
GitPrecommit::PrecommitTasks.new

task :default => ".git/hooks/pre-commit"
task :precommit => :default
