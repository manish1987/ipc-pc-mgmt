class ChangeEmailToNameUser < ActiveRecord::Migration
  def up
  	rename_column 'admins','email','username'
  end

  def down
  	rename_column 'admins','username','email'
  end
end
