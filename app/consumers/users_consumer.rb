class UsersConsumer < ApplicationConsumer
  def consume
    Karafka.logger.info "New [User] event: #{params}"
  end
end
