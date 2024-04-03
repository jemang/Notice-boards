class EventsController < ApplicationController
  before_action :set_event, only: %i[ show edit update destroy ]
  respond_to :turbo_stream, only: [:create, :update, :destroy]

  def index
    @events = Event.all
    respond_with @events
  end

  def show
  end

  def new
    @event = Event.new
  end

  def edit
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to events_path
    else
      respond_with(@event)
    end
  end

  def update
    @event.update(event_params)
    respond_with(@event)
  end

  def destroy
    @event.destroy!
    respond_with(@event)
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :note)
  end
end
