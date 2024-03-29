class ProductsController < ApplicationController
  before_action :authenticate_user!, except: %i[ index show ]
  before_action :set_product, only: %i[ show update destroy ]

  # GET /products
  # GET /products.json
  def index
    @products = Product.page(params[:page].presence || 1).per(params[:per_page].presence || 10)
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    begin @product.save
      render :show, status: :created, location: @product
    rescue => errors
      render json: errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    if @product.update(product_params)
      render :show, status: :ok, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:external_name, :description, :manufacturer, :active)
    end
end
