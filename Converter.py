import re

class Converter:
    @staticmethod
    def tupleToXMLRPCData(tupleItem):
        l = list(tupleItem)
        for i in range(len(tupleItem)):
            l[i] = toXMLRPCData(l[i])
        
        return tuple(l)

    @staticmethod
    def toXMLRPCData(item):
        converted = item

        if (type(item) == str):
            converted = item
        elif (type(item) == int):
            converted = item
        elif (item == str):
            converted = {'class' : 'String'}
        elif (item == int):
            converted = {'class' : 'Numeric'}
        elif (type(item) == re.Pattern):
            converted = {'regexp' : item}
        elif (type(item) == range):
            converted = {'from' : item[0], 'to' : item[len(item)-1]}
        elif (type(item) == dict):
            if ('symbol' in item):
                converted = item
            else:
                converted = item
        else:
            converted = item
