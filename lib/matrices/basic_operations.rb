module BasicOperations
  def multiplication(m1, m2)
    raise ArgumentError, 'Number of columns of first matrix is not equal to number of rows of second matrix' if m1[0].count != m2.count

    res_matrix = []
    m1.count.times do |m1_row_index|
      m1_row = m1[m1_row_index]

      res_row = []
      m2[0].count.times do |k|
        sum = 0
        m1_row.count.times { |i| sum += m1_row[i]*m2[i][k] }
        res_row << sum
      end

      res_matrix << res_row
    end

    res_matrix
  end

  module_function :multiplication
end