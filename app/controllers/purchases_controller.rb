require "spaceship"

class PurchasesController < ApplicationController
  before_action :login, only: [:index, :create]

  def index
    @app_name = app.name
    @app_icon = app.app_icon_preview_url
    @existing_in_app_purchases = app.in_app_purchases.all
  end

  def create
    login

    app.in_app_purchases.create!(
      type: Spaceship::Tunes::IAPType::CONSUMABLE, versions: versions,
      reference_name: in_app_purchase.dig('reference_name'),
      product_id: in_app_purchase.dig('product_id'),
      cleared_for_sale: cleared_for_sale
    )
    redirect_to '/'
    rescue Exception => e
      puts "exception is #{e.message}" # [Improvement based on tech stack] logger here
      redirect_to new_purchase_path(errors: e.message)
  end

  def new
    @error = params[:errors]
  end

  def show
  end

  private

  def login
    Spaceship::Tunes.login(ENV['USERNAME'], ENV['PASSWORD'])
  end

  def app
    @app ||= Spaceship::Tunes::Application.find(ENV['APP_NAME'])
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
