class Api::InquiryController < ApiController
  
  def create
    Inquiry.create(inquiry_params)
    render json: {result: "success"}
  end
  
  private
  
  def inquiry_params
    params.require(:inquiry).permit(:email, :text).tap do |v|
      v[:team_id] = current_team.id
      v[:status] = Inquiry.statuses[:no_read]
    end
  end
end