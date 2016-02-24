class RemoveGenreFromBooks < ActiveRecord::Migration
	def up
		remove_reference :books, :genre
		#remove_index :books, :genre
		#remove_column :books, :genre
	end

	def down
		add_reference :books, :genre, index: true
	end
end
