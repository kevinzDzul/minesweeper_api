include Swagger::Blocks
class ApiDocController < ApplicationController
    swagger_root do
        key :swagger, '2.0'
        info do
          key :version, '1.0.0'
          key :title, 'Game API'
          key :description, 'A sample Game API'
          contact do
            key :name, 'https://github.com/'
          end
        end
        key :host, ENV['HOST']
        key :basePath, '/'
        key :consumes, ['application/json']
        key :produces, ['application/json']
      end
    
      # A list of all classes that have swagger_* declarations.
      SWAGGERED_CLASSES = [
        GamesController,
        self,
      ].freeze
    
      def index
        render json: Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
      end
end
