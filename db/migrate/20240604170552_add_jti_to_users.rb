class AddJtiToUsers < ActiveRecord::Migration[7.1]
  def change
    # Étape 1 : Ajouter la colonne sans la contrainte NOT NULL
    add_column :users, :jti, :string

    # Étape 2 : Mettre à jour les enregistrements existants
    User.reset_column_information
    User.find_each do |user|
      user.update_columns(jti: SecureRandom.uuid)
    end

    # Étape 3 : Ajouter la contrainte NOT NULL et l'index unique
    change_column_null :users, :jti, false
    add_index :users, :jti, unique: true
  end
end

