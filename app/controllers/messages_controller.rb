class MessagesController < ApplicationController
  def index
    @messages = Message.all.order(created_at: :asc)
    render json: @messages
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      response = generate_response(@message)
      render json: { user_message: @message, response: response }, status: :created
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :message_type)
  end

  def generate_response(message)
    case message.message_type
    when "greeting"
      "¡Hola! ¿Cómo estás? ¿En qué puedo ayudarte?"
    when "help"
      "Estas son tus opciones:\n1. Saber más sobre este chatbox.\n2. Conseguir ayuda.\n3. Explorar datos curiosos."
    when "fun_fact"
      "Dato curioso: ¿Sabías que los koalas tienen huellas dactilares casi idénticas a las humanas? 🐨"
    else
      "Lo siento, no entiendo tu solicitud. ¿Podrías intentarlo de nuevo?"
    end
  end


end
