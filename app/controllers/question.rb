get '/questions' do
# List out the questions
  @questions = Question.all
  erb :'questions/index'
  
end

get '/questions/new' do
# Shows a form for a new question
  erb :'questions/new'
end

post '/questions/new' do
# Save the question into database, otherwise show page with 
  @question = Question.new(params[:question])
  if @question.save
    redirect "/questions/#{@question.id}"
  else
    @errors = @question.errors.full_messages
    erb :'questions/new'
  end
end

get '/questions/:id' do
  erb :'questions/show'
end

# Stretch Challenges

put '/questions/:id/edit' do
  question = Question.find_by(id: params[:id])
  question = update_attributes(params[:question])
  redirect "/questions/#{@question.id}"
end

delete '/questions/:id/delete' do
  question = Question.find_by(id: params[:id])
  question.destroy
  redirect '/questions'
end
