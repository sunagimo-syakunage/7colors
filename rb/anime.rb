class Anime
  def self.damege_color_calc(attacker, defender, fill)
    defender.color[:l] = if attacker.ini_color[:l] > defender.ini_color[:l]
                           defender.ini_color[:l] + (fill * 50).round
                         else
                           defender.ini_color[:l] - (fill * 50).round
                         end
    defender.color
  end

  def self.anime_move_x(before_x:, after_x:, move_speed:)
    before_x = if before_x < after_x
                 anime_move_right(before_x: before_x, after_x: after_x, move_speed: move_speed)
               elsif before_x > after_x
                 anime_move_left(before_x: before_x, after_x: after_x, move_speed: move_speed)
               else
                 before_x
  end
  end

  def self.anime_move_right(before_x:, after_x:, move_speed:)
    before_x += move_speed if before_x < after_x
    before_x = after_x if before_x >= after_x
    before_x
  end

  def self.anime_move_left(before_x:, after_x:, move_speed:)
    before_x -= move_speed if before_x > after_x
    before_x = after_x if before_x <= after_x
    before_x
  end

end

module Colors
  COLORLIST = { white: { hsl: { h: 0, s: 100, l: 100 }, rgb: [255, 255, 255] },
                red: { hsl: { h: 0, s: 100, l: 50 }, rgb: [255, 0, 0] } }.freeze
end

class CharacterAnime
  attr_accessor :sprite, :color, :x, :y, :rot_speed, :move_speed
  attr_reader :ini_color

  def initialize(character:, color:, x:, y:, move_speed: 3, rot_speed: 5)
    @character = character
    @color = Colors::COLORLIST[color.to_sym][:hsl].clone
    @ini_color = Colors::COLORLIST[color.to_sym][:hsl].clone
    img = Image.new(80, 80, Colors::COLORLIST[color.to_sym][:rgb])
    @sprite = Sprite.new(x, y, img)
    @x = x - img.width / 2
    @y = y - img.height / 2
    @ini_x = x - img.width / 2
    @ini_y = y - img.height / 2
    @rotation = 0
    @move_speed = move_speed
    @ini_move_speed = move_speed
    @rot_speed = rot_speed
    @ini_rot_speed = rot_speed
  end

  def ran
    @rotation += @rot_speed
    @rotation -= 360 if @rotation >= 360
    @sprite.draw
    @sprite.angle = @rotation
    @sprite.x = @x
    @sprite.y = @y
  end

  def move_x(after_x)
    @x = Anime.anime_move_x(before_x: @x, after_x: after_x, move_speed: @move_speed)
  end

  def attack_anime(defender, damege, anime_start = @ini_x)
    @attack_scene ||= 'ini'
    case @attack_scene
    when 'ini'
      @rot_add = 2.0 / (@x - defender.x).abs * 60
      @move_add = 1.0 / (@x - defender.x).abs * 30
      @attack_scene = 'start'
    when 'start'
      move_x(defender.x)
      @rot_speed += @rot_add
      @move_speed += @move_add
      @attack_scene = 'turn' if @sprite === defender.sprite
    when 'turn'
      move_x(anime_start)
      @attack_scene = 'end' if @x == anime_start
      @rot_speed -= @rot_add if @rot_speed > @ini_rot_speed
      @move_speed -= @move_add if @move_speed > @ini_move_speed
    when 'end'
      @rot_speed = @ini_rot_speed
      @x = anime_start
    end
    if @attack_scene == 'turn' || @attack_scene == 'end'
      if defender.damege_anime(self, damege) == 'end' && @attack_scene == 'end'
        @attack_scene = 'ini'
        'end'
      end
    end
  end

  def damege_anime(attacker, damege)
    @damege_move ||= 'start'
    case @damege_move
    when 'start'
      @rot_speed = -attacker.rot_speed / 1.3
      @damege_x = attacker.x < @x ? @x + attacker.move_speed * attacker.rot_speed / 2 : @x - attacker.move_speed * attacker.rot_speed / 2
      @damege_rot_add = 1.0 * @ini_rot_speed / (@ini_rot_speed - @rot_speed).abs
      @damege_max_hp = 1.0 * damege / @character.max_hp
      @damege_hp = 1 - (1.0 * @character.hp / @character.max_hp)
      @damege_move = 'run'
    when 'run'
      @damege_move = 'turn' if @x == @damege_x && @rot_speed > -@ini_rot_speed * 2
      move_x(@damege_x)
    when 'turn'
      @damege_move = 'end' if @damege_hp >= @damege_max_hp && @rot_speed >= @ini_rot_speed && @x == @ini_x
      move_x(@ini_x) if @x != @ini_x
    when 'end'
      @damege_move = 'start'
      return 'end'
    end
    @damege_hp = color_move(attacker, before: @damege_hp, after: @damege_max_hp)
    rot_speed_move(@damege_rot_add)
  end

  # color_moveは呼び出し側で
  # before = color_move(attacker, before, after)
  # みたいに書かないとうまく動きません
  def color_move(attacker, before:, after:)
    before += after / 80 if before < after
    @sprite.image.fill(Color.hsl2rgb(Anime.damege_color_calc(attacker, self, before)))
    before
  end

  def rot_speed_move(one, after: @ini_rot_speed)
    if @rot_speed < after && @rot_speed > -after
      @rot_speed += one * 2
    elsif @rot_speed < after && @rot_speed > -after * 2
      @rot_speed += one
    elsif @rot_speed < after
      @rot_speed += one / 3
    else
      @rot_speed = after
    end
   end
end
