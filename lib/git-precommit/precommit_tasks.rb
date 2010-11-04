# -*- encoding: utf-8 -*-
require "rake"
require "rake/tasklib"

module GitPrecommit
  class PrecommitTasks < ::Rake::TaskLib
    TEMPLATE_PATH =
      File.expand_path File.join( File.dirname(__FILE__), '..', '..', 'git-hooks' )
    attr_accessor :template_path
    
    def initialize( options={} )
      @options = {
        :draconian => false
      }.merge options
      
      yield self if block_given?
      @template_path ||= TEMPLATE_PATH
      
      define
    end
    
    def define()
      pre_commit     = ".git/hooks/pre-commit"
      pre_commit_src = "#{template_path}/pre-commit"
      
      task :dragon do |t|
        if @options[:draconian]
          copy  pre_commit_src, pre_commit
          chmod 0755, pre_commit
        end
      end

      deps =  [pre_commit_src]
      deps += [:dragon] if @options[:draconian]
      
      desc "Install the git pre-commit hook"
      file pre_commit => deps do |t|
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
        task :precommit => pre_commit
        
        desc "Install the git post-commit hook"
        task :postcommit => ".git/hooks/post-commit"
      end
    end
  end
end
