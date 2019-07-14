require 'spaceship'

class SpaceShip
  def login(username, password)
    Spaceship::Tunes.login(username, password)
  end

  def app(name)
    Spaceship::Tunes::Application.find(name)
  end
end
