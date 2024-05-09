class Form::Collection < Form::Base
    attr_accessor :drugs, :take_times

    def initialize(attributes = {})
    super attributes
    self.drugs = [] unless drugs.present?
    self.take_times = [] unless take_times.present?
  end

  def drugs_attributes=(attributes)
    self.drugs = attributes.map { |_, v| Drug.new(v) }
   end
 
   def take_times_attributes=(attributes)
    self.take_time = attributes.map { |_, v| TakeTime.new(v) }
   end
end




