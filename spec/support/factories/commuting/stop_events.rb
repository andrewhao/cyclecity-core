FactoryGirl.define do
  factory :commuting_stop_event, class: 'Commuting::StopEvent' do
    commuting_commute
    lonlat { RGeo::Geos.factory(srid: 4326).point(28.72292, 77.123434) }
    stopped_at { Time.zone.now }
    duration { 10 + Random.new.rand(500) }
  end
end
