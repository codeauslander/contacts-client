class Contact
  attr_accessor :id, :first_name, :middle_name, :last_name, :email, :phone_number, :full_name, :bio, :updated_at
  def initialize(input_options)
    @id = input_options["id"]
    @first_name = input_options["first_name"]
    @middle_name = input_options["middle_name"]
    @last_name = input_options["last_name"]
    @email = input_options["email"]
    @phone_number = input_options["phone_number"]
    @full_name = input_options["full_name"]
    @bio = input_options["bio"]
    @updated_at = input_options["updated_at"]
  end
end