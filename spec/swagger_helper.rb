require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v1/swagger.json' => {
      openapi: '3.0.1',
      info: {
        title: 'Violet API V1',
        version: 'v1'
      },
      basePath: '/api/v1',
      securityDefinitions: {
          basic: {
              type: :basic
          },
      },
      definitions: {
          object_id: {
              type: :object,
              properties: {
                  "$oid": {type: :string}
              }
          },
          filtered_user: {
              type: :object,
              properties: {
                  _id: { '$ref': '#/definitions/object_id' },
                  name: {type: :string},
                  email: {type: :string},
                  birthday: {type: :string, format: :date},
                  verified: {type: :boolean},
                  created_at: {type: :string, format: "date-time"},
                  updated_at: {type: :string, format: "date-time"},
                  deleted_at: {type: :string, format: "date-time"}
              },
              required: ['name', 'email', 'created_at', 'updated_at']
          },
          user: {
              all_of: { '$ref': '#definitions/filtered_user'},
              type: :object,
              properties: {
                  password_digest: { type: :string },
                  email_code: { type: :string },
                  allowed: { type: :boolean }
              }
          }
      }
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :json
end
