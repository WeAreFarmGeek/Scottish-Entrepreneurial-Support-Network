namespace :setup do

  task :seed_db do
    puts " => Installling default user account"
    User.create(:username => "aep2884", :password => "nindosha", :password_confirmation => "nindosha")
    puts " => Creating Graph Type options"
    Graph.types.each do |t|
      Graph.create(:setting => t)
    end
  end

end
