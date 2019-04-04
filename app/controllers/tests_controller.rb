class TestsController < Simpler::Controller

  def index
    @time = Time.now
  end

  def create
  end

  def plain
    status 201
    render plain: "Plain text response"
  end

end
