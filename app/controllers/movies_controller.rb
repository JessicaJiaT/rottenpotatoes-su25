class MoviesController < ApplicationController
  def index
    # 获取所有电影的评级（去重、去空值、按字母排序）
    @all_ratings = Movie.distinct.pluck(:rating).compact.sort

    # 如果 params[:ratings] 存在，使用它；否则默认选中所有评级
    if params[:ratings]
      # 如果是 Hash（或 ActionController::Parameters），取 key；否则直接用数组
      @selected_ratings = params[:ratings].is_a?(Hash) ? params[:ratings].keys : params[:ratings]
    else
      @selected_ratings = @all_ratings
    end

    # 获取排序参数（可能是 "title" 或 "release_date"）
    @sort = params[:sort]

    # 先按评级过滤电影
    @movies = Movie.where(rating: @selected_ratings)

    # 如果排序字段有效，则按该字段排序
    if %w[title release_date].include?(@sort)
      @movies = @movies.order(@sort)
    end
  end
end
