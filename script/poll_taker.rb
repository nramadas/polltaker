module PollTaker
  class Client
    def run
      welcome
      while true
        print_main_menu_options

        case gets.chomp[0]
        when 't'
          take_poll_menu
        when 'v'
          view_poll_menu
        when 'a'
        when 'm'
        when 'j'
        when 'q'
          break
        end
      end
    end

    def welcome
      puts "Welcome to Poll Taker!".center(20, ' ').magenta
      print "Username > "
      username = gets.chomp

      user = User.where(name: username)
      user.any? ? login(user.first) : signup(username)
    end

    def login(user)
      @user = user
    end

    def signup(username)
      puts "User does not exist. Create? (y/n)"
      print "> "
      if gets.chomp[0] == 'y'
        @user = User.make_user(username)
        login(@user)
      else
        goodbye
      end
    end

    def goodbye
      puts "Thanks for using Poll Taker!"
    end

    def print_main_menu_options
      menu_options = [
          "(t)ake a poll",
          "(v)iew polls",
          "(a)dd a poll",
          "(m)ake a team",
          "(j)oin a team",
          "(q)uit"]

      puts
      puts "Main Menu".center(20, ' ').underline.magenta
      menu_options.each do |option|
        puts "\u2022 #{option}"
      end

      print "> "
    end

    ##### taking polls
    def take_poll_menu
      puts "Take a poll:".green
      take_poll(pick_from_polls)
    end

    def take_poll(poll)
      puts "\n#{poll.name}?"

      options = poll.options
      options.each_with_index do |option, i|
        puts "#{(i + 1).to_s.rjust(2, '0')}: #{option.body}"
      end

      print "Vote > "
      @user.answer_poll(options[gets.chomp.to_i - 1])

      puts
      puts "Results so far:".green
      print_poll(poll)

      print "Press [ENTER] to continue"
      gets
    end

    ##### viewing polls
    def view_poll_menu
      display_user_polls
      puts "\nView a poll:".green
      print_poll(pick_from_polls)
    end

    def display_user_polls
      polls = @user.polls

      return if polls.empty?

      puts "My Polls".center(20, ' ').underline.magenta
      polls.each { |poll| print_poll(poll) }
    end

    def print_poll(poll)
      results = poll.results

      return if results.empty?

      puts
      puts poll.name

      bar_size = 40
      bar_char = '='
      total_count = results.inject(0) { |sum, (_, count)| sum + count }

      results.each do |option, count|
        print "#{option.body[0...10]}| ".rjust(12, ' ')
        print (bar_char * ((count / total_count.to_f) * bar_size))
        print " #{count}"
        puts
      end

      puts
    end

    ##### grab a poll
    def pick_from_polls
      polls = Poll.all

      polls.each_with_index do |poll, i|
        print "#{(i + 1).to_s.rjust(2, '0')}: #{poll.name} \n"
      end

      print "> "
      polls[gets.chomp.to_i-1]
    end
  end
end

PollTaker::Client.new.run