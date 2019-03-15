class Skill
  # skill_type そのスキルがダメージ系なのか回復系なのかとかの区別
  # スキルリストそのものをダメージスキルリストとかにしてもいいかもね
  # find find とかで
  # name 英語の名前 jp_name 日本語の名前
  # ratio 攻撃倍率
  # element スキルの属性

  SKILL_LIST = [
    { skill_type: 'damege', name: 'atk', jp_name: '攻撃', ratio: 1.0, element: 'nomal' },
    { skill_type: 'damege', name: 'fire_breath', jp_name: 'ファイアブレス', ratio: 1.2, element: 'fire' },
    { skill_type: 'damege', name: 'blizzard', jp_name: 'ブリザード', ratio: 1.2, element: 'ice' }
  ].freeze

  def self.use_skill(attacker, defender, skill_name)
    select_skill = SKILL_LIST.find { |abc| abc[:name] == skill_name }
    case select_skill[:skill_type]
    when 'damege'
      # BattleText.damege_skill_text(attacker, defender, select_skill, damege_skill(attacker, defender, select_skill))
      damege_skill(attacker, defender, select_skill)
    when 'heal'
      # 回復スキル用の処理
    end
  end

  def self.damege_skill(attacker, defender, select_skill)
    # if rand(10) == 1
    #   Damege.calc(attacker, defender, select_skill[:raito]*1.5, select_skill[:element])
    # else
    #   Damege.calc(attacker, defender, select_skill[:raito], select_skill[:element])
    # end
    {damege:Damege.calc(attacker, defender, select_skill[:ratio], select_skill[:element]),select_skill: select_skill}
  end
end

# ダメージ計算とか
class Damege
  # 弱点表
  # forest はまだ作ってないけどこんな感じに入れればできる
  ELEMENT_LIST = [{ use: 'fire', weak: %w[ice forest], resist: ['fire'] },
                  { use: 'ice', weak: ['fire'], resist: ['ice'] }].freeze
  def self.calc(attacker, defender, ratio = 1.0, use = 'nomal')
    damege = attacker.strength * ratio
    use_element = ELEMENT_LIST.find { |abc| abc[:use] == use }
    if use_element && use_element[:weak].include?(defender.element)
      damege *= 1.3
    elsif use_element && use_element[:resist].include?(defender.element)
      damege *= 0.8
    end
    if defender.defence_flg
      damege /= 2
      defender.defence_flg = false
    end
    defender.hp -= damege.round
    damege.round
  end
end
