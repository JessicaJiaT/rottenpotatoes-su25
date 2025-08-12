class MoviesController < ApplicationController
  def index
    @all_ratings = Movie.all_ratings

    if params[:ratings].present?
      @ratings_to_show    = params[:ratings].keys
      session[:ratings_h] = params[:ratings]
    elsif session[:ratings_h].present?
      @ratings_to_show = session[:ratings_h].keys
      params[:ratings] = session[:ratings_h]
    else
      @ratings_to_show = @all_ratings
    end

    if params[:sort_by].present?
      @sort_by = params[:sort_by]
      session[:sort_by] = @sort_by
    elsif session[:sort_by].present?
      @sort_by = session[:sort_by]
      params[:sort_by] = @sort_by
    else
      @sort_by = nil
    end

    scope   = Movie.with_ratings(@ratings_to_show)
    @movies = Movie.sorted(scope, @sort_by)

    @ratings_hash = @ratings_to_show.product(['1']).to_h
  end

  private
  def movie_params
    params.require(:movie).permit(:title, :rating, :release_date, :description)
  end
end