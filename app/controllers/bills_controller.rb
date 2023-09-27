class BillsController < ApplicationController
  before_action :find_category

  def new
    @bill = Bill.new
  end

  def create
    unless @category.user == current_user
      return redirect_to categories_path, notice: 'You can only create bills from your categories'
    end

    if bill_params[:category_ids].length == 1
      return redirect_to new_category_bill_path(@category), alert: 'Must select at least one category'
    end

    @bill = Bill.new(bill_params)
    @bill.user = current_user

    if @bill.save
      flash[:notice] = 'Bill created successfully'
      @redirect_category = Category.find(bill_params[:category_ids].at(1))
      redirect_to @redirect_category
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
  end
end