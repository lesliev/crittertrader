class Critter < ActiveRecord::Base
  #TODO: validation to determine if valid critter
  # so we can't just upload and download warez

  validate :critter_data_is_valid

  def critter_data_is_valid
    return if data.blank?

    neurons = 0
    clines = 0
    other_lines = 0

    max_neuron_length = 0
    max_other_length = 0
    max_cline_length = 0
    adamdist = false

    data.split("\n").each do |line|
      if line.start_with?('n(i=')
        neurons += 1
        max_neuron_length = line.length if line.length > max_neuron_length
      elsif line =~ /^c \d+/ || line =~ /^cm \d+/
        clines += 1
        max_cline_length = line.length if line.length > max_cline_length
      else
        other_lines += 1
        adamdist = true if line =~ /^adamdist/
        max_other_length = line.length if line.length > max_other_length
      end
    end

    errors.add(:data, 'may not have more than 1000 neurons') if neurons > 1000
    errors.add(:data, 'may not have more than 4000 characters per neuron') if max_neuron_length > 4000
    errors.add(:data, 'may not have more than 200 characters per "c" line') if max_cline_length > 200
    errors.add(:data, 'may not have more than 100 characters on config lines') if max_other_length > 100
    errors.add(:data, 'must have an adamdist') if !adamdist
    errors.add(:data, 'may not have more than 10 "c" lines') if clines > 10
    errors.add(:data, 'may not have more than 80 config lines') if other_lines > 80
  end
end
