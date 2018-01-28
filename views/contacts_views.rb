require 'tty-table'
module ContactsViews
  SPACE = 40
  LINE = "-" * SPACE
  EQUALS = "=" * SPACE
  def contacts_show_view(contact)
    puts LINE
    puts "#{contact.id} #{contact.full_name} #{contact.middle_name}"
    puts "#{contact.email} #{contact.phone_number}"
    puts "#{contact.bio}"
    puts LINE
  end
  def contacts_index_view(contacts)
    puts "Contacts table ... "
    table_rows = []
    contacts.each do |contact|
      table_rows << [contact.id,contact.first_name,contact.middle_name,contact.last_name,contact.email,contact.phone_number,contact.bio]
    end
    table = TTY::Table.new header: ['Id','First name','Middle name','Last name','Email','Phone number','Bio'], rows: table_rows
    renderer = TTY::Table::Renderer::Unicode.new(table)
    puts renderer.render    
  end
  def contacts_search_view(contacts)
    puts "... Contacts found ..."
    contacts_index_view(contacts)
  end
  def contacts_sort_view(contacts)
    puts "... Contacts sort ..."
    contacts_index_view(contacts)
  end
  def contacts_create_view(contact)
    puts "... Contact succesfully created ..."
    contacts_show_view(contact)
  end
  def contacts_update_view(contact)
    puts "... Contact succesfully updated ..."
    contacts_show_view(contact)
  end
  def contacts_destroy_view(message)
    puts message
  end
end