unless Rails.env.production?
  ENV['BASE_URL'] = "http://localhost:3000"
end