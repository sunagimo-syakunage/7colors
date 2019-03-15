class Battle
  def self.battle_run(player, stage, encount_value: rand(100))
    enemy = EnemyEncount.encount(stage, encount_value)
    BattleResult.battle_result(player, enemy, Fight.fighting(player, enemy))
 end
end

class EnemyEncount
  def self.encount(stage, encount_value)
    enemy = EncountList::ENCOUNT_LIST[stage.to_sym].find { |i| i[:encount_rate].include?(encount_value) }
    enemy[:enemy_instance]
  end
end

module Turn
  def self.enemy_turn(player, enemy)
            Skill.use_skill(enemy, player, 'atk')
  end

  def self.player_turn(player, enemy)
    loop do
    player_act_select = 'atk'
    if player_act_select
      player_skill = Skill.use_skill(player, enemy, player_act_select)
      BattleText.damege_skill_text(player, enemy, player_skill)
      
      player_act_select = false
      break
    end
    end
  end
end


class Fight
  def self.fighting(player, enemy)
    fight_scene = 'player'
    loop do
      case fight_scene
      when 'player'
        # 表示テキストをなくしてボタンとかメニューにする処理
        # 入力待ち
        Turn.player_turn(player, enemy)
        return 'win' if enemy.hp <= 0
        fight_scene = 'enemy'
      when 'enemy'
        Turn.enemy_turn(player, enemy)
        return 'lose' if player.hp <= 0
        fight_scene = 'player'
      end
    end
  end
end

class BattleResult
  def self.battle_result(player, enemy, flg)
    case flg
    when 'win'
      player.exp += enemy.exp
    when 'lose'
      player.hp = player.max_hp
    when 'escape'
    end
    enemy.hp = enemy.ini_hp
    BattleText.battle_result_text(flg)
  end
end
