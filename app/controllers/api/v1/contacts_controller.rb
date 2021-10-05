class Api::V1::ContactsController < Api::V1:ApiController
  before_action :set_contact, only: [:show, :update, :destroy]
  before_action :require_authentication!, only: [:show, :update, :destroy]

  # GET /api/v1/contacts
  def index
    @contacts = current_user.Contacts

    render json: @contacts
  end

  # GET /api/v1/contacts/1
  def show
    render json: @contacts
  end

  # POST /api/v1/contacts
  def create
    @contact = Contact.new(contact_params.merge(user: current_user))

    if @contact.save
      render json: @contact, status: :created
    else
      render json: @contact.erros, status: :unprocessable_entity
    end
  end

end
