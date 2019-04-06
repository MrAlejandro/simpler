require 'logger'

module Simpler
  class SimplerLogger

    def initialize(app, **options)
      @logger = Logger.new(options[:log_file_path] || ENV['LOG_FILE_PATH'] || STDOUT)
      @app = app
    end

    def call(env)
      status, headers, body = @app.call(env)
      message = "\n#{log_parts(env, status, headers).join("\n")}\n"
      @logger.info(message)

      [status, headers, body]
    end

    private

    def log_parts(env, status, headers)
      [
        "Request: #{env['REQUEST_METHOD']} #{env['REQUEST_URI']}",
        "Handler: #{env['simpler.controller'].class}##{env['simpler.action']}",
        "Parameters: #{env['simpler.request'].params}",
        "Response: #{status} [#{headers['Content-Type']}] #{env['simpler.rendered_template']}"
      ]
    end
  end
end
