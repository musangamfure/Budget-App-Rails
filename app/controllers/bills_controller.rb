class BillsController < ApplicationController
  before_action :find_category, only: [:new, :create]
  before_action :ensure_category_owner, only: :create

  def new
    @bill = Bill.new
  end

  def create
    if @bill.save
      flash[:notice] = 'Bill created successfully'
      redirect_to @bill.categories.first
    else
      flash[:alert] = @bill.errors.full_messages.first if @bill.errors.any?
      render :new, status: :unprocessable_entity
    end
  end

  private

  def bill_params
    params.require(:bill).permit(:name, :amount, category_ids: [])
  end

  def find_category
    @category = Category.find(params[:category_id])
    @bill = @category.bills.build(bill_params)
    @bill.user = current_user
  end

  def ensure_category_owner
    unless @category.user == current_user
      redirect_to categories_path, notice: 'You can only create bills from your categories'
    end
  end
end
