class ChangeColumnDefault < ActiveRecord::Migration[5.2]
  def change
    change_column_default :users, :activation_token, nil
  end
end
