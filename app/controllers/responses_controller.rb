class ResponsesController < ApplicationController

  # GET /responses/new
  def new
  end

  # POST /responses
  def create
    
    #All responses by user
    user_responses = Response.where(:owner => current_user.id)

    #Update all responses in the form that was just submitted (views\questionnaires\answer.html.erb)
    params[:questions].each do |question_id, response|
      r = user_responses.where(:question_id => question_id).first
      
      if r.nil?
        Response.create(:question_id => question_id, :response => response , :owner => current_user.id)
      else
        r.update_attributes(:response => response)
      end
    end

    flash[:notice] = "Progress saved."
    redirect_to questionnaires_path
  end
end