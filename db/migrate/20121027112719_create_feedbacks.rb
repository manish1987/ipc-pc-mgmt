class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.integer :session_id
      t.text :feedback

      t.timestamps
    end
  end
end
