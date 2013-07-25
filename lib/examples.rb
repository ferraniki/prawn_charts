require_relative "prawn_charts"

# linear example
#input_data = [["Jan 11", 5], ["Feb 11", 77], ["Mar 11", 99], ["Apr 11", 105], ["May 11", 32], ["Jun 11", 1], ["Jul 11", 20]]
#graph_height_pdf = 200
#graph_width_pdf = 300
#dot_radius = 4

#pdf = ::Prawn::Document.new
#pdf.bounding_box([0, pdf.cursor], :width => graph_width_pdf, :height => graph_height_pdf) do
  #pdf.stroke_bounds
  #CreatePdfDocument.new(pdf, input_data, graph_width_pdf, graph_height_pdf, dot_radius).run
#end
#pdf.render_file(Dir.home + "/desktop/linear_prawn_graph.pdf")



# log example
input_data = [["Jan 11", 5], ["Feb 11", 900], ["Mar 11", 800_000], ["Apr 11", 55], ["May 11", 9_000_000], ["June 11", 40]]
scale = :log
graph_height_pdf = 400
graph_width_pdf = 400
dot_radius = 4
y_labels = [0, 10, 100, 1_000, 10_000, 100_000, 1_000_000, 10_000_000]
x_label_options = { vertical_offset: 25, label_width: 50 }

pdf = Prawn::Document.new
pdf.bounding_box([0, pdf.cursor], :width => graph_width_pdf, :height => graph_height_pdf) do
  pdf.stroke_bounds
  CreatePdfDocument.new(pdf, scale, input_data, graph_width_pdf, graph_height_pdf, dot_radius, y_labels, x_label_options).run
end
pdf.render_file(Dir.home + "/desktop/log_prawn_graph.pdf")
