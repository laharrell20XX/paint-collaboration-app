class CanvasesController < ApplicationController
  def index
    @canvases = Canvas.all
  end
  def show
    @canvas = Canvas.find(params[:id])
  end
end
