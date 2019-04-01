class Api::FilesController < ApiController
  
  def create
    image = current_team.images.attach(params[:file])[0]
    render json: {result: "success", id: image.id}
  end
  
  def destroy
    ActiveStorage::Attachment.find(params[:id]).purge
    render json: {result: "success"}
  end
end