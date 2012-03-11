# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'cucumber' do
  watch('^features/(.*).feature')
  watch('^features/support')                       { 'features' }
  watch('^features/step_definitions')              { 'features' }
end
