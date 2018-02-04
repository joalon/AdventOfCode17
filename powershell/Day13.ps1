$file = Get-Content ..\input\input_day13.txt

$test = "0: 3",
"1: 2",
"4: 4",
"6: 4"

class Layer {

    [int]$Depth

    [int]$Range

    [int]$ScannerIndex
    
    hidden [Dir]$dir

    Layer([int]$Depth, [int]$Range) {
        $this.Depth = $Depth
        $this.Range = $Range
        if($Range -eq 0) {
            $this.ScannerIndex = -1
        } else {
            $this.ScannerIndex = 0
        }

        $this.dir = [Dir]::DOWN
    }

    [void] Scan() {
        if($this.Range -gt 0) {

            if( ($this.ScannerIndex -eq $this.Range-1) -and ($this.dir -eq [Dir]::DOWN) ) {
                
                $this.dir = [Dir]::UP

            } elseif( ($this.ScannerIndex -eq 0) -and ($this.dir -eq [Dir]::UP) ) {
                 $this.dir = [Dir]::DOWN
            }

            switch($this.dir) {
                UP { $this.ScannerIndex-- }
                DOWN { $this.ScannerIndex++ }
            }
        }
    }

    [string] ToString() {
        return "" + $this.Depth + ": " + $this.Range
    }
}

Enum Dir {
    UP
    DOWN
}

class Firewall {

    [Layer[]]$Wall

    [int]$MyPos

    [int]$TimesCaught

    Firewall([string[]]$Param, [int]$delay) {

        $this.TimesCaught = 0
        $this.MyPos = -1 - $delay
        $this.Wall = @()
        
        $lastIndex = [int]($Param[$Param.Count-1] -split ': ')[0]

        $indexOfInput = 0
        for([int]$i = 0; $i -le $lastIndex; $i++) {
           
            if([int]($Param[$indexOfInput] -split ': ')[0] -ne $i){
                $this.Wall += [Layer]::new($i, 0)
            }
            else {
                $range = [int]($Param[$indexOfInput] -split ': ')[1]
                $this.Wall += [Layer]::new($i, $range)

                $indexOfInput++                
            }
        }
    }

    [int] Scan () {
        $this.MyPos++

        $severity = 0

        if($this.MyPos -ge 0) {
            if($this.Wall[$this.MyPos].ScannerIndex -eq 0) {
                $severity = $this.Wall[$this.MyPos].Depth * $this.Wall[$this.MyPos].Range
                $this.TimesCaught++
            }
            
        }
        foreach($layer in $this.Wall) {
                $layer.Scan()
        }

        return $severity
    }
}

# Solution 1
$firewall1 = [Firewall]::new($test, 0)
1..$firewall1.Wall.Count | % { $acc = 0 } { $acc += $firewall1.Scan() } { return $acc }


#Solution 2
$delay = 5
do {
    $firewall2 = [Firewall]::new($file, $delay)
    $severity = 0
    for($i = 0; $i -lt ($firewall2.Wall.Count+$delay); $i++) {
        $severity += $firewall2.Scan()
    }
    $delay++
} while ($severity -ne 0)

($delay-1)
