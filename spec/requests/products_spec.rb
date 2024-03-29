require 'swagger_helper'

describe 'products' do

  path '/products' do
    post 'Creates a product' do
      tags 'Products'
      description 'Available only for admin users'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :product, in: :body, schema: {
        type: :object,
        properties: {
          product: { type: :object, properties: {
            external_name: { type: :string },
            description: { type: :string },
            manufacturer: { type: :string },
            active: { type: :boolean }
          }, required: [ 'external_name', 'description', 'manufacturer', 'active' ] }
        }
      }
      parameter name: :Authorization, in: :header, schema: {
        type: :string
      }, required: [ 'Authorization' ]

      response '201', 'product created' do
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
        let(:user) { User.create(email: 'test@gmail.com', password: '123123', is_admin: true) }
        let(:Authorization) { "Bearer #{user.generate_jwt}" }

        let(:product) { { external_name: "Test Name", description: "Product Description", manufacturer: "Test Manufacturer", active: true } }

        run_test! focus: true
      end

      response '422', 'invalid request' do
        let(:user) { User.create(email: 'test@gmail.com', password: '123123', is_admin: true) }
        let(:Authorization) { "Bearer #{user.generate_jwt}" }

        let(:product) { { external_name: "foo" } }

        run_test!
      end

      response '401', 'unauthorized' do
        let(:user) { User.create(email: 'test@gmail.com', password: '123123', is_admin: false) }
        let(:Authorization) { "Bearer #{user.generate_jwt}" }

        let(:product) { { external_name: "Test Name", description: "Product Description", manufacturer: "Test Manufacturer", active: true } }

        run_test!
      end
    end

    get 'Retrieves all products paginated' do
      tags 'Products'
      produces 'application/json'

      response '200', 'products found' do
        schema type: :object,
          properties: {
            products: { 
              type: :array, 
              items: {
                type: :object,
                properties: {
                  id: { type: :integer },
                  external_name: { type: :string },
                  description: { type: :string },
                  manufacturer: { type: :string },
                  active: { type: :boolean },
                  created_at: { type: :string, format: :datetime },
                  updated_at: { type: :string, format: :datetime },
                  skus: { type: :array, items: { type: :object } },
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

  path '/products/{id}' do

    get 'Retrieves one product' do
      tags 'Products'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer

      response '200', 'Retrieves a product' do
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
        

        let(:id) { Product.create(external_name: "Name Test", description: "Description Test", manufacturer: 'Manufacturer Test', active: true).id }
        run_test!
      end

      response '404', 'product not found' do

        let(:id) { 'invalid' }
        run_test!
      end
    end

    put 'Updates a product' do
      tags 'Products'
      description 'Available only for admin users'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer
      parameter name: :product, in: :body, schema: {
        type: :object,
        properties: {
          product: { type: :object, properties: {
            external_name: { type: :string },
            description: { type: :string },
            manufacturer: { type: :string },
            active: { type: :boolean }
          }, required: [ 'external_name', 'description', 'manufacturer', 'active' ] }
        }
      }
      parameter name: :Authorization, in: :header, schema: {
        type: :string
      }, required: [ 'Authorization' ]

      response '200', 'Updates a product' do
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
        
        let(:user) { User.create(email: 'test@gmail.com', password: '123123', is_admin: true) }
        let(:Authorization) { "Bearer #{user.generate_jwt}" }

        let(:id) { Product.create(external_name: "Name Test", description: "Description Test", manufacturer: 'Manufacturer Test', active: true).id }
        let(:product) { { external_name: "Test Name", description: "Product Description", manufacturer: "Test Manufacturer", active: false } }

        run_test!
      end

      response '404', 'Product not found' do
        let(:user) { User.create(email: 'test@gmail.com', password: '123123', is_admin: true) }
        let(:Authorization) { "Bearer #{user.generate_jwt}" }

        let(:id) { 1 }
        let(:product) { { external_name: "Test Name", description: "Product Description", manufacturer: "Test Manufacturer", active: false } }

        run_test!
      end

      response '401', 'unauthorized' do
        let(:user) { User.create(email: 'test@gmail.com', password: '123123', is_admin: false) }
        let(:Authorization) { "Bearer #{user.generate_jwt}" }

        let(:id) { Product.create(external_name: "Name Test", description: "Description Test", manufacturer: 'Manufacturer Test', active: true).id }
        let(:product) { { external_name: "Test Name", description: "Product Description", manufacturer: "Test Manufacturer", active: false } }

        run_test!
      end
    end

    delete 'Delete a product' do
      tags 'Products'
      description 'Available only for admin users'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer
      parameter name: :Authorization, in: :header, schema: {
        type: :string
      }, required: [ 'Authorization' ]

      response '204', 'Delete a product' do
        let(:user) { User.create(email: 'test@gmail.com', password: '123123', is_admin: true) }
        let(:Authorization) { "Bearer #{user.generate_jwt}" }

        let(:id) { Product.create(external_name: "Name Test", description: "Description Test", manufacturer: 'Manufacturer Test', active: true).id }
        run_test!
      end

      response '404', 'product not found' do
        let(:user) { User.create(email: 'test@gmail.com', password: '123123', is_admin: true) }
        let(:Authorization) { "Bearer #{user.generate_jwt}" }

        let(:id) { 'invalid' }
        run_test!
      end

      response '401', 'unauthorized' do
        let(:user) { User.create(email: 'test@gmail.com', password: '123123', is_admin: false) }
        let(:Authorization) { "Bearer #{user.generate_jwt}" }

        let(:id) { Product.create(external_name: "Name Test", description: "Description Test", manufacturer: 'Manufacturer Test', active: true).id }

        run_test!
      end
    end
  end
end
