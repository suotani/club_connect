class Api::RequestsController < ApiController
  
  def create
    @contact = Contact.new(request_params)
    schedule = Schedule.find(@contact.schedule_id)
    title = schedule.to_date_string + "合同練習の申し込み"
    @contact.title = title
    @contact.save
    @message = Message.create(
      contact_id: @contact.id,
      text: params[:text],
      from_team: current_team.school + " " + current_team.name
    )
    render json: {result: "success"}
  end
  
  private
  
  def request_params
    params.require(:request).permit(:to_team_id, :schedule_id).tap do |v|
      v[:contact_type] = Contact.contact_types[:request_message]
      v[:from_team_id] = current_team.id
      v[:from_team_status] = Contact.from_team_statuses[:from_team_send]
      v[:to_team_status] = Contact.to_team_statuses[:to_team_no_read]
    end
  end
end