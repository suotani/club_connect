class Inquiry < ApplicationRecord
  enum status: {
    no_read: 1,
    result: 2,
    pending: 3,
    resulting: 4
  }
end
