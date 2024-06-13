module CalendarsHelper
    def drug_status(day, drug)
      total_checks = MedicationCheck.where(drug: drug, check_time: day).count
      completed_checks = MedicationCheck.where(drug: drug, check_time: day, check: true).count
      
      if completed_checks == total_checks && total_checks > 0
        'green'
      elsif completed_checks > 0
        'yellow'
      else
        'gray'
      end
    end
  end