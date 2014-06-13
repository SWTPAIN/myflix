class GenerateTokensForExistingUsers < ActiveRecord::Migration
  def change
    User.all.each {|user| user.update_column(:token, SecureRandom.urlsafe_base64)}
  end
end
