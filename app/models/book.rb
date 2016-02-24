class Book < ActiveRecord::Base
	has_and_belongs_to_many :genres

	scope :finished, ->{ where.not(finished_on: nil) }
	scope :recent, ->{ where('finished_on > ?', 2.days.ago) }
	scope :search, ->(keyword){ where('keyword LIKE ?', "%#{keyword.downcase}%") if keyword.present? }
	scope :filter, ->(genre_name){ joins(:genres).where('name = ?', genre_name) if genre_name.present? }

	before_save :set_keywords

	def includes
	end

	def search(keyword)
		if keyword.present?
			where(title: keyword)
		else
			all
		end
	end

	def finished?
		finished_on.present?
	end

	protected

	def set_keywords
		self.keyword = [title, author, description].map(&:downcase).join(' ')
	end
end
