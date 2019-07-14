class PurchasesController < ApplicationController
  before_action :login, only: [:index, :create]

  def index
    @app_name = app.name
    @app_icon = app.app_icon_preview_url
    @existing_in_app_purchases = in_app_purchases
  end

  def create
    create_in_app_purchase
    redirect_to '/'
    rescue Exception => e
      puts "exception is #{e.message}" # [Improvement based on tech stack] logger here
      redirect_to new_purchase_path(errors: e.message)
  end

  def new
    @error = params[:errors]
  end

  def show
    @single_in_app_purchase = in_app_purchases.select do |iap|
      iap.product_id == params[:id]
    end.first
  end

  private

  def in_app_purchases
    @in_app_purchases ||= space_ship_service.in_app_purchases(app)
  end

  def login
    space_ship_service.login
  end

  def app
    @app ||= space_ship_service.app(ENV['APP_NAME'])
  end

  def space_ship_service
    @space_ship_service ||= SpaceShip.new(
      username: ENV['USERNAME'],
      password: ENV['PASSWORD']
    )
  end

  def create_in_app_purchase
    app.in_app_purchases.create!(
      type: Spaceship::Tunes::IAPType::CONSUMABLE, versions: versions,
      reference_name: in_app_purchase.dig('reference_name'),
      product_id: in_app_purchase.dig('product_id'),
      cleared_for_sale: cleared_for_sale
    )
  end

  def versions
    versions_object = {}
    dynamic_language_fields = in_app_purchase['counter'].to_i
    (1..dynamic_language_fields).map do |counter|
      versions_object[in_app_purchase.dig("language+#{counter}")] = {
        'name': in_app_purchase.dig("name+#{counter}"),
        'description': in_app_purchase.dig("description+#{counter}")
      }
    end
    versions_object
  end

  def cleared_for_sale
    in_app_purchase.dig('cleared_for_sale') == 1
  end

  def in_app_purchase
    @in_app_purchase ||= params['in_app_purchase']
  end

  def current_user
    User.current_user
  end
end
