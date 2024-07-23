# config/initializers/google_cloud_storage.rb
require "google/cloud/storage"

storage = Google::Cloud::Storage.new(
  project_id: "vocal-affinity-427706-a4",
  credentials: Rails.root.join("config/vocal-affinity-427706-a4-6dd880f449c9.json").to_s
)

bucket = storage.bucket "ruby2024"

if bucket
  puts "Bucket exists and is accessible."
  files = bucket.files
  files.each do |file|
    puts "File: #{file.name}"
  end
else
  puts "Bucket does not exist or is not accessible."
end
