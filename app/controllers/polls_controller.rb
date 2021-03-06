class PollsController < ApplicationController
  def index
    @polls = Poll.all
    
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  def vote
    if params[:id_option]
      @poll = Poll.find(params[:id])
      @poll.vote(params[:id_option], request.remote_ip) if @poll
    end
    
    render :vote_result
  end
end
