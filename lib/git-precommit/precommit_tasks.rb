# -*- encoding: utf-8 -*-
require "rake"
require "rake/tasklib"

module GitPrecommit
  class PrecommitTasks < ::Rake::TaskLib
    TEMPLATE_PATH = File.expand_path(
      File.join( File.dirname(__FILE__), '..', '..', 'git-hooks' )
      )
    attr_accessor :template_path

    def initialize( options={} )
      @options = {
        :draconian => false,
        :path      => TEMPLATE_PATH
      }.merge options

      @options[:draconian] = true if options[:path]

      yield self if block_given?
      @template_path ||= @options[:path]

      define
    end

    def define()
      pre_commit     = "#{git_dir}/hooks/pre-commit"
      pre_commit_src = "#{template_path}/pre-commit"

      task :overwrite

      deps =  [pre_commit_src]
      deps += [:overwrite] if @options[:draconian]

      desc "Install the git pre-commit hook"
      file pre_commit => deps do |t|
        copy  t.prerequisites.first, t.name
        chmod 0755, t.name
      end

      desc "Install the git post-commit hook"
      file "#{git_dir}/hooks/post-commit" => "#{template_path}/post-commit" do |t|
        copy t.prerequisites.first, t.name
        chmod 0755, t.name
      end

      namespace :git do
        desc "Install the git pre-commit hook"
        task :precommit => pre_commit

        desc "Install the git post-commit hook"
        task :postcommit => "#{git_dir}/hooks/post-commit"
      end
    end
    def git_dir()
      `git rev-parse --git-dir`.strip
    end
  end
end
