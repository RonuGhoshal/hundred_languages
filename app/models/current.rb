class Current < ActiveSupport::CurrentAttributes
  attribute :session
  delegate :teacher, to: :session, allow_nil: true
end
