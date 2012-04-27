require 'factory_girl'

FactoryGirl.define do
  sequence :client_name do |n|
    "Client ##{n}"
  end

  sequence :user_name do |n|
    "User ##{n}"
  end

  factory :owner, :class => TestApp::User do |u|
    u.name { FactoryGirl.generate :user_name }
  end

  factory :client, :class => OAuth2::Model::Client do |c|
    c.client_id     { OAuth2.random_string }
    c.client_secret { OAuth2.random_string }
    c.name          { FactoryGirl.generate :client_name }
    c.redirect_uri  'https://client.example.com/cb'
  end

  factory :authorization, :class => OAuth2::Model::Authorization do |ac|
    ac.client     FactoryGirl.create(:client)
    ac.code       { OAuth2.random_string }
    ac.expires_at nil
  end

end
