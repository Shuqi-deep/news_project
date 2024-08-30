class AddIndexToUsersEmail < ActiveRecord::Migration[7.2]
  def change
    # Добавляем индекс только если он еще не существует
    unless index_exists?(:users, :email, unique: true)
      add_index :users, :email, unique: true
    end
  end
end
