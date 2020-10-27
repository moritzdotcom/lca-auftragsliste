namespace :db do
  desc 'Drop, create, migrate then seed the development database'

  task restart: [ 'db:drop', 'db:create', 'db:migrate', 'db:seed' ] do
    puts 'Restart completed.'
  end
end
