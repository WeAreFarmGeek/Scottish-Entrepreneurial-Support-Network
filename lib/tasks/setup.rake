namespace :setup do

  desc "Install defaults"
  task :seed_db => :environment do
    puts " => Installling default user account"
    User.create(:email => "john@johnhamelink.com", :password => "nopass", :password_confirmation => "nopass")
    puts " => Creating Graph Type options"
    Graph.types.each do |t|
      Graph.create(:setting => t)
    end
  end

end
