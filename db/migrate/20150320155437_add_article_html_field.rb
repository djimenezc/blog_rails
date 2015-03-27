class AddArticleHtmlField < ActiveRecord::Migration
  def change
    add_column :articles, :html, :string
  end
end
