module SponsoredPostsHelper
  def user_is_authorized_for_sponsored_post?(sponsored_post)
    current_user.admin?
  end
end
