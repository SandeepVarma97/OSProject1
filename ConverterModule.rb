
module ConverterModule
    class Converter
        def self.xmlRPCTupleToTuple(xmlRPCTuple)
            convertedList = []
            for i in xmlRPCTuple
                convertedList.push(xmlRPCItemToItem(i))
            end

            convertedList
        end

        def self.xmlRPCItemToItem(xmlRPCItem)
            converted = xmlRPCItem

            stringClass = Module.const_get('String')
            numericClass = Module.const_get('Numeric')
            hashClass = Module.const_get('Hash')

            if (converted.is_a?(stringClass))
                converted = xmlRPCItem
            elsif (converted.is_a?(numericClass))
                converted = xmlRPCItem
            elsif (converted.is_a?(hashClass))
                name = getName(converted)
                converted = convert(name, converted)
            else
                converted = xmlRPCItem
            end

            converted
        end

        def self.getName(hash)
            keys = hash.keys
            name  = nil
            
            if (keys.include? 'class')
                name = 'class'                
            elsif (keys.include? 'regexp')
                name = 'regexp'
            elsif (keys.include? 'from')
                name = 'range'
            elsif (keys.include? 'symbol')
                name = 'symbol'
            else
                name = 'symbol'
            end

            name
        end

        def self.convert(name, item)
            converted = item

            if (name == 'class')
                converted = Module.const_get(item['class'])
            elsif (name == 'regexp')
                converted = Regexp.new(item['regexp'])
            elsif (name == 'range')
                converted = Range.new(item['from'], item['to'])
            elsif (name == 'symbol')
                converted = :"#{converted['symbol']}"
            else
                converted = :"#{converted}"
            end

            converted
        end
    end
end