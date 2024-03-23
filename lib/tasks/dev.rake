namespace :dev do
  desc 'Development setup'
  task :setup do
    def spin(init_message, command, finish_message = "Done!")
      spinner = TTY::Spinner.new("[:spinner] #{init_message}", format: :classic)
      %x(#{command})
      spinner.stop(finish_message)

    end
    spin("Dropping database...", "rails db:drop")
    spin("Creating database...", "rails db:create")
    spin("Migrating database...", "rails db:migrate")
  end
end