# encoding: utf-8
require "rake"
require "rake/tasklib"

module GitPrecommit
  class PrecommitTasks < ::Rake::TaskLib
    TEMPLATE_PATH =
      File.expand_path File.join( File.dirname(__FILE__), '..', '..', 'git-hooks' )
    attr_accessor :template_path
    
    def initialize()
      yield self if block_given?
      @template_path ||= TEMPLATE_PATH
      
      define
    end
    
    def define()
      desc "Install the git pre-commit hook"
      file ".git/hooks/pre-commit" => "#{template_path}/pre-commit" do |t|
        warn "Git pre-commit hook missing, setting up…"
        copy  t.prerequisites.first, t.name
        chmod 0755, t.name
      end

      desc "Install the git post-commit hook"
      file ".git/hooks/post-commit" => "#{template_path}/post-commit" do |t|
        copy t.prerequisites.first, t.name
        chmod 0755, t.name
      end
      
      namespace :git do
        desc "Install the git pre-commit hook"
        task :precommit => ".git/hooks/pre-commit"
        
        desc "Install the git post-commit hook"
        task :postcommit => ".git/hooks/post-commit"
      end
    end
  end
end
