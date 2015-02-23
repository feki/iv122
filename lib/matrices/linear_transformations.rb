require File.join(File.dirname(__FILE__), 'basic_operations')

module LinearTransformations
  def translation(tx, ty)
    [
      [ 1.0, 0.0,  tx ],
      [ 0.0, 1.0,  ty ],
      [ 0.0, 0.0, 1.0 ]
    ]
  end

  def reflection
    [
      [ -1.0, 0.0, 0.0 ],
      [  0.0, 1.0, 0.0 ],
      [  0.0, 0.0, 1.0 ]
    ]
  end

  def scaling(sx, sy)
    [
      [  sx, 0.0, 0.0 ],
      [ 0.0,  sy, 0.0 ],
      [ 0.0, 0.0, 1.0 ]
    ]
  end

  def rotation(angle)
    alfa = 2*Math::PI*(angle/360.0)
    cosa = Math.cos(alfa)
    sina = Math.sin(alfa)

    [
      [ cosa, -sina, 0.0 ],
      [ sina,  cosa, 0.0 ],
      [  0.0,   0.0, 1.0 ]
    ]
  end

  def shear(k)
    [
      [ 1.0,   k, 0.0 ],
      [ 0.0, 1.0, 0.0 ],
      [ 0.0, 0.0, 1.0 ]
    ]
  end

  # @param [Array] transformations
  # @return [Array]
  def combine(transformations)
    res = transformations[0]
    if transformations.count > 1
      res = transformations[1..-1].inject(res) { |mem, tran| BasicOperations.multiplication(mem, tran) }
    end
    res
  end

  module_function :translation, :reflection, :scaling, :rotation, :shear, :combine
end