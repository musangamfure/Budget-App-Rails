class CategoriesController < ApplicationController
  before_action :set_user

  def index
    @categories = @user.categories.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.user = @user
    if @category.save
      redirect_to categories_path, notice: 'Category added successfully'
    else
      flash.now[:alert] = @category.errors.full_messages.first if @category.errors.any?
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @category = Category.find(params[:id])
    redirect_to categories_path, notice: 'You are not authorized to access this page!' unless @category.user == @user
    @bills = @category.bills.order(created_at: :desc)
    @total = @bills.sum(:amount)
  end

  private

  def set_user
    @user = current_user
  end

  def category_params
    params.require(:category).permit(:name, :icon)
  end
end
