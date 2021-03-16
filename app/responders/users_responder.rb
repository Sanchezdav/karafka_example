class UsersResponder < ApplicationResponder
  topic :users

  def respond(event_payload)
    respond_to :users, event_payload
  end

  # Example sending and event into the Rails console
  ##
  # Sending 500 events at once
  #
  # 500.times do |num|
  #   UsersResponder.call({ event_name: "user_created", user: { user_id: num, email: "spiderman-#{num}@mail.com", first_name: 'Bruce', last_name: 'Wayne', phone: '1234567890' } } )
  # end
  #
  # Sending one event
  #
  # UsersResponder.call({ event_name: "user_created", user: { user_id: 1, email: nil, first_name: 'Bruce', last_name: 'Wayne', phone: '1234567890' } } )
end
