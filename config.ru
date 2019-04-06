require_relative 'config/environment'
require_relative 'lib/simpler/middleware/simpler_logger'

use Simpler::SimplerLogger, log_file_path: File.expand_path('log/app.log', __dir__)

run Simpler.application
