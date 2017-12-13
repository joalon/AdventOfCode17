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


    [void] ReverseLength() {
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
    }

    [string] PrintSolution1() {
        return "Index 0 and 1 multiplied is: " + ($this.Circle[0] * $this.Circle[1])
    }
}

[int[]]$lengths = ($file.Split(',') | % { [int]$_ } )
[int[]]$circle = 0..255

$knot = [Knot]::new($circle, $lengths, 0, 0, 0)
$lengths | % { $knot.ReverseLength() }
$knot.PrintSolution1()

write-host $knot.Circle


[int[]]$asciiFile = ($file.split(",", [System.StringSplitOptions]::RemoveEmptyEntries) | % { [int[]]$asciiFile = @(); $enc = [System.Text.Encoding]::ASCII } { $asciiFile += $enc.GetString([char]$_) } { return $asciiFile })

write-host $file
Write-Host $asciiFile

<#
$enc = [System.Text.Encoding]::ASCII

$asd = [char]50

[int]$enc.GetString($asd)
#>


<#
$asd = ""
97..122 | % { $asd += [char]$_ }


$etf = [byte]97
$etf.GetType()



$bytes = $enc.GetBytes($asd)
$byte = $bytes[0]
$byte.GetType()

$byte -bxor [byte]98

[System.BitConverter]::ToString([Byte[]](1,2,3,4,5,6,255,16)) #-replace "-"

#>