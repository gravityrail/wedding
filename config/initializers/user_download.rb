# this renderer allows the system to render progressively generated content
# rendering a proc was removed in Rails 3.0
ActionController::Renderers.add :csv do |csv_report, options|
  filename = csv_report.to_filename
  
  headers['Cache-Control']             = 'must-revalidate, post-check=0, pre-check=0'
  headers['Content-Disposition']       = "attachment; filename=#{filename}"
  headers['Content-Type']              = 'text/csv'
  headers['Content-Transfer-Encoding'] = 'binary'
  
  self.response_body  = csv_report
end