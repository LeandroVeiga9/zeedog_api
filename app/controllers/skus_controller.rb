class SkusController < ApplicationController
  before_action :set_sku, only: %i[ show update destroy ]

  # GET /skus
  # GET /skus.json
  def index
    if params[:product_id]
      @skus = Sku.where(product_id: params[:product_id]).page(params[:page].presence || 1).per(params[:per_page].presence || 10)
    else
      @skus = Sku.page(params[:page].presence || 1).per(params[:per_page].presence || 10)
    end
    return @skus
  end

  # GET /skus/1
  # GET /skus/1.json
  def show
  end

  # POST /skus
  # POST /skus.json
  def create
    @sku = Sku.new(sku_params)

    if @sku.save
      render :show, status: :created, location: @sku
    else
      render json: @sku.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /skus/1
  # PATCH/PUT /skus/1.json
  def update
    if @sku.update(sku_params)
      render :show, status: :ok, location: @sku
    else
      render json: @sku.errors, status: :unprocessable_entity
    end
  end

  # DELETE /skus/1
  # DELETE /skus/1.json
  def destroy
    @sku.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sku
      @sku = Sku.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sku_params
      params.require(:sku).permit(:code, :name, :stock_qty, :table_price_in_cents, :listing_price_in_cents, :product_id, :image)
    end
end
