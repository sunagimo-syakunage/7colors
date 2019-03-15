class Color
  def self.hsl2rgb(hsl)
    hsl[:h] = 0 if hsl[:h] == 360

    if hsl[:l] < 50
      max = 2.55 * (hsl[:l] + hsl[:l] * (hsl[:s] / 100.0))
      min = 2.55 * (hsl[:l] - hsl[:l] * (hsl[:s] / 100.0))
    else
      max = 2.55 * (hsl[:l] + (100 - hsl[:l]) * (hsl[:s] / 100.0))
      min = 2.55 * (hsl[:l] - (100 - hsl[:l]) * (hsl[:s] / 100.0))
    end

    argb = [255, min, min, min]
    case hsl[:h]
    when 0...60
      argb[1] = max
      argb[2] += (max - min) * (hsl[:h] / 60.0)
    when 60...120
      argb[1] += (max - min) * ((120 - hsl[:h]) / 60.0)
      argb[2] = max
    when 120...180
      argb[2] = max
      argb[3] += (max - min) * ((hsl[:h] - 120) / 60.0)
    when 180...240
      argb[2] += (max - min) * ((240 - hsl[:h]) / 60.0)
      argb[3] = max
    when 240...300
      argb[1] += (max - min) * ((hsl[:h] - 240) / 60.0)
      argb[3] = max
    when 300...360
      argb[1] = max
      argb[3] += (max - min) * ((360 - hsl[:h]) / 60.0)
    end
    argb.each(&:round)
  end
end
