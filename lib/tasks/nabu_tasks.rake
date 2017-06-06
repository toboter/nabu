namespace :nabu do

  desc "Copy initializers and migrations from has_issues to application"
  task :install do
    Rake::Task["nabu:install:migrations"].invoke
  end

end