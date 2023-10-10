FactoryBot.define do
  factory :post do
    title { 'Sample Title' }
    text { 'This is a sample post.' }
    commentsCounter { 0 }
    likesCounter { 0 }
    association :author, factory: :user
  end
end
