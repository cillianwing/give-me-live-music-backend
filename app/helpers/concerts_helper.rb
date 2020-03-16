module ConcertsHelper

  def concert_after_today
    if Date.parse(date) < Date.today
      errors.add(:date, "of concert cannot be before today")
    end
  end

end
