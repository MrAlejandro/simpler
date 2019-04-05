require_relative 'view'

module Simpler
  class Controller

    attr_reader :name, :request, :response

    def initialize(env, params)
      @name = extract_name
      @response = Rack::Response.new

      @request = Rack::Request.new(env)
      @request.params.merge!(params)
    end

    def make_response(action)
      @request.env['simpler.controller'] = self
      @request.env['simpler.action'] = action

      set_default_headers
      send(action)
      write_response if @response.successful?

      @response.finish
    end

    def not_found
      status 404
    end

    private

    def extract_name
      self.class.name.match('(?<name>.+)Controller')[:name].downcase
    end

    def set_default_headers
      @response['Content-Type'] = 'text/html'
    end

    def write_response
      body = render_body

      @response.write(body)
    end

    def render_body
      render_type = @request.env['simpler.render_type']

      case render_type
      when :plain
        @request.env['simpler.render_resource']
      else
        View.new(@request.env).render(binding)
      end
    end

    def render(resource)
      if resource.is_a?(Hash)
        render_type, render_resource = resource.first
        @request.env['simpler.render_type'] = render_type
        @request.env['simpler.render_resource'] = render_resource
      else
        @request.env['simpler.template'] = resource
      end
    end

    def status(status_code)
      @response.status = status_code
    end

    def headers
      @response
    end

    def params
      @request.params
    end


  end
end
