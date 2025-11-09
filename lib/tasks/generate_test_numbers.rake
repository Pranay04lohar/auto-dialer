namespace :test_numbers do
  desc "Generate 100 test phone numbers"
  task generate: :environment do
    numbers = TestNumberGenerator.generate(100)
    
    puts "Generated 100 test numbers:"
    puts "=" * 50
    numbers.each_with_index do |number, index|
      puts "#{index + 1}. #{number}"
    end
    puts "=" * 50
    puts "\nCopy these numbers and paste in the bulk upload section!"
  end
end



