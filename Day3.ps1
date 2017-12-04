Function GetNextDirection
{
    Param(
        [String]$CurrentDirection
    )

    Process
    {
        switch ($CurrentDirection) {
            "up" { return "left" }
            "left" { return "down" }
            "down" { return "right" }
            "right" { return "up" }
            default { return "error" }
        }
    }
}

Function DoStep
{
    Param(
        [parameter(ValueFromPipeline)]
        $positional
    )

    Process
    {
        
        [int]$newX = 0
        [int]$newY = 0
        switch ($positional.direction) {
            "up" {
                $newX = $positional.x
                $newY = $positional.y + $positional.stepSize
            }
            "left" {
                $newX = $positional.x - $positional.stepSize
                $newY = $positional.y
            }
            "down" {
                $newX = $positional.x
                $newY = $positional.y - $positional.stepSize
            }
            "right" { 
                $newX = $positional.x + $positional.stepSize
                $newY = $positional.y
            }
        }

        $newTimesStepped
        $newStepSize
        switch ($positional.timesSteppedWithCurrentStepSize) {
            1 { 
                $newTimesStepped = 0
                $newStepSize = $positional.stepSize + 1
            }
            default { 
                $newTimesStepped = $positional.timesSteppedWithCurrentStepSize + 1
                $newStepSize = $positional.stepSize
            }
        }

        $newDir = GetNextDirection $positional.direction

        $newPositional = New-Object psobject -Property @{
            x = $newX
            y = $newY
            direction = $newDir
            timesSteppedWithCurrentStepSize = $newTimesStepped
            stepSize = $newStepSize
            index = ($positional.index + $newStepSize)
        }
        return $newPositional
    }
}

$positional = New-Object psobject -Property @{
    x = 0
    y = 0
    direction = "right"
    timesSteppedWithCurrentStepSize = 0
    stepSize = 1
    index = 1
}

while ( ($positional.index + $positional.stepSize) -le 368078)
{
    $positional = DoStep $positional
}

$positional = New-Object psobject -Property @{
    x = $positional.x
    y = $positional.y
    direction = $positional.direction
    timesSteppedWithCurrentStepSize = $positional.timesSteppedWithCurrentStepSize
    stepSize = $positional.stepSize
    index = $positional.index
}

$positional

$i = $positional.index
while( $i -lt 368078-1)
{
    $positional.y -= 1
    $i++
    $positional.index++
}

[math]::Sqrt([math]::Pow($positional.x,2)) + [math]::Sqrt([math]::Pow($positional.y,2))