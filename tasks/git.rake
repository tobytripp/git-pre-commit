TEMPLATE_PATH= File.join File.dirname(__FILE__), '..'

if RAILS_ENV == 'development' || RAILS_ENV == 'test'
  file ".git/hooks/pre-commit" => "#{TEMPLATE_PATH}/git-hooks/pre-commit" do |t|
    warn "Git pre-commit hook missing, setting up…"
    copy  t.prerequisites.first, t.name
    chmod 0755, t.name
  end

  task :environment => ".git/hooks/pre-commit"
end
