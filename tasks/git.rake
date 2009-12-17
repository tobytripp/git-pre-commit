TEMPLATE_PATH= File.join File.dirname(__FILE__), '..'

unless RAILS_ENV == 'production'
  file ".git/hooks/pre-commit" => "#{TEMPLATE_PATH}/git-hooks/pre-commit" do |t|
    warn "Git pre-commit hook missing, setting up…"
    copy  t.prerequisites.first, t.name
    chmod 0755, t.name
  end

  task :environment => ".git/hooks/pre-commit"
end
