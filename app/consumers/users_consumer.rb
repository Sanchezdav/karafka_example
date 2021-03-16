class UsersConsumer < ApplicationConsumer
  include Karafka::Consumers::Callbacks

  DESTROYED_OPTION = 'd'

  before_poll do
    Karafka.logger.info "--------- Lets check if there is anything new for #{topic.name}"
  end

  after_poll do
    Karafka.logger.info '--------- Yay! We just checked for new messages!'
  end

  def consume
    Karafka.logger.info "New [User] event: #{params.payload}"
    user_params = params.payload['user']
    user = User.find_by(email: user_params['email'])

    return ingest_user(user, user_params) unless user_params['__opt'] == DESTROYED_OPTION

    destroy_user(user)
  end

  private

  def ingest_user(user, user_params)
    return update_user(user, parsed_params(user_params)) if user

    create_user(parsed_params(user_params))
  end

  def create_user(user_params)
    user = User.new(user_params)
    if user.save
      Karafka.logger.info "------ User with user_id #{user.user_id} was created successfully!"
    else
      Karafka.logger.info "------ User with user_id #{user.user_id} was not created: #{user.errors.full_messages}"
    end
  rescue StandardError => ex
    Karafka.logger.info "------ Exception raised #{ex}"
  end

  def update_user(user, user_params)
    if user.update(user_params)
      Karafka.logger.info "------ User with user_id #{user.user_id} was updated successfully!"
    else
      Karafka.logger.info "------ User with user_id #{user.user_id} was not updated: #{user.errors.full_messages}"
    end
  rescue StandardError => ex
    Karafka.logger.info "------ Exception raised #{ex}"
  end

  def destroy_user(user)
    user.discard
    Karafka.logger.info "------ User destroyed successfully!"
  rescue StandardError => ex
    Karafka.logger.info "------ Exception raised #{ex}"
  end

  def parsed_params(user_params)
    {
      user_id: user_params['user_id'],
      email: user_params['email'],
      first_name: user_params['first_name'],
      last_name: user_params['last_name'],
      phone: user_params['phone']
    }
  end
end
