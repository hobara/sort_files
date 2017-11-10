# Take 3 different forms of data and return the sorted output in 3 different ways.
# Parse the date entries and store it either in Array or Hash, with the last_name order.
# Output1: sort by the gender.
# Output2: sort by the birth date.
# Output3: sort by the last name by descending.
 
class CustomerList  
  
  def initialize(file1, file2, file3)
    @data = File.readlines(file1) + File.readlines(file2) + File.readlines(file3)
    @list_arr = []
  end
  
  def process_data
    @data.each do |entry|
      if entry.include?(" | ")
        arr = entry.split(" | ")
        last_name, first_name, fav_color = arr[0], arr[1], arr[4]
        gender = arr[3] == "M" ? "Male" : "Female"
        birth_date = arr[5].split("-").join("/")
        birth_date.slice!("\n")
      elsif entry.include?(", ")
        arr = entry.split(", ")
        last_name, first_name, gender, fav_color = arr[0], arr[1], arr[2], arr[3]
        arr[4].slice!("\n")
        birth_date = arr[4]
      else
        arr = entry.split(" ")
        last_name, first_name, fav_color = arr[0], arr[1], arr[5]
        gender = arr[3] == "M" ? "Male" : "Female"
        birth_date = arr[4].split("-").join("/")
        birth_date.slice!("\n")
      end      
      @list_arr << {
        last_name: last_name,
        first_name: first_name,
        gender: gender,
        birth_date: birth_date,
        fav_color: fav_color
      }
    end
    @list_arr = @list_arr.sort_by { |el| el[:last_name] }
  end
  
  def sort_by_gender
    output1 = []
    @list_arr.select { |el| el[:gender] == "Female" }.each do |entry|
      output1 << entry.values.join(" ").concat("\n")
    end
    @list_arr.select { |el| el[:gender] == "Male" }.each do |entry|
      output1 << entry.values.join(" ").concat("\n")
    end
    puts output1
  end
  
  def sort_by_birth_date
    output2 = []
    res = @list_arr.sort_by { |el| el[:birth_date].split("/").reverse.join("/") }
    res.each do |entry|
      output2 << entry.values.join(" ").concat("\n")
    end
    puts output2
  end
  
  def sort_by_last_name
    output3 = []
    @list_arr.reverse.each do |entry|
      output3 << entry.values.join(" ").concat("\n")
    end
    puts output3
  end
  
end 

sample = CustomerList.new("./pipe_delimited.txt", "./comma_delimited.txt", "./space_delimited.txt")
sample.process_data
puts "\nOutput1: Sorted by Gender -----------"
sample.sort_by_gender
puts "\nOutput2: Sorted by Birth Date -------"
sample.sort_by_birth_date
puts "\nOutput3: Sorted by Last Name --------"
sample.sort_by_last_name
