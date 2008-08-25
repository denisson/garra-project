class EventsController < ApplicationController
  before_filter :login_required, :except => [:list, :show, :view]  

  # GET /events
  # GET /events.xml
  def index
    @events = Event.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
    end
  end

  # GET /events/list
  # GET /events/list.xml
  def list
    @events = Event.find(:all)
    get_page_metadata

    respond_to do |format|
      format.html # list.html.erb
      format.xml  { render :xml => @events }
    end
  end

  # GET /events/1
  # GET /events/1.xml
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/1
  # GET /events/1.xml
  def view
    @event = Event.find(params[:id])
    
    @comments = Comment.find_comments_for_commentable('Event',@event.id)

    #   event = Event.new
       # comment = Comment.new(:title => "Titulo", :comment => "commentStr", :user_id => "1")
       # comment.comment = 'Some comment'
       # @event.comments << comment
       # debugger

      # Event.add_comment comment
      
    respond_to do |format|
        format.html
        format.xml  { render :xml => @event }
    end
  end
  
  def add_comment
    comment = Comment.new(params[:comment])
    @event = Event.find(comment.commentable_id)
    
    if @event.comments << comment
      flash[:notice] = 'Obrigado por comentar, volte sempre.'
      redirect_to('/events/view/'+comment.commentable_id.to_s)
    else
=begin
      /**
       * @todo Fix the error message for comments
       */
=end
      redirect_to('/events/view/'+comment.commentable_id.to_s)
    end
    
  end

  # GET /events/new
  # GET /events/new.xml
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.xml
  def create
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        flash[:notice] = 'Evento criado com sucesso.'
        format.html { redirect_to(@event) }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.xml
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        flash[:notice] = 'O evento foi alterado com sucesso.'
        format.html { redirect_to(@event) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to(events_url) }
      format.xml  { head :ok }
    end
  end
end
