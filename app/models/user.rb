class User < ApplicationRecord
  has_many :test_passages, dependent: :destroy
  has_many :tests, through: :test_passages

  has_many :created_tests, class_name: "Test", foreign_key: :author_id, dependent: :nullify

  validates :name, :email, presence: true
  validates :email, uniqueness: true

  def test_by_level(level)
    tests.where(level: level)
  end

  def result(test)
    results.order(id: :desc).find_by(test_id: test.id)
  end
end
