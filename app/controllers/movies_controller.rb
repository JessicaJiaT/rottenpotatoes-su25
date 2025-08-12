<th><%= link_to 'Title',        movies_path(sort_by: 'title',        ratings: @ratings_hash) %></th>
<th><%= link_to 'Release date', movies_path(sort_by: 'release_date', ratings: @ratings_hash) %></th>

def index
  @all_ratings = Movie.all_ratings

  # ---- ratings ----
  if params[:ratings].present?
    @ratings_to_show    = params[:ratings].keys
    session[:ratings_h] = params[:ratings]
  elsif session[:ratings_h].present?
    @ratings_to_show = session[:ratings_h].keys
    params[:ratings] = session[:ratings_h] # 回填，便于视图/链接一致
  else
    @ratings_to_show = @all_ratings
  end

  # ---- sort_by ----
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
