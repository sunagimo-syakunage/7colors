require 'minitest/autorun'
require 'dxruby'
require_relative '../rb/character.rb'
require_relative '../rb/anime.rb'



class AnimeTest < Minitest::Test

  def setup
    @testkun = Character.new(name: 'test', jp_name: 'テスト君1号', hp: 20, strength: 1, element: 'nomal')
    @testenemy = Enemy.new(name: 'testenemy', jp_name: 'テストエネミー', hp: 20, strength: 1, exp: 10)
    @player_anime = CharacterAnime.new(character: @testkun, color: 'white', x: Window.width / 4 - 40 / 2, y: Window.width * 2.0 / 5 - 40)
    @enemy_anime = CharacterAnime.new(character: @testenemy, color: 'red', x: Window.width * 3 / 4 - 40, y: Window.width * 2.0 / 5 - 40)
  end

  def test_to_anime
    assert_equal @player_anime.attack_anime(@enemy_anime, 10), 'end'
    assert_equal @enemy_anime.color,{h:0,l:100,s:75}

  end
end
