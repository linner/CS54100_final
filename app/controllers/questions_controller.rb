class QuestionsController < ApplicationController
  #before_filter :check_authorization

  def check_authorization
    if current_user.is_admin?
      nil
    else
      redirect_to questionnaires_path
    end
  end

  # GET /questions
  def index
    @questions = Question.all
  end

  # GET /questions/1
  def show
    @question = Question.find(params[:id])
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
    @question = Question.find(params[:id])
  end

  # POST /questions
  def create
    @question = Question.new(params[:question])

      if @question.save
        flash[:notice] = 'Question was successfully created.'
        redirect_to questions_path
      else
        render :action => "new"
      end
  end

  # PUT /questions/1
  def update
    @question = Question.find(params[:id])

    flash[:notice] = 'Question was successfully updated.'
    redirect_to questions_path
  end

  # DELETE /questions/1
  def destroy
    @question = Question.find(params[:id])
    @question.destroy
  
    redirect_to questions_path
  end
end
