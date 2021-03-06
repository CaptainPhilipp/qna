ThinkingSphinx::Index.define :question, delta: true, with: :active_record do
  indexes title, sortable: true
  indexes body
  indexes user.email, as: :author_email, sortable: true

  has user_id, created_at, updated_at
end
