require 'spaceship'

class SpaceShip
  def initialize(username:, password:)
    @username = username
    @password = password
  end

  def login
    Spaceship::Tunes.login(@username, @password)
  end

  def app(app_name)
    Spaceship::Tunes::Application.find(app_name)
  end

  def in_app_purchases(app)
    app.in_app_purchases.all
  end
end
