require "rake"
require "rake/tasklib"

module GitPrecommit
  class PrecommitTasks < ::Rake::TaskLib
    TEMPLATE_PATH= File.join File.dirname(__FILE__), '..'

    def initialize()
      yield self if block_given?
      define
    end
    
    def define()
      desc "Install the pre-commit hook"
      file ".git/hooks/pre-commit" => "#{TEMPLATE_PATH}/git-hooks/pre-commit" do |t|
        warn "Git pre-commit hook missing, setting up…"
        copy  t.prerequisites.first, t.name
        chmod 0755, t.name
      end

      desc "Install the post-commit hook"
      file ".git/hooks/post-commit" => "#{TEMPLATE_PATH}/git-hooks/post-commit" do |t|
        copy t.prerequisites.first, t.name
        chmod 0755, t.name
      end
    end
  end
end
