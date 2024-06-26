json.extract! sku, :id, :code, :name, :stock_qty, :table_price_in_cents, :listing_price_in_cents, :product_id, :created_at, :updated_at
json.url sku_url(sku, format: :json)
json.image_url sku.image.attached? ? Rails.application.routes.url_helpers.rails_blob_path(sku.image) : nil
