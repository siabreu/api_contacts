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

  # PATCH /api/v1/contacts/1
  def update
    if @contact.update(contact_params)
      render json: @contact
    else
      render json: @contact.erros, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/contacts/1
  def destroy
    @contact.destroy
  end

  private
    def set_contact
      @contact = Contact.find(params[:id])
    end

    def contact_params
      params.require(:contact).permit(:name, :email, :phone, :description)
    end

    def require_authentication!
      unless current_user == @contact.user
        render json: {}, status: :forbidden 
      end
    end
end
