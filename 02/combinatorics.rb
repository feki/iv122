module Combinatorics
  class Combinatorics
    class << self

      #
      # Generátor kombinácii,
      # defaultne bez opakovania, ale i s opakovaním (podľa príznaku repetition).
      #
      def combinations(items, k, repetition=false)
        res = []
        
        if items.count > 0
          if k == 1
            items.each { |i| res << [i] }
          else
            com = items[0..-1]
            item = repetition ? com.first : com.shift

            Combinatorics.combinations(com, k-1, repetition).each do |com_item|
              res << [item].concat(com_item)
            end
            res.concat Combinatorics.combinations(items[1..-1], k, repetition)
          end
        end

        res
      end

      #
      # Generátor kombinácii s opakovaním.
      #
      def combinations_with_repetition(items, k)
        Combinatorics.combinations(items, k, true)
      end

      #
      # Generátor variacii,
      # defaultne bez opakovania, ale i s opakovaním (podlľa príznaku repetition).
      #
      def variations(items, k, repetition=false)
        res = []
        
        if k == 1
          items.each { |i| res << [i] }
        else
          items.each do |item|
            var = items[0..-1]
            var.delete item unless repetition

            Combinatorics.variations(var, k-1, repetition).each do |per_item|
              res << [item].concat(per_item)
            end
          end
        end

        res
      end

      #
      # Generátor variacii s opakovaním.
      #
      def variations_with_repetition(items, k)
        Combinatorics.variations(items, k, true)
      end

      #
      # Generátor permutácii.
      #
      def permutations(items)
        Combinatorics.variations(items, items.count)
      end
    end    
  end  
end