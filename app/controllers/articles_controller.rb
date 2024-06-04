class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_article, only: %i[ show update destroy ]
  before_action :authorize_article, only: %i[ show update destroy ]

  # GET /articles
  def index
    @articles = Article.where(private: false).or(Article.where(user: current_user))

    render json: @articles
  end

  # GET /articles/1
  def show
    render json: @article
  end

  # POST /articles
  def create
    @article = Article.new(article_params)
    @article.user = current_user

    if @article.save
      render json: @article, status: :created, location: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /articles/1
  def update
    if @article.update(article_params)
      render json: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # DELETE /articles/1
  def destroy
    @article.destroy!
  end

  private

    def set_article
      @article = Article.find(params[:id])
    end

    def authorize_article
      if @article.private && @article.user != current_user
        render json: { error: "Not authorized" }, status: :forbidden
      end
    end

    def article_params
      params.require(:article).permit(:title, :content, :private)
    end
end
