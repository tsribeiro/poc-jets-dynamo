class AccountsController < ApplicationController
  authorizer "main#MyCognito"
  class_iam_policy(
    "dynamodb",
    {
      action: ["dynamodb:*"],
      effect: "Allow",
      resource: "*",
    }
  )

  before_action :set_account, only: [:show, :update, :delete]

  # GET /accounts
  def index
    @accounts = Account.all(params[:client_id])

    render json: @accounts
  end

  # GET /accounts/1
  def show
    render json: @account
  end

  # POST /accounts
  def create
    @account = Account.new(account_params)

    if @account.save
      render json: @account, status: :created
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /accounts/1
  def update
    if @account.update(account_params)
      render json: @account
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  # DELETE /accounts/1
  def delete
    @account.destroy
    render json: {deleted: true}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find({id: params[:id], client_id: params[:client_id]})
    end

    # Only allow a trusted parameter "white list" through.
    def account_params
      params.permit(:name, :last_name, :client_id).to_h
    end
end
