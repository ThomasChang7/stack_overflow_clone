get '/questions/:id/comments/new' do
  require_user
  @question = Question.find_by(id: params[:id])
  if request.xhr?
    erb :'/partials/_new_on_question',layout:false, locals:{question:@question}
  else
    erb :"/comments/new_on_question"
  end
end

post '/questions/:id/comments' do
  require_user
  @question = Question.find_by(id: params[:id])
  @comment = @question.comments.new(params[:comment])
  @comment.user_id = session[:user]

  if @comment.save
    if request.xhr?
      status 200
      erb :'/partials/_question_comment', layout:false, locals:{question_comment: @comment}
    else
      redirect "/questions/#{@question.id}"
    end
  else
    if request.xhr?
      status 422
    else
      @errors = @comment.errors.full_messages
      erb :"/questions/show"
    end
  end
end


get '/questions/:question_id/answers/:answer_id/comments/new' do
  require_user
  question = Question.find_by(id: params[:question_id])
  @answer = Answer.find_by(id: params[:answer_id])
  
  if request.xhr?
    erb :"partials/_new_on_answer", layout:false, locals:{answer: @answer}
  else
    erb :"/comments/new_on_answer"
  end
end

post '/questions/:question_id/answers/:answer_id/comments' do
  require_user
  question = Question.find_by(id: params[:question_id])
  @answer = Answer.find_by(id: params[:answer_id])
  @comment = @answer.comments.new(params[:comment])
  @comment.user_id = session[:user]

  if @comment.save
    if request.xhr?
      status 200
      erb :"partials/_answer_comment", layout:false, locals:{answer_comment:@comment}
    else
      redirect "/questions/#{question.id}"
    end
  else
    if request.xhr?
      status 422
    else
      @errors = @comment.errors.full_messages
      erb :"/questions/show"
    end
  end
end

