class Generator {

    [int]$Factor

    [int]$CurrentNumber

    [int]$AnswerIsDivisibleBy

    hidden [int]$divisor = 2147483647

    Generator([int]$factor, [int]$currentNumber, [int]$answerIsDivisibleBy) {
        $this.Factor = $factor
        $this.CurrentNumber = $currentNumber
        $this.AnswerIsDivisibleBy = $answerIsDivisibleBy
    }

    Generator([int]$factor, [int]$currentNumber) {
        $this.Factor = $factor
        $this.CurrentNumber = $currentNumber
        $this.AnswerIsDivisibleBy = 1
    }

    [int] Generatev1() {
        $this.CurrentNumber = $this.CurrentNumber * $this.Factor % $this.divisor

        return $this.CurrentNumber
    }

    [int] Generatev2() {
        do {
            $this.CurrentNumber = $this.CurrentNumber * $this.Factor % $this.divisor
        } while($this.CurrentNumber % $this.AnswerIsDivisibleBy -ne 0) 

        return $this.CurrentNumber
    }


}

# First answer:
1..40000000 | % { $matches = 0; $genA = [Generator]::new(16807, 116); $genB = [Generator]::new(48271, 299) }{ $A = $genA.Generatev1(); $B = $genB.Generatev1(); if([uint16]($A -band 0xffff) -eq [uint16]($B -band 0xffff)) { $Matches++ } }{ return $Matches }
# Soooo sloooow

# Second answer:
1..5000000 | % { $matches = 0; $genA = [Generator]::new(16807, 116, 4); $genB = [Generator]::new(48271, 299, 8) }{ $A = $genA.Generatev2(); $B = $genB.Generatev2(); if([uint16]($A -band 0xffff) -eq [uint16]($B -band 0xffff)) { $Matches++ } }{ return $Matches }
