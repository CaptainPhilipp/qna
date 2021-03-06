ThinkingSphinx::Index.define :comment, delta: true, with: :active_record do
  indexes body
  indexes user.email, as: :author_email, sortable: true

  has user_id, created_at, updated_at
end
