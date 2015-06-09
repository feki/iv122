require_relative '../lib/matrices/linear_transformations'

module LinearTransformations
  class Mrcm
    attr_accessor :transformations

    def initialize(transformations_list)
      @transformations = transformations_list
    end

    def compute(segments, repeat, skip=0)
      res = segments
      repeat.times do
        res = @transformations.reduce([]) do |mem, t|
          mem += translate_segments(res, t); mem
        end
      end

      res
    end
  end
end