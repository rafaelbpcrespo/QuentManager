FactoryGirl.define do
  factory :conta do

    factory :conta_com_parente do
      after_create do |c|
        c.parentes = [FactoryGirl.create(:usuario_parente, :conta => c)]
      end
    end