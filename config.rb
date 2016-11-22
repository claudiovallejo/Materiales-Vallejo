###
# General
###

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

# Pages with no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# Activate directory indexes
activate :directory_indexes

###
# Proxies
###

# Dynamic Jobs Index + Detail
#
$jobs = 0
data.jobs.list.each do |job|
  if job.is_published
    $jobs += 1
  end
end

data.jobs.list.each do |job|
  if $jobs > 0
    if job.is_published
      proxy "/empleos/#{ I18n.transliterate(job.title).downcase.strip.gsub(' ', '-') }/index.html", "/empleos/detail.html", :locals => { :job => job }, :ignore => true
      proxy "/empleos/#{ I18n.transliterate(job.title).downcase.strip.gsub(' ', '-') }/aplicacion/index.html", "/empleos/application.html", :locals => { :job => job }, :ignore => true
    end
  else
    ignore "/empleos/index.html"
    ignore "/empleos/application.html"
    ignore "/empleos/detail.html"
    ignore "/aplicacion-enviada.html"
  end
end
