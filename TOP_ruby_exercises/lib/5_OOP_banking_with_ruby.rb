
#Include a deposit method that lets users add money to their accounts
#Include error checking that prevents users from overdrawing their accounts
#Create CheckingAccounts or SavingsAccounts that inherit from Account



class Account
  attr_reader :name 
  attr_reader :balance
  def initialize(name, balance=100)
    @name = name
    @balance = balance
  end
  
  def display_balance(pin_number)
    puts pin_number == pin ? "Balance: $#{@balance}": pin_error
  end

  def withdraw(amount, pin_number)
    if pin_number == pin
      @balance -= amount
      puts "Withdrew #{amount}. New balance: #{@balance}"
    else 
      puts pin_error
    end
  end

  private
  def pin
    @pin = 1234
  end
  def pin_error
    "Access denied: incorrect PIN."
  end
end

susan_smith_account = Account.new("Susan Smith", 30_000)
jim_bob_account = Account.new("Jim bob", 100_000)

jim_bob_account.display_balance(1234)
jim_bob_account.withdraw(30_000, 1234)
susan_smith_account .display_balance(3456)
susan_smith_account .pin
