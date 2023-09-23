class CategoriesController < ApplicationController
  before_action :set_user
  before_action :authenticate_user!, except: %i[index show]

  def index
    @categories = @user.categories.includes(:bills)
  end

  def new
    @category = Category.new
  end

  def create
    @category = @user.categories.build(category_params)

    if @category.save
      redirect_to categories_path, notice: 'Category added successfully'
    else
      flash.now[:alert] = @category.errors.full_messages.first if @category.errors.any?
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @category = Category.find(params[:id])

    unless @category.user == @user
      redirect_to categories_path, notice: 'You are not authorized to access this page!'
      return
    end

    @bills = @category.bills.order(created_at: :desc)
    @total = @bills.sum(:amount)
  end

  private

  def set_user
    @user = current_user || User.new
  end

  def category_params
    params.require(:category).permit(:name, :icon)
  end
end
