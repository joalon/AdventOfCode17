$file = Get-Content .\input_day10.txt


class Knot {

    [int[]]$Circle

    [int[]]$Lengths

    [int]$CurrentPosition

    [int]$Skip

    [int]$CurrentLengthIndex

    Knot([int[]]$circle, [int[]]$lengths, [int]$currentPosition, [int]$skip, [int]$currentLengthIndex) {
        $this.Circle = $circle
        $this.Lengths = $lengths
        $this.CurrentPosition = $currentPosition
        $this.Skip = $skip
        $this.CurrentLengthIndex = $currentLengthIndex
    }


    [int[]] ReverseLength() {
        $start = $this.Lengths[$this.CurrentLengthIndex]

        [int[]]$pieceOfCircle = @()
        while($start-- -gt 0) {
            $pieceOfCircle += $this.Circle[$this.CurrentPosition]
            if($this.CurrentPosition -eq ($this.Circle.Length-1)) {
                $this.CurrentPosition = 0
            }
            else {
                $this.CurrentPosition++
            }
        }


        for($i = 0; $i -lt $pieceOfCircle.Length; $i++) {
            if($this.CurrentPosition -eq 0) {
                $this.CurrentPosition = ($this.Circle.Length-1)
            }
            else {
                $this.CurrentPosition--
            }
            $this.Circle[$this.CurrentPosition] = $pieceOfCircle[$i]
        }

        $this.CurrentPosition += $this.Lengths[$this.CurrentLengthIndex]
        $this.CurrentPosition += $this.Skip++

        if($this.CurrentPosition -gt ($this.Circle.Length-1)) {
            $this.CurrentPosition -= $this.Circle.Length
        }

        $this.CurrentLengthIndex++

        return $this.Circle
    }

    [string] PrintSolution1() {
        return "Index 0 and 1 multiplied is: " + ($this.Circle[0] * $this.Circle[1])
    }
}

$file

[int[]]$lengths = ($file.Split(',') | % { [int]$_ } )
[int[]]$circle = 0..255




#[int[]]$lengths = @(3,4,1,5)
#[int[]]$circle = 0..4

$knot = [Knot]::new($circle, $lengths, 0, 0, 0)

$lengths | % { $knot.ReverseLength() }

$knot.PrintSolution1()



