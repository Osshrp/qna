require 'rails_helper'
require_relative 'concerns/commented_spec.rb'

RSpec.describe Questions::CommentsController, type: :controller do
  it_behaves_like 'commented'
end