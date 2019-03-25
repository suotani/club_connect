class Api::TodosController < ApplicationController
  before_action :set_todo, only: [:show, :update, :destroy]
  def index
      render json: Todo.order(:created_at)
  end
  
  def create
    @todo = Todo.new(todo_params)
    if @todo.save
      render json: {result: true}
    else
      render json: {result: false, errors: @todo.errors.full_messages}
    end
  end
  
  def show
      if @todo
          render json: {result: true, todo: @todo}
      else
          render json: {result: false, errors: ["todo not found"]}
      end
  end
  
  def update
    if @todo.update(todo_params)
      render json: {result: true}
    else
      render json: {result: false, errors: @todo.errors.full_messages}
    end
  end
  
  def destroy
    @todo.destroy
    render json: {result: true}
  end
  
  private
  
  def todo_params
      params.require(:todo).permit(:text, :status, :limit_at)
  end
  
  def set_todo
    @todo = Todo.find(params[:id])
  end
end