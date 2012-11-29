class CreateIndexForCommittments < ActiveRecord::Migration
  def up
    add_index("warriors","commitment")
  end

  def down
    remove_index("warriors","commitment")
  end
end
