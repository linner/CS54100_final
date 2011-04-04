class QuestionnairesController < ApplicationController

  def index
    #If not logged in, goto login page
    if current_user
      @questionnaires = Questionnaire.all

      #Admin: View, edit, delete questionnaires
      #User: Assigned questionnaires only
      if current_user.is_admin?
        render "index"
      else
        @assignments = Assignment.find_all_by_user_id(current_user)
        render "assignments"
      end
    else
      flash[:notice] = "Please login first."
      redirect_to login_path
    end
  end

  #Show a single questionnaire
  def show
    @questionnaire = Questionnaire.find(params[:id])
  end

  def new
    @questionnaire = Questionnaire.new
    @questions = Question.all
  end

  # GET /questionnaires/1/edit
  def edit
    @questionnaire = Questionnaire.find(params[:id])
    @questions = Question.all
  end

  # POST /questionnaires
  def create

    @questionnaire = Questionnaire.new
    @questionnaire.name = params[:name]
    @questionnaire.author = current_user.id

    if params[:question_ids].blank?
      flash[:notice] = "Please select at least one question."
      render :action => "new"
    else
      @questionnaire.questions = Question.find(params[:question_ids])
      
      if @questionnaire.save
        flash[:notice] = "Questionnaire \"#{@questionnaire.name}\" successfully created."
        redirect_to questionnaires_path
      else
        render :action => "new"
      end
    end
  end

  # PUT /questionnaires/1
  def update
    @questionnaire = Questionnaire.find(params[:id])
    @questionnaire.name = params[:name]

    if params[:question_ids] != nil
      @questionnaire.questions = Question.find(params[:question_ids])
    else
      @questionnaire.questions = []
    end

    if @questionnaire.save
      flash[:notice] = "Questionnaire \"#{@questionnaire.name}\" was updated."
      redirect_to questionnaires_path
    else
      render :action => "edit"
    end
  end

  # DELETE /questionnaires/1
  def destroy
    @questionnaire = Questionnaire.find(params[:id])
    @questionnaire.destroy

    flash[:notice] = "Questionnaire deleted."
    redirect_to questionnaires_path
  end

  def assign
    @questionnaire = Questionnaire.find(params[:id])

    #Eligible assignees
    @users = User.where(:account_type => "user") - @questionnaire.users

    if @users.count.zero?
      flash[:notice] = "No users are eligible to take that questionnaire."
      redirect_to questionnaires_path
    end
  end

  def answer
    @questionnaire = Questionnaire.find(params[:id])
  end
end