class CategoriesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :find_category, only: [:show]
  before_action :ensure_category_owner, only: [:show]
  before_action :set_user

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
    @bills = @category.bills.order(created_at: :desc)
    @total = @bills.sum(:amount)
  end

  private

  def category_params
    params.require(:category).permit(:name, :icon)
  end

  def find_category
    @category = Category.find(params[:id])
  end

  def ensure_category_owner
    unless @category.user == @user
      redirect_to categories_path, notice: 'You are not authorized to access this page!'
    end
  end

  def set_user
    @user = current_user || User.new
  end
end

