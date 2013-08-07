require_relative "./../prawn_charts"

module PrawnCharts
  ##################################
  #Graph Data Collectors
  ##################################
  input_data = [["Apr-11", 10],
                ["May-11", 30],
                ["Jun-11", 50],
                ["Jul-11", 3],
                ["Aug-11", 40],
                ["Sep-11", nil],
                ["Oct-11", nil],
                ["Dec-11", 100],
                ["Jan-12", nil],
                ["Feb-12", nil],
                ["Mar-12", 5],
                ["Apr-12", nil],
                ["May-12", nil],
                ["Jun-12", 75]]
  scale = :linear
  graph_height_pdf = 200
  graph_width_pdf = graph_height_pdf * 1.7
  dot_radius = 4

  x_label_width = 50
  x_label_height = 35
  x_label_text_box_options = { overflow: :shrink_to_fit, align: :center, rotate: 45 }

  y_labels = [0, 25, 50, 75, 100, 125]
  y_label_height = 30
  y_label_width = 65
  y_label_offset = 10
  y_label_text_box_options = { align: :right, valign: :center }

  pdf_data = PdfDataCollector.new(scale, input_data, graph_width_pdf, graph_height_pdf, y_labels).collect
  x_label_data = XLabelsDataCollector.new(input_data, graph_width_pdf, x_label_height, x_label_width).collect
  y_label_data = YLabelsDataCollector.new(y_labels, graph_height_pdf, y_label_width, y_label_height, y_label_offset).collect
  horizontal_lines_data = HorizontalLinesDataCollector.new(graph_height_pdf, graph_width_pdf, y_labels).collect

  ##################################
  #Create PDF
  ##################################

  Prawn::Document.extensions << PrawnChartRenderer

  pdf = Prawn::Document.new

  pdf.bounding_box([50, pdf.cursor], :width => graph_width_pdf, :height => graph_height_pdf) do
    pdf.stroke_bounds
    pdf.draw_chart(pdf_data)
    pdf.draw_dots(pdf_data, dot_radius)
    pdf.draw_labels(x_label_data, x_label_width, x_label_height, x_label_text_box_options)
    pdf.draw_labels(y_label_data, y_label_width, y_label_height, y_label_text_box_options)
    pdf.draw_horizontal_lines(horizontal_lines_data)
  end

  pdf.render_file(Dir.home + "/desktop/simple_linear_prawn_graph.pdf")
end
