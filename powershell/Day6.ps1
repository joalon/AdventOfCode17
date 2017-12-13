$file = Get-Content  ..\input\input_day6.txt

[int[]]$parsedInput = ($file -split '\s+' | foreach { [int]$_ })


Function Redistribute {

    Param(
        [int[]]$Array
    )

    Process {
        $arrayLength = $Array.Count
        [int[]]$copy = $Array.Clone()

        $indexOfLargest = 0
        $largestValue = 0
        for ($i = 0; $i -lt $arrayLength; $i++) {
            if($Array[$i] -gt $largestValue) {
                $largestValue = $Array[$i]
                $indexOfLargest = $i
            }
        }

        $copy[$indexOfLargest] = 0
        $counter = $largestValue
        $indexCounter = $indexOfLargest
        while($counter-- -ne 0){
            if($indexCounter -eq ($copy.Count-1)) {
                $indexCounter = 0
            }
            else {
                $indexCounter++
            }
            $copy[$indexCounter]++
        }
        return $copy
    }
}


[string[]]$alreadySeenStates = [System.Array]::CreateInstance([string[]], 0)
$currentStep = $parsedInput

$i = 0
while( $alreadySeenStates.Contains([string]$currentStep) -eq $false ) {
    $alreadySeenStates += [string]$currentStep
    $currentStep = Redistribute $currentStep
    $i++
}

write-host "Performed " $i " steps before seeing a repetition"

Write-Host ($i - $alreadySeenStates.IndexOf([string]$currentStep)) " steps between repetitions"


