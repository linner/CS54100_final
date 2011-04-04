class AssignmentsController < ApplicationController

  #Lists all assignments for a questionnaire.
  #NOTE: params[:id] refers to a questionnaire
  def index
    @questionnaire = Questionnaire.find(params[:id])
    @submissions = @questionnaire.assignments.where(:submitted => true)
  end

  def new
  end

  def create
    @questionnaire = Questionnaire.find(params[:questionnaire])
    @assignees = User.find(params[:user_ids]) if not params[:user_ids].blank?

    assigned = 0

    #How do you do this via mass assignment?
    for user in @assignees
      if Assignment.where(:user_id => user).where(:questionnaire_id => @questionnaire).exists?
        flash[:alert] = "Warning: at least one of thsoe users has already been assigned that questionnaire!"
      else
        Assignment.create(:user => user, :questionnaire => @questionnaire, :assigner => current_user)
        assigned += 1
      end
    end

    flash[:notice] = "Assigned #{@questionnaire.name} to #{assigned} users."
    redirect_to questionnaires_path
  end

  #Used to finalize a submission
  def update
    @assignment = current_user.assignments.where(:questionnaire_id => params[:id]).first
    @assignment.update_attributes(:submitted => true)

    flash[:notice] = "Questionnaire submitted."
    redirect_to questionnaires_path
  end

  def show
    @assignment = Assignment.find(params[:id])
    @questionnaire = @assignment.questionnaire
    @user = @assignment.user

    
  end
end