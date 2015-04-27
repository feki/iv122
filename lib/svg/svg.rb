require 'rexml/document'

include REXML

module Svg
  # Svg class represent svg element, which holds svg's elements.
  class Svg

    attr_reader :shapes

    # Svg class initialize
    #
    # ==== Arguments
    #
    # You may set up svg properties:
    #
    # * +:width+ - A width of svg element, if it is not present default value 250 is used
    # * +:height+ - A height of svg element, if it is not present default value 250 is used
    #
    # ==== Example
    #
    #   svg = Svg.new { :width => 100, :height => 100 } # svg with width and heigth of value 100
    def initialize(args)
      @width = args[:width] || 250
      @height = args[:height] || 250
      @shapes = []
    end

    def doc
      xml_doc = Document.new

      s = @shapes.min_by { |shape| shape.min_xy[0] }
      if s.min_xy[0] <= 0
        tx = s.min_xy[0].abs + 1
        @shapes.each { |shape| shape.translate_xy(tx, 0) }
      end

      s = @shapes.min_by { |shape| shape.min_xy[1] }
      if s.min_xy[1] <= 0
        ty = s.min_xy[1].abs + 1
        @shapes.each { |shape| shape.translate_xy(0, ty) }
      end

      resize_svg()

      root_element = Element.new 'svg'
      root_element.add_attributes({ 'width' => @width, 'height' => @height })

      @shapes.each { |shape| root_element << shape.el }

      xml_doc.add_element root_element
      xml_doc << XMLDecl.new

      xml_doc
    end

    def resize_svg
      sx = @shapes.max_by { |shape| shape.max_xy[0] }
      sy = @shapes.max_by { |shape| shape.max_xy[1] }

      @width = sx.max_xy[0] + 1
      @height = sy.max_xy[1] + 1
    end

    def add_shape(shape)
      @shapes << shape
    end
  end
end
