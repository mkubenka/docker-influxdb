require "docker"
require "serverspec"

set :backend, :docker

Docker.options = { read_timeout: 600, write_timeout: 600, connect_timeout: 360 }

project_root = '.'

RSpec.configure do |c|
  c.before(:suite) do
    @image = Docker::Image.build_from_dir(project_root)
    set :docker_image, @image.id

    Specinfra::backend.send_file(File.join(__dir__, 'test.influxql'), '/docker-entrypoint-initdb.d/test.influxql')
  end
end
