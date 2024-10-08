class Task < ApplicationRecord
  belongs_to :category
  validates :title, presence: true

  enum status: { pending: 0, in_progress: 1, in_review: 2, completed: 3 }

  def complete?
    status == "completed"
  end

  def complete!
    update(status: :completed)
  end

  def incomplete!
    update(status: :pending)
  end
end
