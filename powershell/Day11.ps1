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
    }

    Process {

        $moves = $directions -split ','

        $moves | % {
            switch ($_) {
                
                "n" {
                    $result = New-Object Position -property @{ X = $result.X; Y = ($result.Y + 1) }
                }
                "ne" {
                    $result = New-Object Position -property @{ X = ($result.X + 1); Y = ($result.Y + 1) }
                }
                "se" {
                    $result = New-Object Position -property @{ X = ($result.X + 1); Y = $result.Y }
                }
                "s" {
                    $result = New-Object Position -property @{ X = $result.X; Y = ($result.Y - 1) }
                }
                "sw" {
                    $result = New-Object Position -property @{ X = ($result.X - 1); Y = $result.Y }
                }
                "nw" {
                    $result = New-Object Position -property @{ X = ($result.X - 1); Y = ($result.Y + 1) }
                }
            }
        }
    }

    End {
        return ([math]::Sqrt([math]::Pow($result.X, 2)) + [math]::Sqrt([math]::Pow($result.Y, 2))), $result
    }
}

$test1 = "ne,ne,ne"

(Solve $test1) -eq 3

$test2 = "ne,ne,s,s"

(Solve $test2) -eq 2
solve $test2


#Solve $file | Write-Host
