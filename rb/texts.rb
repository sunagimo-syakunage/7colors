class Texts
  def self.output(str)
    puts str
  end
end

class BattleText <Texts

  def self.battle_result_text(flg)
    str=[]
    case flg
    when 'win'
      str << "戦闘に勝利した"
    when 'lose'
      str << "戦闘に敗北した"
    when 'escape'
    end
    output(str.join)
    str.join
  end

  def self.skill_text(attacker, defender, attacker_skill)
    case attacker_skill[:select_skill][:skill_type]
    when 'damege'
      damege_skill_text(attacker, defender, attacker_skill)
    when 'heal'
      # 回復スキル用の処理
    end
  end

  def self.damege_skill_text(attacker, defender, attacker_skill)
    str = []
    str << "#{attacker.jp_name}の#{attacker_skill[:select_skill][:jp_name]}\n"
    # は防御した
    str << "#{defender.jp_name}は#{attacker_skill[:damege]}ダメージを受けた"
    output(str.join)
    str.join
  end
end
