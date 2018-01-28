require 'unirest'
require 'paint'
require_relative 'controllers/contacts_controller'
require_relative 'views/contacts_views'
require_relative 'models/contact'

class Frontend
  include ContactsController
  include ContactsViews
  def run
    running = true
    while running == true
      puts "Choose an option
        [a] Show first contact (query url)
        [b] Show all contacts (query url)

        [1] Display all contacts (rest, get index)
          [1.1] Search by first_name
          [1.2] Sort contacts by last_name
        [2] Create a contact (rest, post create)
        [3] Show a contact (rest, get show)
        [4] Update a contact (rest, update contact)
        [5] Delete a contact (rest, destroy contact)
        [ ] Everything else bye"
      input_option = gets.chomp
      case input_option
      when "a"
        contacts_one_contact_action
      when "b"
        contacts_all_contacts_action
      when "1"
        contacts_index_action
      when "1.1"
        contacts_search_action
      when "1.2"
        contacts_sort_action
      when "2"
        contacts_create_action
      when "3"
        contacts_show_action
      when "4"
        contacts_update_action
      when "5"
        contacts_destroy_action
      else
        system 'clear'
        break
      end
      print "Hit enter to continuo or q to Quit: "
      input_option = gets.chomp
      if input_option == "q"
        system 'clear'
        running = false
      end
    end 
   end
end 