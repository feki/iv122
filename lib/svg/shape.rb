require 'rexml/document'

module Svg
  # Base class for svg shapes
  class Shape
    # Svg shape's attributes
    attr_reader :attributes

    # Svg shape element's name
    attr_reader :name

    # ==== Arguments
    #
    # Passes svg shape's properties using +args+ ruby hash:
    #
    # * +:stroke+ - shape stroke color, default color is "black"
    # * +:swidth+ - shape stroke width, default width is 1
    # * +:sopacity+ - shape stroke opacity, value within 0..1
    # * +:opacity+ - opacity of whole shape, value within 0..1
    # * +:fill+ - shape fill color
    # * +:fopacity+ - shape fill opacity, value within 0..1
    # * +:style+ - css style string
    def initialize(name, args = {})
      @name = name

      @attributes ||= { 'stroke' => 'black', 'stroke-width' => 1 }
      args.each_pair { |key, value| @attributes[args_to_attributes(key)] = value }
    end

    # It generates xml element of svg shape and returns it. It generates element only once.
    def el
      svg_el = REXML::Element.new @name
      svg_el.add_attributes @attributes
      svg_el
    end

    def args_to_attributes(key)
      case key
      when :swidth
        'stroke-width'
      when :sopacity
        'stroke-opacity'
      when :fopacity
        'fill-opacity'
      else
        key.to_s
      end
    end

    protected :args_to_attributes
  end
end
