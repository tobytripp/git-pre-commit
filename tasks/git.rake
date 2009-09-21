TEMPLATE_PATH= File.join File.dirname(__FILE__), '..'

file ".git/hooks/pre-commit" => "#{TEMPLATE_PATH}/git-hooks/pre-commit" do |t|
  warn "Git pre-commit hook missing, setting up…"
  copy  t.prerequisites.first, t.name
  chmod 0755, t.name
  abort "pre-commit hook in place, retry last command."
end

task :environment => ".git/hooks/pre-commit"
