def index
  @all_ratings = Movie.all_ratings

  if params[:ratings].present?
    @ratings_to_show = params[:ratings].keys
  else
    @ratings_to_show = @all_ratings
  end

  @sort_by = params[:sort_by] 
  scope   = Movie.with_ratings(@ratings_to_show)
  @movies = Movie.sorted(scope, @sort_by)


  @ratings_hash = @ratings_to_show.product(['1']).to_h
end
