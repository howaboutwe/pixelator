require "spec_helper"

describe 'home/index' do
  before { @orig_envs = Pixelator.run_envs }
  after { Pixelator.run_envs = @orig_envs }

  it "should include pixelator/data.js script tag" do
    render template: 'home/index', layout: "layouts/application"
    rendered.should include('<script src="/pixelator/data.js" type="text/javascript"></script>')
  end

  it "should include pixelator_head" do
    render template: 'home/index', layout: "layouts/application"
    rendered.should include('var _gaq')
  end

  context "Pixelator is on" do
     before do
       Pixelator.run_envs << 'test'
     end

    it "should include Pixelator.run code" do
      render

      rendered.should include("new Pixelator(PIXEL_DATA, '');")
      rendered.should include("pixelator.run")
      rendered.should_not include("NOTICE: Pixelator is OFF")
    end
  end

  it "should include NOT Pixelator.run code if Pixelator is off" do
    Pixelator.run_envs.delete('test')
    Pixelator.run_envs.should_not include('test')

    render

    rendered.should_not include("new Pixelator(PIXEL_DATA, '');")
    rendered.should_not include("pixelator.run")
    rendered.should include("NOTICE: Pixelator is OFF")
  end

end
