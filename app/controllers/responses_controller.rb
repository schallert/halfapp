class ResponsesController < ApplicationController
  def index
    @responses = Response.all
  end

  def sms_inbound
    sender = GlobalPhone.normalize(params[:From])
    body = params[:Body]

    brother = Brother.find_by(:phone_number => sender)
    unless brother
      response = 'Error: phone number not found'
    else
      full_response = ''
      if body.downcase == 'yes'
        if brother.responses.empty?
          message = 'you have been added'
          Response.create(:is_going => true, :brother => brother)
        else
          message = 'you have already been added'
        end
      elsif body.downcase == 'no'
        unless brother.responses.empty?
          brother.responses.each do |res|
            res.destroy!
          end
          message = 'you have been removed'
        else
          message = 'you have already been removed'
        end
      else
        full_response = 'Valid responses are "yes" or "no"'
      end

      if full_response.empty?
        full_response = "#{brother.name}, #{message}"
      end
    end

    twiml = Twilio::TwiML::Response.new do |r|
      r.Message full_response
    end

    render :text => twiml.text
  end
end
