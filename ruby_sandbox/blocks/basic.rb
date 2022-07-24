
@transactions = [10, -15, 25, 30, -24, -70, 999]

def block_meth
  @transactions.each do |transaction|
    puts yield transaction
  end
end

block_meth do |transaction|
  "%0.2f" % transaction
end
