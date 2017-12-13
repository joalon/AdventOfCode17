$file = Get-Content .\input_day11.txt


class Position {

    [int]$X
    [int]$Y

}

Function Solve {
    Param(
        [parameter(ValueFromPipeline)]
        [string]$directions
    )

    Begin {
        $result = New-Object Position -property @{ X = 0; Y = 0}

        [int]$numberOfNMoves=0
        [int]$numberofNEMoves=0
        [int]$numberOfSEMoves=0
    }

    Process {

        $moves = $directions -split ','

        $moves | % {
            switch ($_) {
                
                "n" {
                    $numberOfNMoves++
                }
                "ne" {
                    $numberofNEMoves++
                }
                "se" {
                    $numberofSEMoves++
                }
                "s" {
                    $numberOfNMoves--
                }
                "sw" {
                    $numberofNEMoves--
                }
                "nw" {
                    $numberofSEMoves--
                }
            }
        }
    }

    End {
        return ($numberofNEMoves + ($numberOfNMoves * 2) + ($numberOfSEMoves - $numberOfNMoves))
    }
}

$test1 = "ne,ne,ne"

Solve $test1

$test2 = "ne,ne,s,s"

Solve $test2

$test3 = "se,sw,se,sw,sw"

Solve $test3

Solve $file
