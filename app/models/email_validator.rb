class EmailValidator < ActiveModel::EachValidator

  class_attribute :format
  self.format = /\A([\w\.\-]+)@([\w\-]+\.)+([\w]{2,})\z/i


  def validate_each(record, attribute, value)
    return true if value.blank? and options[:allow_blank]
    record.errors.add(attribute,:invalid) unless value =~ self.class.format
    if options[:unique]
      record.errors.add(attribute, :taken) if User.where(email: value).exists?
    end
  end

end
