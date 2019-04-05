class TestsController < Simpler::Controller

  def index
    @time = Time.now
  end

  def create
  end

  def plain
    headers['Content-Type'] = 'text/plain'
    headers['X-Simpler-Test'] = 'test'
    status 201
    render plain: "Plain text response"
  end

end
