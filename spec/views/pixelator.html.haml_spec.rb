require 'spec_helper'

describe 'shared/_pixelator.html.haml' do
  before do
    Pixelator.run_envs << 'test'
  end
   it "renders all if send nothing" do
     render
     rendered.should include("_.each([\"all\"]")
   end

   it "renders all if send all" do
     render partial: 'shared/pixelator', pixel_types: ['all']
     rendered.should include("_.each([\"all\"]")
   end

   it "renders landing and all if send landing" do
     render partial: 'shared/pixelator', locals: { pixel_types: ['landing'] }
     rendered.should include("_.each([\"all\", \"landing\"]")
   end

   it "renders landing and all if set var in controller to landing" do
     view.instance_variable_set(:@pixel_types, ['landing'])
     render
     rendered.should include("_.each([\"all\", \"landing\"]")
   end
end
