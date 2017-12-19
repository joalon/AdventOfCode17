#$file = Get-Content ..\input\input_day15.txt

class Generator {

    [int]$Factor

    [int]$CurrentNumber

    hidden [int]$divisor = 2147483647

    Generator([int]$factor, [int]$currentNumber) {
        $this.Factor = $factor
        $this.CurrentNumber = $currentNumber
    }

    [int] Generate() {
        $this.CurrentNumber = $this.CurrentNumber * $this.Factor % $this.divisor

        return $this.CurrentNumber
    }

    [int] GetCurrentNumber() {
        return $this.CurrentNumber
    }

}

#$genA = [Generator]::new(16807, 65)
#$genB = [Generator]::new(48271, 8921)

1..40000000 | % { $matches = 0; $genA = [Generator]::new(16807, 116); $genB = [Generator]::new(48271, 299) }{ $A = $genA.Generate(); $B = $genB.Generate(); if([uint16]($A -band 0xffff) -eq [uint16]($B -band 0xffff)) { $Matches++ } }{ return $Matches }

