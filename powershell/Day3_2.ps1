
Enum Direction {
    up
    left
    down
    right
}

class Cell {
    [int] $Value

    Cell () {}

    Cell ([int]$value){
        $this.Value = $value
    }
}

class Position {
    [int]$X
    [int]$Y
    [Direction]$CurrentDirection

    Position([int]$x, [int]$y, [Direction]$Direction){
        $this.X = $x
        $this.Y = $y
        $this.CurrentDirection = $Direction
    }

    [string] ToString() {
        return "(" + $this.X + "," + $this.Y + ")" + " " + $this.CurrentDirection.ToString()
    }
}

class Day3Problem2 {

    [Cell[,]]$Array

    [Position]$Pos

    [int]$ArraySize = 10

    [int]$Goal = 368078

    Day3Problem2()
    {
        $this.Array = New-Object 'Cell[,]' $this.ArraySize,$this.ArraySize
        foreach ($y in 0..($this.ArraySize-1))
        {
            foreach ($x in 0..($this.ArraySize-1))
            {
                $this.Array[$x,$y] = [Cell]::new(0)
            }
        }

        $start = ($this.ArraySize/2)

        [Direction]$startingDir = [Direction]::right

        $this.Pos = [Position]::new($start, $start, $startingDir)

        $this.Array[$this.Pos.X,$this.Pos.Y].Value = 1
    }

    [int] Solve()
    {
        
        while ($this.Array[$this.Pos.X,$this.Pos.Y].Value -lt $this.Goal) {
            $this.TakeStep()
        }

        return $this.Array[$this.Pos.X,$this.Pos.Y].Value

    }

    [int] TakeStep()
    {
        switch ($this.Pos.CurrentDirection) 
        {
           "up" {
              $this.Pos.Y += 1
              $this.PopulateCell($this.Pos)
              if($this.Array[($this.Pos.X-1),$this.Pos.Y].Value -eq 0) {
                 $this.Pos.CurrentDirection = [Day3Problem2]::GetNewDirection($this.Pos.CurrentDirection)
              }
           }

           "left" {
              $this.Pos.X -= 1
              $this.PopulateCell($this.Pos)
              if($this.Array[$this.Pos.X,($this.Pos.Y-1)].Value -eq 0) {
                 $this.Pos.CurrentDirection = [Day3Problem2]::GetNewDirection($this.Pos.CurrentDirection)
              }
           }

           "down" {
              $this.Pos.Y -= 1
              $this.PopulateCell($this.Pos)
              if($this.Array[($this.Pos.X+1),$this.Pos.Y].Value -eq 0) {
                 $this.Pos.CurrentDirection = [Day3Problem2]::GetNewDirection($this.Pos.CurrentDirection)
              }
           }

           "right" {
              $this.Pos.X += 1
              $this.PopulateCell($this.Pos)
              if($this.Array[$this.Pos.X,($this.Pos.Y+1)].Value -eq 0) {
                 $this.Pos.CurrentDirection = [Day3Problem2]::GetNewDirection($this.Pos.CurrentDirection)
              }
           }
        }

        return $this.Array[$this.Pos.X,$this.Pos.Y].Value
    }

    [void] PopulateCell([Position]$CurPos) {
        $newValue = 0

        $newValue += $this.Array[($CurPos.X-1),($CurPos.Y-1)].Value
        $newValue += $this.Array[($CurPos.X-1),$CurPos.Y].Value
        $newValue += $this.Array[($CurPos.X-1),($CurPos.Y+1)].Value
                                 
        $newValue += $this.Array[$CurPos.X,($CurPos.Y-1)].Value
        $newValue += $this.Array[$CurPos.X,($CurPos.Y+1)].Value
                                 
        $newValue += $this.Array[($CurPos.X+1),($CurPos.Y-1)].Value
        $newValue += $this.Array[($CurPos.X+1),$CurPos.Y].Value
        $newValue += $this.Array[($CurPos.X+1),($CurPos.Y+1)].Value

        $this.Array[$this.Pos.X,$this.Pos.Y].Value = $newValue
    }

    static [Direction] GetNewDirection ([Direction]$oldDir) {
        switch ($oldDir) {
            "up" { return [Direction]::left }
            "left" { return [Direction]::down }
            "down" { return [Direction]::right }
            "right" { return [Direction]::up }
        }
        return $null
    }

    static [void] PrintArray([Cell[,]]$ToPrint)
    {
        foreach($y in ($ToPrint.GetLength(0)..0)){
            foreach($x in 0..($ToPrint.GetLength(0))){
                write-host -NoNewline $ToPrint[$x,$y].Value " "
            }
            Write-Host ""
        }
    }
}

$solution = [Day3Problem2]::new()

$solution.Solve()