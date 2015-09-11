class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
    	t.text :content, null:false, limit:1500
    	t.references :commentable, polymorphic: true, index:true
      t.references :commentator
      t.timestamps
    end
  end
end
