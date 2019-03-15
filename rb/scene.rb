class GameScene
  def self.display
    scene = 'title'
    loop do
      case scene
      when 'title'
        scene = 'home' if Input.mousePush?(M_LBUTTON)
      when 'home'
        scene = 'battle' if Input.mousePush?(M_LBUTTON)
      when 'battle'
    end
    end
  end
end
