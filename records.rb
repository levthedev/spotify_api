require "rspotify"

class Archive
  def initialize
    RSpotify.authenticate(ENV['CLIENT_ID'], ENV['CLIENT_SECRET'])
    @me = RSpotify::User.find(ENV['USERNAME'])
  end

  def records(offset)
    @me.playlists({'limit': 50, 'offset': offset}).map do |p|
      puts "playlist: #{p.name}\n\n"
      p.tracks.map do |t|
        puts "track: #{t.name}"
        t.artists.map { |a| puts "artist: #{a.name}" }
        puts "album: #{t.album.name}\n\n"
      end
      puts "_______________________"
    end
  end
end

librarian = Archive.new

librarian.records(0)
librarian.records(50)
