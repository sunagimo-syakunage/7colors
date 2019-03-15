# require 'dxopal'
# include DXOpal
# require_remote './rb/skill.rb'
# require_remote './rb/character.rb'
# require_remote './rb/battle.rb'
# require_remote './rb/texts.rb'
# require_remote './rb/ui.rb'
# require_remote './rb/scene.rb'
require 'dxruby'
require_relative './rb/skill.rb'
require_relative './rb/character.rb'
require_relative './rb/battle.rb'
require_relative './rb/texts.rb'
require_relative './rb/ui.rb'
require_relative './rb/scene.rb'
require_relative './rb/color.rb'
require_relative './rb/anime.rb'

WindowSetting.window_size_preset
@testkun = Character.new(name: 'test', jp_name: 'テスト君1号', hp: 20, strength: 1, element: 'nomal')
@testenemy = Enemy.new(name: 'testenemy', jp_name: 'テストエネミー', hp: 20, strength: 1, exp: 10)
player_anime = CharacterAnime.new(character: @testkun, color: 'white', x: Window.width / 4 , y: Window.height / 2 )
enemy_anime = CharacterAnime.new(character: @testenemy, color: 'red', x: Window.width * 3 / 4 , y: Window.height / 2 )
anime = 'stand_by'
hp = 50
Window.loop do
  case anime
  when 'stand_by'
    anime = 'attack' if Input.mousePush?(M_LBUTTON)
  when 'attack'
    @testenemy.hp = 20
    anime = 'attack2' if player_anime.attack_anime(enemy_anime, 5) == 'end'
  when 'attack2'
    @testenemy.hp = 15
    anime = 'nyan' if player_anime.attack_anime(enemy_anime, 10) == 'end'
    # enemy_anime.damege_anime(5)
    # enemy_anime.move_x(500)
  when 'nyan'
    @testkun.hp = 20
    anime = 'wan' if enemy_anime.attack_anime(player_anime, 5) == 'end'
  when 'wan'
    @testkun.hp = 15
    anime = 'stand_by' if enemy_anime.attack_anime(player_anime, 10) == 'end'
    # enemy_anime.move_x(400)
  end
  player_anime.ran
  enemy_anime.ran
end
