class UsersResponder < ApplicationResponder
  topic :users

  def respond(event_payload)
    respond_to :users, event_payload
  end
end
