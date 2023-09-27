class BillsController < ApplicationController
  before_action :find_category
  before_action :ensure_category_owner, only: :create

  def new
    @bill = @category.bills.build
  end

  def create
    @bill = @category.bills.build(bill_params)
    @bill.user = current_user

    if @bill.save
      flash[:notice] = 'Bill created successfully'
      redirect_to category_path(@category)
    else
      flash.now[:alert] = @bill.errors.full_messages.first if @bill.errors.any?
      render :new, status: :unprocessable_entity
    end
  end

  private

  def bill_params
    params.require(:bill).permit(:name, :amount)
  end

  def find_category
    @category = Category.find(params[:category_id])
  end

  def ensure_category_owner
    unless @category.user == current_user
      redirect_to categories_path, notice: 'You can only create bills in your categories'
    end
  end
end
