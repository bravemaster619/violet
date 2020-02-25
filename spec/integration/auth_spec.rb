require 'swagger_helper'

describe 'Authentication API' do

  path '/api/v1/login' do
    post 'Login' do
      tags 'Auth'
      consumes 'application/json'
      parameter name: :credential, in: :body, schema: {
          type: :object,
          properties: {
              email: {type: :string},
              password: {type: :string}
          },
          required: ['email', 'password']
      }

      response 200, 'Login success' do
        schema type: :object,
               properties: {
                   success: {type: :boolean},
                   message: {type: :string},
                   data: {
                       type: :object,
                       properties: {
                           user: {
                               '#ref' => '#/definitions/filtered_user'
                           },
                           jwt: {type: :string}
                       }
                   }
               },
               required: ['success']

        let(:credential) { {email: 'admin@dev.com', password: 'admin123'} }
        run_test!
      end

      response 403, 'Login fail' do
        let(:credential) { {email: 'admin@dev.com', password: 'violet123'} }
        run_test!
      end
    end
  end

  path '/api/v1/register' do
    post 'Register' do
      tags 'Auth'
      consumes 'application/json'
      parameter name: :user_info, in: :body, schema: {
          type: :object,
          properties: {
              name: {type: :string},
              email: {type: :string},
              password: {type: :string},
              birthday: {type: :string, format: 'date-time'},
          },
          required: ['name', 'email', 'password']
      }

      response 200, 'Register success' do
        schema type: :object,
               properties: {
                   success: {type: :boolean},
                   message: {type: :string},
                   data: {'$ref' => '#/definitions/filtered_user'}
               },
               required: ['success']
        let(:user_info) { {
            name: 'Brave Master',
            email: 'bravemaster@dev.com',
            password: '123123',
            birthday: '1993-06-19'
        } }
        run_test!
      end

      response 422, 'Validation failed' do
        schema type: :object,
               properties: {
                   success: {type: :boolean},
                   message: {type: :string},
                   data: {type: :object}
               },
               required: ['success']
        let(:user_info) { {
            name: 'Brave Master',
            password: '123123',
            birthday: '1993-06-19'
        } }
        run_test!
      end
    end
  end


end
