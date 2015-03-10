require 'spec_helper'

describe ArticlesController do

  fixtures :articles, :comments

  it 'the truth' do
    assert true
  end

  it 'renders the index template' do
    get :index
    expect(response).to render_template('index')
  end
end
