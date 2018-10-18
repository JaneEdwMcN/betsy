class ProductsController < ApplicationController
 before_action :find_product, only: [:show, :edit, :update, :destroy, :retire]

 def index
   @products = Product.order(:name)
 end

 def new
   @product = Product.new(user_id: session[:user_id])
 end

 def create
   @product = Product.new(product_params)
   if @product.save
     redirect_to products_path
   else
     flash[:failure] = "failed to save"
     render :new, :status => :bad_request
   end
 end

 def show
 end

 def edit;end

 def update
   if @product.save
     redirect_to product_path(@product)
   else
     render :edit, :status => :bad_request
   end
 end

 private
 def product_params
   return params.require(:product).permit(:name, :price, :stock, :product_status, :user_id, :image, :description, category_ids: [])
 end

 def find_product
   @product = Product.find_by(id: params[:id])
   if !@product
     @product = Product.find_by(id: params[:product_id])
   end

 end

end
