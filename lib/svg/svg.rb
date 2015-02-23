require 'rexml/document'

include REXML

module Svg
  # Svg class represent svg element, which holds svg's elements.
  class Svg
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

      root_element = Element.new 'svg'
      root_element.add_attributes({ 'width' => @width, 'height' => @height })

      @shapes.each { |shape| root_element << shape.el }

      xml_doc.add_element root_element
      xml_doc << XMLDecl.new

      xml_doc
    end

    def add_shape(shape)
      @shapes << shape
    end
  end
end
