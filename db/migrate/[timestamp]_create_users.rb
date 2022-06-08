class CreateUsers < ActiveRecord::Migration[5.0]
	def change
		create_table :users do |t|
			t.string :name
			t.string :email
			
			t.timestamps
		end
		add_column :users, :admin, :boolean, default: false
	end
end