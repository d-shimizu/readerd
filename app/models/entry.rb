class Entry < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  #belongs_to :feed, :include => :category
  #belongs_to :feed, :polymorphic => :category
  #belongs_to :feed, :polymorphic => :category, :foreign_key => "id"
  belongs_to :feed, :polymorphic => :category
  delegate :category, :to => :feed, :allow_nil => true

  ### kaminari
  #default_scope :order => 'published_at DESC'
  default_scope -> { order( 'published_at DESC') }
  paginates_per 60
end
