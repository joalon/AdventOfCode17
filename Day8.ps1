$file = Get-Content .\input_day8.txt

Enum Operator {
    INC
    DEC
}

class KeyValuePair {
    [string]$Key
    [int]$Value
}

class Instruction {

    [KeyValuePair]$register
    [Operator]$Operator
    [int]$Value


    Instruction () {
        
    }

}

