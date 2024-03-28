require 'swagger_helper'

describe 'user auth' do

  path '/users' do
    post 'Register an user' do
      tags 'User Auth'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :body, in: :body, schema: {
        type: :object,
        properties: {
          user: { type: :object, properties: {
            email: { type: :string },
            password: { type: :string },
            is_admin: { type: :boolean },
          }, required: [ 'email', 'password' ] }
        }
      }

      response '200', 'user created' do
        schema type: :object,
        properties: {
          user: { type: :object, properties: {
            email: { type: :string },
            password: { type: :string },
            is_admin: { type: :boolean },
            token: { type: :string }
          }}
        }

        let(:body) { { user: { email: "test@email.com", password: "123123", is_admin: false } } }

        run_test! focus: true
      end

      response '422', 'email already exists' do
        before do
          User.create(email: "test@email.com", password: "123123", is_admin: true)
        end

        let(:body) { { user: { email: "test@email.com", password: "123123", is_admin: false } } }

        run_test! focus: true
      end
    end
  end

  path '/users/login' do
    post 'User login' do
      tags 'User Auth'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :body, in: :body, schema: {
        type: :object,
        properties: {
          user: { type: :object, properties: {
            email: { type: :string },
            password: { type: :string },
          }, required: [ 'email', 'password' ] }
        }
      }

      response '200', 'user logged' do
        schema type: :object,
        properties: {
          user: { type: :object, properties: {
            email: { type: :string },
            password: { type: :string },
            is_admin: { type: :boolean },
            token: { type: :string }
          }}
        }

        before do
          User.create(email: "test@email.com", password: "123123", is_admin: true)
        end

        let(:body) { { user: { email: "test@email.com", password: "123123" } } }

        run_test! focus: true
      end

      response '422', 'email or password invalid' do
        before do
          User.create(email: "test@email.com", password: "123123", is_admin: true)
        end

        let(:body) { { user: { email: "test1@email.com", password: "1231231", is_admin: false } } }

        run_test! focus: true
      end
    end
  end
end