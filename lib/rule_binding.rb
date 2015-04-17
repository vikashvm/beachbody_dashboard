module RuleBinding
  def self.set_flag(*flags)
    flags.each {|flag| flag.downcase!}
    flag = "green"
    flag = "yellow" if flags.any? {|x| x == "yellow"}
    flag = "red" if flags.any? {|x| x == "red"}
    flag
  end
end