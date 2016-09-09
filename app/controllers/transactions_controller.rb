class TransactionsController < ApplicationController
  
  #before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  #before_action :correct_user,   only: [:edit, :update]
  #before_action :admin_user,     only: :destroy
  
  def index
    @transactions = LedgerTransaction.where(:user_id => current_user.id)
    #@transactions = LedgerTransaction.all
    #@transactions = LedgerTransaction.paginate(page: params[:page])
    #@users = User.where(activated: true).paginate(page: params[:page])
  end
  
  def show
    @transaction = LedgerTransaction.find(params[:id])
    #redirect_to transaction_url and return unless @transaction
  end
  
  def new
    # Handle empty ledgers for new user, etc.
    if LedgerTransaction.all.where(user_id: current_user.id).count > 0
      transactionid = LedgerTransaction.all.where(user_id: current_user.id).maximum("transaction_id")
      transactionid +=1
    else
      transactionid = 1
    end
    
    @transaction = LedgerTransaction.new(
      :transaction_id => transactionid,
      :transaction_date => Time.now.strftime("%d/%m/%Y %H:%M"),
      :user_id => current_user.id
    )
  end
  
  def create
    @transaction = LedgerTransaction.new(transaction_params)
    @transaction[:user_id] = current_user.id
    @transaction[:running_balance] = LedgerTransaction.all.where(user_id: current_user.id).sum("amount") + @transaction[:amount]
    if @transaction.save
      flash[:info] = "Entry Saved."
      redirect_to transactions_url 
    else
      render 'new'
    end
  end
  
  def edit
    @transaction = LedgerTransaction.find(params[:id])
  end
  
  def update
    @transaction = LedgerTransaction.find(params[:id])
    if @transaction.update_attributes(transaction_params)
      flash[:success] = "Entry updated"
      redirect_to transaction_url
    else
      render 'edit'
    end
  end
  
  def destroy
    LedgerTransaction.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to transactions_url 
  end
  
  private

    def transaction_params
      params.require(:ledger_transaction).permit(:transaction_id, :user_id, :transaction_date, :description, :amount)
    end
    
    # Before filters

    # Confirms a logged-in user.
    #def logged_in_user
      #unless logged_in?
      #  store_location
      #  flash[:danger] = "Please log in."
      #  redirect_to login_url
      #end
    #end
    
    # Confirms the correct user.
    #def correct_user
    #  @user = User.find(params[:id])
    #  redirect_to(root_url) unless current_user?(@user)
    #end
    
    # Confirms an admin user.
    #def admin_user
    #  redirect_to(root_url) unless current_user.admin?
    #end
  
end