ThinkingSphinx::Index.define :document, :with => :active_record do
  # fields
  indexes title, :sortable => true
  indexes content
end
