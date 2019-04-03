class Api::ContactsController < ApiController
  
  before_action :set_contact, only: [:show, :update]
  
  # mail box
  def index
    @team = current_team
    @request_contacts = my_contacts.request_message if params[:contact_type] == "request" || params[:contact_type] == "both"
    @normal_contacts = my_contacts.normal_message if params[:contact_type] == "normal" || params[:contact_type] == "both"
    @request_contacts_count = @request_contacts&.count
    @normal_contacts_count = @normal_contacts&.count
    @request_contacts = @request_contacts&.page(params[:page]).per(10) || []
    @normal_contacts = @normal_contacts&.page(params[:page]).per(10) || []
    
    render 'index', formats: 'json', handlers: 'jbuilder'
  end
  
  #mail show
  def show
    if @contact.from_team_id == current_team.id
      @contact.from_team_read!
      @target_team = @contact.to_team
    else
      @contact.to_team.read!
      @target_team = @contact.from_team
    end
    render 'show', formats: 'json', handlers: 'jbuilder'
  end
  
  #new message
  def create
    contact = Contact.create(
      from_team_id: current_team.id,
      to_team_id: params[:id],
      title: params[:title],
      from_team_status: Contact.from_team_statuses[:from_team_send],
      to_team_status: Contact.to_team_statuses[:to_team_no_read],
      contact_type: Contact.contact_types[:normal_message]
    )
    Message.create(contact_id: contact.id, text: params[:text], from_team: current_team.school + " " + current_team.name)
    render json: {result: "success"}
  end
  
  # add message
  def update
    @message = Message.create(contact_id: @contact.id, text: params[:text], from_team: current_team.school + " " + current_team.name)
    if @contact.from_team_id == current_team.id
      @contact.update(
        from_team_status: Contact.from_team_statuses[:from_team_replyed],
        to_team_status: Contact.to_team_statuses[:to_team_no_read]
      )
    else
      @contact.update(
        from_team_status: Contact.from_team_statuses[:from_team_no_read],
        to_team_status: Contact.to_team_statuses[:to_team_replyed]
      )
    end
    render 'update', formats: 'json', handlers: 'jbuilder'
  end
  
  private
  
  def my_contacts
    contacts = Contact.eager_load(:messages)
    contacts = contacts.where(from_team_id: current_team.id)
                         .or(contacts.where(to_team_id: current_team.id))
    contacts
  end
  
  def set_contact
    @contact = my_contacts.find(params[:id])
  end
end