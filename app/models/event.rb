class Event < ApplicationRecord
  acts_as_list scope: [:parent_id, :type]
end
