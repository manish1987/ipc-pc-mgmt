class AddCommittmentToWarrior < ActiveRecord::Migration
  def change
    add_column("warriors","commitment",:integer)
  end
end
