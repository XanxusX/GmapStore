module ReviewsHelper
  def render_review_comment(review)
    simple_format(review.comment)
  end
end
