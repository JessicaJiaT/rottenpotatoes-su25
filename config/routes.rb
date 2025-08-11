Rails.application.routes.draw do
  # 定义 Movies 资源的 RESTful 路由
  # 自动生成 index, show, new, create, edit, update, destroy 等 7 个动作的路径
  resources :movies

  # 设置应用的根路径（/）重定向到 /movies
  # 这样访问首页时会直接跳到电影列表页面
  root :to => redirect('/movies')
end
