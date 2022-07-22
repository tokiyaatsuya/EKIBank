class PagesController < ApplicationController
  before_action :sign_in_required, only: [:top_show]

  def top_show
  end
end
