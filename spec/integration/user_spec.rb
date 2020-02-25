require 'swagger_helper'

describe 'Users API' do

  path '/api/v1/users' do
    get 'Get all users' do
      tags 'User'
      security [ basic: [] ]

      response 200, 'Get user list' do
        schema type: :object,
               properties: {
                   success: {type: :boolean},
                   message: {type: :string},
                   data: {
                       type: :array,
                       items:  { '$ref' => '#/definitions/user' }
                   }
               },
               required: ['success']
        let(:Authorization) { "Bearer #{::Base64.strict_encode64('jsmith:jspass')}" }
        run_test!
      end

      response 403, 'Authorization failed' do
        schema type: :object,
               properties: {
                   success: {type: :boolean},
                   message: {type: :string},
               },
               required: ['success']
      end

    end
  end

  path 'api/v1/users/{id}' do
    get 'Get a user info' do
      tags 'User'
      parameter name: :id, in: :path, type: :string
      security [ basic: [] ]

      response 200, 'Get a user info' do
        schema type: :object,
               properties: {
                   success: {type: :boolean},
                   message: {type: :string},
                   data: {
                       '$ref' => '#/definitions/user'
                   }
               }
        let(:Authorization) { "Bearer #{::Base64.strict_encode64('jsmith:jspass')}" }
        let(:id) { '1' }
        run_test!
      end

      response 403, 'Authorization failed' do
        schema type: :object,
               properties: {
                   success: {type: :boolean},
                   message: {type: :string},
               },
               required: ['success']
      end

    end
  end

  path 'api/v1/users/{id}' do
    post 'Create a new user' do
      tags 'User'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :user_info, in: :body, schema: {
          type: :object,
          properties: {
              name: {type: :string},
              email: {type: :string},
              password: {type: :string},
              birthday: {type: :string, format: 'date-time'},
              verified: {type: :boolean},
              allowed: {type: :boolean},
              role: {type: :string}
          },
          required: ['name', 'email', 'password', 'role']
      }
      security [ basic: [] ]

      response 200, 'User created' do
        schema type: :object,
               properties: {
                   success: {type: :boolean},
                   message: {type: :string},
                   data: {
                       '$ref' => '#/definitions/user'
                   }
               }
        let(:Authorization) { "Bearer #{::Base64.strict_encode64('jsmith:jspass')}" }
        let(:id) { '1' }
        let(:user_info) {{
            name: 'Brave Master',
            email: 'email@email.com',
            password: '123123',
            birthday: '1993-06-19',
            verified: true,
            allowed: true,
            role: 'user'
        }}
        run_test!
      end

      response 403, 'Authorization failed' do
        schema type: :object,
               properties: {
                   success: {type: :boolean},
                   message: {type: :string},
               },
               required: ['success']
      end

      response 422, 'Validation failed' do
        schema type: :object,
               properties: {
                   success: {type: :boolean},
                   message: {type: :string},
                   data: {type: :object}
               },
               required: ['success']
        let(:id) { 1 }
        let(:user_info) { {
            name: 'Brave Master',
            password: '123123',
            birthday: '1993-06-19'
        } }
        run_test!
      end

    end
  end

  path 'api/v1/users/{id}' do
    put 'Update a user' do
      tags 'User'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :user_info, in: :body, schema: {
          type: :object,
          properties: {
              name: {type: :string},
              email: {type: :string},
              password: {type: :string},
              birthday: {type: :string, format: 'date-time'},
              verified: {type: :boolean},
              allowed: {type: :boolean},
              role: {type: :string}
          },
          required: ['name', 'email', 'password', 'role']
      }
      security [ basic: [] ]

      response 200, 'User updated' do
        schema type: :object,
               properties: {
                   success: {type: :boolean},
                   message: {type: :string},
                   data: {
                       '$ref' => '#/definitions/user'
                   }
               }
        let(:Authorization) { "Bearer #{::Base64.strict_encode64('jsmith:jspass')}" }
        let(:id) { '1' }
        let(:user_info) {{
            name: 'Brave Master',
            email: 'email@email.com',
            password: '123123',
            birthday: '1993-06-19',
            verified: true,
            allowed: true,
            role: 'user'
        }}
        run_test!
      end

      response 403, 'Authorization failed' do
        schema type: :object,
               properties: {
                   success: {type: :boolean},
                   message: {type: :string},
               },
               required: ['success']
      end

      response 422, 'Validation failed' do
        schema type: :object,
               properties: {
                   success: {type: :boolean},
                   message: {type: :string},
                   data: {type: :object}
               },
               required: ['success']
        let(:id) { 1 }
        let(:user_info) { {
            name: 'Brave Master',
            password: '123123',
            birthday: '1993-06-19'
        } }
        run_test!
      end

    end
  end

  path 'api/v1/users/{id}' do
    delete 'Delete a user' do
      tags 'User'
      parameter name: :id, in: :path, type: :string

      security [ basic: [] ]

      response 200, 'User deleted' do
        schema type: :object,
               properties: {
                   success: {type: :boolean},
                   message: {type: :string},
               }
        let(:Authorization) { "Bearer #{::Base64.strict_encode64('jsmith:jspass')}" }
        let(:id) { '1' }
        run_test!
      end

      response 403, 'Authorization failed' do
        schema type: :object,
               properties: {
                   success: {type: :boolean},
                   message: {type: :string},
               },
               required: ['success']
      end

    end
  end

  path 'api/v1/users/delete/{id}' do
    delete 'Soft delete a user' do
      tags 'User'
      parameter name: :id, in: :path, type: :string

      security [ basic: [] ]

      response 200, 'User deleted' do
        schema type: :object,
               properties: {
                   success: {type: :boolean},
                   message: {type: :string},
               }
        let(:Authorization) { "Bearer #{::Base64.strict_encode64('jsmith:jspass')}" }
        let(:id) { '1' }
        run_test!
      end

      response 403, 'Authorization failed' do
        schema type: :object,
               properties: {
                   success: {type: :boolean},
                   message: {type: :string},
               },
               required: ['success']
      end

    end
  end

end