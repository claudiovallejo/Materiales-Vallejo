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
      proxy "/careers/#{ I18n.transliterate(job.title).downcase.strip.gsub(' ', '-') }/index.html", "/careers/detail.html", :locals => { :job => job }, :ignore => true
      proxy "/careers/#{ I18n.transliterate(job.title).downcase.strip.gsub(' ', '-') }/application/index.html", "/careers/application.html", :locals => { :job => job }, :ignore => true
    end
  else
    ignore "/careers/index.html"
    ignore "/careers/application.html"
    ignore "/careers/detail.html"
    ignore "/application-received.html"
  end
end
