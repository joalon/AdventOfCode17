class Position {
    [int]$Index

    Position([int]$index) {
        $this.Index = $index
    }
}

class Day5 {

    hidden [int[]]$Array

    hidden [Position]$CurrentPosition

    Day5() {
        $unparsedInput = Get-Content .\input_day5.txt

        $this.Array = [System.Array]::CreateInstance([int], $unparsedInput.Length)

        [int]$i = 0
        foreach($string in $unparsedInput){
            $this.Array[$i++] = [int]$string
        }

        $this.CurrentPosition = [Position]::new(0)
    }

    [int] Solve1() {
        $numberOfSteps = 0

        $arrayLength = $this.Array.Length

        while($this.CurrentPosition.Index -lt $arrayLength) {
            $this.takeStep1()

            $numberOfSteps++
        }

        return $numberOfSteps
    }

    [int] Solve2() {
        $numberOfSteps = 0

        $arrayLength = $this.Array.Length

        while($this.CurrentPosition.Index -lt $arrayLength) {
            $this.takeStep1()

            $numberOfSteps++
        }

        return $numberOfSteps
    }

    [void] takeStep1(){
        $currentIndex = $this.CurrentPosition.Index
        $valueToJump = $this.Array[$this.CurrentPosition.Index]

        $this.CurrentPosition.Index += $valueToJump

        $this.Array[$currentIndex]++
    }

    [void] takeStep2(){
        $currentIndex = $this.CurrentPosition.Index
        $valueToJump = $this.Array[$this.CurrentPosition.Index]

        $this.CurrentPosition.Index += $valueToJump

        if($this.Array[$currentIndex] -ge 3) {
            $this.Array[$currentIndex]--
        }
        else {
            $this.Array[$currentIndex]++
        }
    }

    [Position] GetPosition() {
        return $this.CurrentPosition
    }

    [int[]] GetArray() {
        return $this.Array
    }
}

$solution = [Day5]::new()

$solution.Solve1()