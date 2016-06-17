FactoryGirl.define do
  factory :commuting_commute, class: 'Commuting::Commute' do
    sequence(:strava_activity_id) { |n| n }
  end
end
