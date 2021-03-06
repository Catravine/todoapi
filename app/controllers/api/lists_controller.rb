class Api::ListsController < ApiController

  before_action :authenticated?

  def index
    lists = List.all
    render json: lists, each_serializer: ListSerializer
  end

  def create
    user = User.find(params[:user_id])
    list = user.lists.build(list_params)
    if list.save
      render json: list
    else
      render json: { errrors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    begin
      list = List.find(params[:id])
      list.destroy
      render json: {}, status: :no_content
    rescue ActiveRecord::RecordNotFound
      render :json => {}, :status => :not_found
    end
  end

  private

  def list_params
    params.require(:list).permit(:title)
  end

end
