class UI < Sprite
end
# カーソルはスプライトじゃなくて範囲でしたほうがいいのでは

class Images
  @@player_img = Image.new(128, 128, [0, 0, 0, 0]).circle_fill(64, 64, 64, [255, 255, 255])
end

class WindowSetting
  def self.window_size_preset(mode: 'svga')
    case mode
    when 'svga'
      window_size(width: 800, height: 600)
    when 'max'
      window_max_size = Window.get_screen_modes.max
      window_size(width: window_max_size[0], height: window_max_size[1])
    end
  end

  def self.window_size(width:, height:, full_screen_mode: false, bgcolor: [180, 180, 180])
    Window.width = width
    Window.height = height
    Window.full_screen = full_screen_mode
    Window.bgcolor = bgcolor
  end
end
