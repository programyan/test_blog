# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = YAML.load_file(File.join('db', 'yamls', 'users.yml'))
ips = YAML.load_file(File.join('db', 'yamls', 'network_addresses.yml'))

::Post.delete_all
::User.delete_all
::Rank.delete_all
threads = []
begin_time = Time.now

5.times.each do
  threads << Thread.new do
    40000.times do
      post_request = <<-TEXT
        curl -XPOST -H "Content-Type: application/json\" \
                    -H "Accept: application/json" \
                    -d '{"title": "#{Faker::Lorem.sentence}", "body": "#{Faker::Lorem.paragraph(3, true, 4)}", "ip": "#{ips.sample['ip']}", "login": "#{users.sample['login']}" }' \
                    http://localhost:3000/posts
      TEXT

      response = JSON.parse(`#{post_request}`)

      next if rand(10) > 4

      (1..3).to_a.sample.times do
        system <<-TEXT
          curl -XPOST -H "Content-Type: application/json\" \
                      -H "Accept: application/json" \
                      -d '{"rank": #{(1..5).to_a.sample} }' \
                      http://localhost:3000/posts/#{response['id']}/rank
        TEXT
      end
    end
  end
end

threads.each(&:join)

ap "Time: #{Time.now - begin_time}"
