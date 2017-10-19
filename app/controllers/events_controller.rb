class EventsController < ApplicationController


  def index
    @events = Event.where(state: session[:state])
    @other_events = Event.where.not(state:session[:state])
    @attending = EventAttendee.where(user_id:current_user.id)
  end

  def create 
    event = Event.new(event_params)
    event.user = User.find(session[:id])
    if event.save
      #success
    else 
      flash[:errors] = event.errors.full_messages
    end
    redirect_to '/events'
  end

  def delete
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to '/events'
  end

  def show

    @event = Event.find(params[:id])
    
    @comments = Comment.where(event_id:params[:id]) 
  end

  def update
    e = Event.find(params[:id])
    if e.update event_params
      #success
    else
      flash[:errors] = e.errors.full_messages 
    end
    redirect_to '/events'
  end

  def edit_show
  

    @event = Event.find(params[:id])
    redirect_to '/events' if current_user != @event.user
    

  end

  def add_comment

    comment = Comment.new(comment: params[:comment], user: current_user, event: Event.find(params[:event]))
    if comment.save
      #success
    else
      flash[:errors]=comment.errors.full_messages
    end
    redirect_to '/events/' + params[:event] 
  end 

  def join
    ea = EventAttendee.new(user:current_user, event:Event.find(params[:id]))
    if ea.save
      #success
    else 
      flash[:errors] = ea.errors.full_messages
    end
    redirect_to '/events'
  end

  def cancelRSVP
    e = EventAttendee.find_by_user_id_and_event_id(current_user.id, params[:id])
    e.destroy
    redirect_to '/events'
  end

  private
  def event_params
    params.require(:event).permit(:name, :date, :location, :state,  session[:id])
  end


end
