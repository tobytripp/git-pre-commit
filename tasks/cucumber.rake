task :default => [:cucumber]

begin
  require 'cucumber/rake/task'

  namespace :cucumber do
    Cucumber::Rake::Task.new( :ok,
      'Run features that should pass') do |t|
      t.fork = true # You may get faster startup if you set this to false
      t.profile = 'default'
    end

    Cucumber::Rake::Task.new(:wip,
      'Run features that are being worked on') do |t|
      t.fork = true # You may get faster startup if you set this to false
      t.profile = 'wip'
    end

    Cucumber::Rake::Task.new( :cruise, 
      "Run features and generate HTML report" ) do |t|
      t.fork = true
      t.profile = 'cruise'
    end

    desc 'Run all features'
    task :all => [:ok, :wip]

    desc 'list uncommented feature and scenario names'
    task :list, [:file_pattern] do |t, args|
      scenario_count = 0
      Dir["#{RUBY_ROOT}/features/**/#{args.file_pattern || '*'}.feature"].sort.each do |file|
        puts file
        File.read(file).split(/\n/).each do |line|
          puts $1                                       if line =~ /^\s*(Feature:.+)/
          printf("\t%3d:%s\n", scenario_count += 1, $1) if line =~ /^\s*Scenario:(.+)/
        end
        puts
      end
    end
  end

  desc 'Alias for cucumber:ok'
  task :cucumber => 'cucumber:ok'

  task :features => :cucumber do
    STDERR.puts "*** The 'features' task is deprecated. See rake -T cucumber ***"
  end
rescue LoadError
  desc 'cucumber rake task not available (cucumber not installed)'
  task :cucumber do
    abort 'Cucumber rake task is not available. Be sure to install cucumber as a gem or plugin'
  end
end
