class UniqueActivationToken < ActiveRecord::Migration[5.2]
  def change
    User.all.each do |u|
      next unless u.activation_token == '1234'
      u.activation_token = SecureRandom::urlsafe_base64(16)
      u.save!
    end

    add_index :users, :activation_token, unique: true
  end
end
