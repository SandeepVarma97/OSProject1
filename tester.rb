
require "./ConverterModule"

# test
# [ { "regexp" => "^[-+/*]$" }, 1, "tester", { "from" => 10, "to" => 6 }, { "class" => "String" }, { "class" => "Numeric" }, { "symbol" => "chopstick" }, nil ]

loop do
    print "Expression: "
    $stdout.flush

    input = (gets).strip

    if (input == 'exit')
        break
    else
        expr = eval(input)
        converted = ConverterModule::Converter.xmlRPCTupleToTuple(expr)
        
        for i in converted
            puts 'class: ' + i.class.name
            puts i   
        end
    end
end