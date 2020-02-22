module UsersHelper
  # borrowed from : https://stackoverflow.com/questions/88311/how-to-generate-a-random-string-in-ruby#answer-493230
  def new_verification_code(size = 6)
    charset = %w[2 3 4 6 7 9 A C D E F G H J K M N P Q R T V W X Y Z]
    (0...size).map { charset.to_a[rand(charset.size)] }.join
  end
end