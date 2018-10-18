class ReviewsController < ApplicationController

  def new
    @review = Review.new
    @product = Product.find_by(id: params[:product_id])
  end

  def create
    @review = Review.new(review_params)
    @review.save
    redirect_to product_path(@review.product_id)
  end

private
  def review_params
    params.require(:review).permit(:name, :rating, :review, :product_id)
  end

end
