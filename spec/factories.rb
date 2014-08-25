FactoryGirl.define do
	factory :user do # :user symbol tells Factory Girl it's for a User model object
		name 		"Michael Hartl"
		email		"michael@example.com"
		password	"foobar"
		password_confirmation	"foobar"
	end
end