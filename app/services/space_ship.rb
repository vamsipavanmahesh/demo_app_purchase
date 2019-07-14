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

  def pricing_tiers
    count = Spaceship::AppVersion.client.pricing_tiers.count
    aggregator = []
    # for some reason is not an enumerator
    (0..count-1).each do |count|
      individual_tier = []
      individual_tier << Spaceship::AppVersion.client.pricing_tiers[count].tier_name
      individual_tier << Spaceship::AppVersion.client.pricing_tiers[count].tier_stem
      aggregator << individual_tier
    end
    aggregator
  end
end
