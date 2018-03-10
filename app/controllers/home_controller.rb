class HomeController < ApplicationController
  def index
    render react_component: 'Hello', props: { name: 'a component rendered from a controller' }
  end
end