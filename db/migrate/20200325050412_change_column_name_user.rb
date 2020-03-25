class ChangeColumnNameUser < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :auth_token, :password_digest
  end
end
