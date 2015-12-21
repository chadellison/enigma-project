class KeyGenerator
  attr_reader :key, :date, :offset

  def initialize(key = random_number, date = current_date)
    @key = key
    @date = date
  end

  def random_number
    @key = rand(0..99999)
  end

  def current_date
    Time.now.strftime("%d%m%y").to_i
  end

  def date_offset
    if @date.nil?
      @date = current_date
    end
    date_offset = (date ** 2).to_s[-4..-1]
    date_offset.chars.map { |number| number.to_i}
  end

  def initial_key_values
    rotations =[]
    if key.nil?
      random_number
    end
    @key = key.to_s.chars
    rotations << a_key = key[0..1].join
    rotations << b_key = key[1..2].join
    rotations << c_key = key[2..3].join
    rotations << d_key = key[3..4].join
    rotations.map! { |rot| rot.to_i }
  end

  def rotator
    rotator = initial_key_values.zip(date_offset)
    rotator.map do |rot|
      rot.reduce(0, :+)
    end
  end
end
