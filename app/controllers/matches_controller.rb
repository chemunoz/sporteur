class MatchesController < ApplicationController
  before_action :create_teams, only: [:create]

  def index
    if params[:user_id]
      @matches = Match.where(creator_id: params[:user_id]).order(date: :desc)
    else
      @matches = Match.all
    end
  end

  def new
    @user = current_user
    #@match = Match.new
    @match = @user.matches.new
  end

  def create
    
    # date: "2016-03-21 00:00:00"
    fecha = params[:match]['date(1i)']+"-"+params[:match]['date(2i)']+"-"+params[:match]['date(3i)'] + " " + params[:match]['date(4i)'] + ":" + params[:match]['date(5i)']
    @match = current_user.matches.new(date: fecha, score: params[:match][:score], creator_id: current_user.id)
    #@article = Article.new(article_params)
    #@article = current_user.articles.new(article_params)

    if @match.save
      redirect_to matches_path, notice: 'Match was successfully created.' 
    else
      render :new
    end
  end


  private
  def create_teams
    
  end
end
