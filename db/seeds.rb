user = User.create(:email => 'anotheroneman@yahoo.com', :password => '123456')
user.confirm!

