user    = User.find_by_email('anotheroneman@yahoo.com')
user  ||= User.create(:email => 'anotheroneman@yahoo.com', :password => '123456')
event   = Event.find_by_name('First event')
event ||= Event.create(:user_id     => user.id, 
                       :name        => 'First event', 
                       :description => 'One of the most interesting evets',
                       :event_date  => '11/12/2015 12:23'
                      ) 
point   = Point.find_by_address('New York')
point ||= Point.create(:address => 'New York', :user_id => user.id)
unbound_point   = Point.find_by_address('Paris')
unbound_point ||= Point.create(:address => 'Paris', :user_id => user.id)
unless EventPoint.where(:point_id => point.id, :event_id => event.id).first
  EventPoint.create(:point_id => point.id, :event_id => event.id)
end
user.confirm!

