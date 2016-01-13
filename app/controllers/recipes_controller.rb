class RecipesController < ApplicationController
    before_action :set_recipe, only:[:edit, :update, :show, :like]
    before_action :require_user, except: [:show, :index, :like]
    before_action :require_user_like, only:[:like]
    before_action :require_same_user, only:[:edit, :update]
    before_action :admin_user, only: :destroy
    
    def index
        @recipes = Recipe.paginate(page: params[:page], per_page: 4)
    end
    
    def new 
        @recipe = Recipe.new
    end
    
    def create
        @recipe = Recipe.new(recipe_params)
        @recipe.chef = current_user
        if @recipe.save
            flash[:success] = "Successfully created your recipe"
            redirect_to recipes_path
        else
            render :new
        end
    end
    
    def show
        
    end
    
    def edit
       
    end
    
    def update
         if @recipe.update(recipe_params)
             flash[:success] = "Updated your recipe successfully"
             redirect_to recipe_path(@recipe)
         else
             render :edit
         end
             
    end
    
    def destroy
    end
    
    def like 
        @recipe = Recipe.find(params[:id])
        like = Like.create(like: params[:like], chef: current_user, recipe: @recipe)
        if like.valid?
        flash[:success] = "Your selection was successful"
        redirect_to :back
        else
           flash[:danger] = " You can like/dislike once"
           redirect_to :back
        end
    end
    def destroy
        Recipe.find(params[:id]).destroy
        flash[:success] = "Recipe Deleted"
        redirect_to recipes_path
    end
    
    private
        def recipe_params
            params.require(:recipe).permit(:name, :summary, :description, :picture, style_ids:[],ingredient_ids:[])
        end
        
        def set_recipe
            @recipe = Recipe.find(params[:id])
        end
        
        def require_same_user
            if current_user != @recipe.chef and !@recipe.admin?
            flash[:danger] = "You can not edit this"
            redirect_to recipes_path
            end
        end
        
        def require_user_like
            if !logged_in?
            flash[:danger]= "You must Log in"
            redirect_to :back
         end
    end
    def admin_user
        redirect_to recipes_path unless current_user.admin?
    end
end
