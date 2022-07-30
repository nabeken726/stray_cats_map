class Public::RanksController < ApplicationController
  
  def rank
    @post_cute_ranks = Post.find(Cute.group(:post_id).order('count(post_id) desc').pluck(:post_id))
    @post_look_ranks = Post.find(Look.group(:post_id).order('count(post_id) desc').pluck(:post_id))
  
  end
  
end
