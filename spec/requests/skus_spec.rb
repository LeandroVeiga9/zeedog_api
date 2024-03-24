require 'swagger_helper'

describe 'skus' do

  path '/skus' do
    post 'Creates a sku' do
      tags 'SKUs'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :sku, in: :body, schema: {
        type: :object,
        properties: {
          sku: { type: :object, properties: {
            code: { type: :string },
            names: { type: :string },
            stock_qty: { type: :integer },
            table_price_in_cents: { type: :integer },
            listing_price_in_cents: { type: :integer },
            product_id: { type: :integer }
          }, required: [ 'code', 'name', 'stock_qty', 'table_price_in_cents', 'listing_price_in_cents', 'product_id' ] }
        }
      }

      response '201', 'sku created' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            external_name: { type: :string },
            description: { type: :string },
            manufacturer: { type: :string },
            active: { type: :boolean },
            created_at: { type: :string, format: :datetime },
            updated_at: { type: :string, format: :datetime },
            skus: { type: :array, items: { type: :object } },
          }

        let(:product_id) { Product.create(external_name: "Name Test", description: "Description Test", manufacturer: 'Manufacturer Test', active: true).id }
        let(:sku) { { code: "1234567890123", name: "Sku Test", stock_qty: 100, table_price_in_cents: 1000, listing_price_in_cents: 2000, product_id: product_id } }

        run_test! focus: true
      end

      response '422', 'invalid request' do
        
        let(:sku) { { code: "foo" } }

        run_test!
      end
    end

    get 'Retrieves all skus paginated' do
      tags 'SKUs'
      produces 'application/json'

      response '200', 'skus found' do
        schema type: :object,
          properties: {
            skus: { 
              type: :array, 
              items: {
                type: :object,
                properties: {
                  id: { type: :integer },
                  code: { type: :string },
                  name: { type: :string },
                  stock_qty: { type: :string },
                  table_price_in_cents: { type: :integer },
                  listing_price_in_cents: { type: :integer },
                  product_id: { type: :integer },
                  created_at: { type: :string, format: :datetime },
                  updated_at: { type: :string, format: :datetime },
                },
              } 
            },
            pagination: { 
              type: :object, 
              properties: { 
                total_pages: { type: :integer, nullable: true },
                current_page: { type: :integer, nullable: true },
                next_page: { type: :integer, nullable: true },
                prev_page: { type: :integer, nullable: true }
              }
            }
          }

        run_test!
      end
    end

  end

  path '/skus/{id}' do

    get 'Retrieves one sku' do
      tags 'SKUs'
      security [ bearer_auth: [] ]
      produces 'application/json'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer

      response '200', 'Retrieves a sku' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            code: { type: :string },
            name: { type: :string },
            stock_qty: { type: :integer },
            table_price_in_cents: { type: :integer },
            listing_price_in_cents: { type: :integer },
            product_id: { type: :integer },
            created_at: { type: :string, format: :datetime },
            updated_at: { type: :string, format: :datetime },
          }
        
        let(:product_id) { Product.create(external_name: "Name Test", description: "Description Test", manufacturer: 'Manufacturer Test', active: true).id }
        let(:id) { Sku.create(code: "1234567890123", name: "Sku Test", stock_qty: 100, table_price_in_cents: 1000, listing_price_in_cents: 2000, product_id: product_id).id }
        run_test!
      end

      response '404', 'sku not found' do

        let(:id) { 'invalid' }
        run_test!
      end
    end

    put 'Updates a sku' do
      tags 'SKUs'
      security [ bearer_auth: [] ]
      produces 'application/json'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer
      parameter name: :sku, in: :body, schema: {
        type: :object,
        properties: {
          sku: { type: :object, properties: {
            code: { type: :string },
            names: { type: :string },
            stock_qty: { type: :integer },
            table_price_in_cents: { type: :integer },
            listing_price_in_cents: { type: :integer },
            product_id: { type: :integer }
          }, required: [ 'code', 'name', 'stock_qty', 'table_price_in_cents', 'listing_price_in_cents', 'product_id' ] }
        }
      }

      response '200', 'Updates a sku' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            code: { type: :string },
            name: { type: :string },
            stock_qty: { type: :integer },
            table_price_in_cents: { type: :integer },
            listing_price_in_cents: { type: :integer },
            product_id: { type: :integer },
            created_at: { type: :string, format: :datetime },
            updated_at: { type: :string, format: :datetime },
          }

        let(:product_id) { Product.create(external_name: "Name Test", description: "Description Test", manufacturer: 'Manufacturer Test', active: true).id }
        let(:id) { Sku.create(code: "1234567890123", name: "Sku Test", stock_qty: 100, table_price_in_cents: 1000, listing_price_in_cents: 2000, product_id: product_id).id }
        let(:sku) { { code: "1234567890124", name: "Sku Test 2", stock_qty: 10, table_price_in_cents: 2000, listing_price_in_cents: 3000, product_id: product_id } }

        run_test!
      end

      response '404', 'Product not found' do
        let(:id) { 1 }
        let(:sku) { { code: "1234567890123", name: "Sku Test", stock_qty: 100, table_price_in_cents: 1000, listing_price_in_cents: 2000, product_id: 1 } }

        run_test!
      end
    end

    delete 'Delete a sku' do
      tags 'SKUs'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer

      response '204', 'Delete a sku' do

        let(:product_id) { Product.create(external_name: "Name Test", description: "Description Test", manufacturer: 'Manufacturer Test', active: true).id }
        let(:id) { Sku.create(code: "1234567890123", name: "Sku Test", stock_qty: 100, table_price_in_cents: 1000, listing_price_in_cents: 2000, product_id: product_id).id }
        run_test!
      end

      response '404', 'sku not found' do

        let(:id) { 'invalid' }
        run_test!
      end
    end

  end
end
