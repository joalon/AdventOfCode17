$file = Get-Content ..\input\input_day19.txt

enum Direction {
    Up
    Right
    Down
    Left
}

class Position {
    [int]$x
    [int]$y
    [Direction]$direction

    Position([int]$x, [int]$y, [Direction]$direction) {
        $this.x = $x
        $this.y = $y
        $this.direction = $direction
    }
}

class WorldDto {
    [string[]]$actualWorld
    [Position]$position
    
    WorldDto([string[]]$actualWorld){
        $this.actualWorld = $actualWorld
        $this.position = [Position]::new($actualWorld[0].IndexOf('|'), 0, [Direction]::Down)
    }
}

function Step {
    
    Param(
        [parameter(ValueFromPipeline = $true)]
        [WorldDto]$World
    )

    Process{
        switch($World.position.direction) {
            "Up" {}
        }
    }

}


$test = [string[]]@(
"     |          ",
"     |  +--+    ",
"     A  |  C    ",
" F---|----E|--+ ",
"     |  |  |  D ",
"     +B-+  +--+ ",
"                ")


$world = [WorldDto]::new($test)


$world.position

$test[$world.position.y][$world.position.x]





$asd = [Direction]::Down

switch($asd){
    "Down" {write-host "Here I am =)"}
    [Direction]::Down {write-host "lol"}
}