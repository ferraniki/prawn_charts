class HorizontalLinesDataCollector
  attr_reader :graph_height_pdf, :y_labels
  def initialize(graph_height_pdf, y_labels)
    @graph_height_pdf = graph_height_pdf
    @y_labels = y_labels
  end

  def y_label_increment
    graph_height_pdf.to_f / (y_labels.count - 1)
  end

  def collect
    y_labels.map.with_index do |_, index|
      [0, graph_height_pdf, index * y_label_increment]
    end
  end

  private

  def y_pdf_data
    if scale == :linear
      LinearYPdfDataCollector.new(input_data, graph_height_pdf, y_labels).collect
    elsif scale == :log
      LogYPdfDataCollector.new(input_data, graph_height_pdf, y_labels).collect
    else
      raise("Scale must be :linear or :log")
    end
  end
end
