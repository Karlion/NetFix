require 'date'


class Numeric
  def percent_of(n)
    self.to_f / n.to_f * 100.0
  end
end

module CalculationService
	class << self
		def calculate_income (money, rate, date, term, period, capitalization)
			if capitalization == "None"
				without_capitalization(money, rate, date, term, period)
			else
				with_capitalization(money, rate, date, term, period, capitalization)
			end	
		end

		def validate (data)
			new_hash = Hash.new
			cap_array = ["None", "Monthly", "Quarterly", "Annually"]
			if data.key?("money")
				money = data["money"].to_f
				if money >= 100
					new_hash[:money] = money
				end
			end
			if data.key?("rate")
				rate = data["rate"].to_f
				if rate >= 0 && rate <= 100
					new_hash[:rate] = rate
				end
			end
			if data.key?("date")
				y, m, d = data["date"].split '-'
				if Date.valid_date? y.to_i, m.to_i, d.to_i
					new_hash[:date] = Date.new(y.to_i, m.to_i, d.to_i)
				end
			end
			if data.key?("term")
				term = data["term"]
				if term == "Month" || term == "Year"
					new_hash[:term] = term
				end
			end
			if data.key?("period")
				period = data["period"].to_i
				if period >= 1
					new_hash[:period] = period
				end
			end
			if data.key?("capitalization")
				capitalization = data["capitalization"]
				if cap_array.include?(capitalization)
					new_hash[:capitalization] = capitalization
				end
			end
			print new_hash
			new_hash
		end	
		def without_capitalization(money, rate, date, term, period)
			period *= 12 if term == "Year"
			endDate = date >> period
			result = (money + (rate.percent_of(money)*(endDate - date).to_i)/365).round(2)
		end	

		def with_capitalization(money, rate, date, term, period, capitalization)
			capitalization = 1 if capitalization == "Monthly"
			capitalization = 4 if capitalization == "Quarterly"
			capitalization = 12 if capitalization == "Annually"
			period *= 12 if term == "Year"
			result = (money * (1 + (rate/100).to_f*(capitalization*30).to_i/365)**(period/capitalization)).round(2)
		end

		private :with_capitalization, :without_capitalization
	end	
end
