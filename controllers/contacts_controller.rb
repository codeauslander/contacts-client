module ContactsController
  DOMAIN = "http://localhost:3000"

  def contacts_one_contact_action
    url = DOMAIN + "/one_contact_url"    
    puts "This is the first contact"
    response = Unirest.get(url).body
    puts response
  end
  def contacts_all_contacts_action
    url = DOMAIN + "/all_contacts_url"
    puts "All the contacts"
    response = Unirest.get(url).body
    puts response
  end
  def contacts_search_action
    print "Enter first_name to search: "
    search_first_name = gets.chomp
    url = DOMAIN + "/contacts?search_first_name=#{search_first_name}"
    response = Unirest.get(url)
    contacts_hashs = response.body
    contacts = []
    contacts_hashs.each do |contact_hash|
      contacts << Contact.new(contact_hash)
    end
    contacts_search_view(contacts)
  end
  def contacts_sort_action
    print "Sorting by last_name"
    url = DOMAIN + "/contacts?sort_last_name=last_name"
    response = Unirest.get(url)
    contacts_hashs = response.body
    contacts = []
    contacts_hashs.each do |contact_hash|
      contacts << Contact.new(contact_hash)
    end
    contacts_sort_view(contacts)
  end
  def contacts_index_action
    url = DOMAIN + '/contacts'
    response = Unirest.get(url)
    contacts_hashs = response.body
    contacts = []
    contacts_hashs.each do |contact_hash|
      contacts << Contact.new(contact_hash)
    end
    contacts_index_view(contacts)
  end
  def contacts_show_action
    print 'Showing contact with ID: '
    id = gets.chomp
    url = DOMAIN + "/contacts/#{id}"
    response = Unirest.get(url)
    contact_hash = response.body
    contact = Contact.new(contact_hash)
    contacts_show_view(contact)
  end
  def contacts_create_action
    url = DOMAIN + '/contacts'
    puts 'Creating a contact'
    parameters = {}
    print 'first_name: '
    parameters[:first_name] = gets.chomp
    print 'middle_name: '
    parameters[:middle_name] = gets.chomp
    print 'last_name: '
    parameters[:last_name] = gets.chomp
    print 'email: '
    parameters[:email] = gets.chomp
    print 'phone_number: '
    parameters[:phone_number] = gets.chomp
    print 'bio: '
    parameters[:bio] = gets.chomp
    response = Unirest.post(url,parameters:parameters)
    if response.code == 200
      response = Unirest.get(url)
      contacts_hashs = response.body
      contact = Contact.new(contacts_hashs[contacts_hashs.length - 1])
      contacts_create_view(contact)
    else
      errors = response.body["errors"]
      errors.each do |error|
        puts error
      end   
    end
  end
  def contacts_update_action
    print 'Updating contact with ID: '
    id = gets.chomp
    url = DOMAIN + "/contacts/#{id}" 
    contact = Unirest.get(url).body
    parameters = {}
    print "first_name #{contact['first_name']}: "
    parameters[:first_name] = gets.chomp
    print "middle_name #{contact['middle_name']}: "
    parameters[:middle_name] = gets.chomp
    print "last_name #{contact['last_name']}: "
    parameters[:last_name] = gets.chomp
    print "email #{contact['email']}: "
    parameters[:email] = gets.chomp
    print "phone_number #{contact['phone_number']}: "
    parameters[:phone_number] = gets.chomp
    print "bio #{contact['bio']}: "
    parameters[:bio] = gets.chomp

    #deleting null keys, values from the hash parameters
    parameters.delete_if{|key,value|value.empty?}

    response = Unirest.patch(url,parameters:parameters)
    if response.code == 200
      contact_hash = response.body
      contact = Contact.new(contact_hash)
      contacts_update_view(contact)
    else
      errors = response.body["errors"]
      errors.each do |error|
        puts error
      end   
    end
  end
  def contacts_destroy_action
    print 'Destroying contact with ID: '
    id = gets.chomp
    url = DOMAIN + "/contacts/#{id}"
    response = Unirest.delete(url).body
    contacts_destroy_view(response['message'])
  end
end 