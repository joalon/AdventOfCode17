$file = Get-Content  ..\input\input_day9.txt

Function CleanGarbage {
    Param(
        [parameter(ValueFromPipeline)]
        [string]$inputFile
    )

    Process {

        $stringWithoutEscapedTags = $inputFile -replace "(!.)"

        $nearlyClean = $stringWithoutEscapedTags -replace "<(.*?)([^\!\>])*>"

        $cleaned = $nearlyClean -replace "[^{}]"

        return $cleaned
    }
}

Function RemoveNonGarbage {
    Param(
        [parameter(ValueFromPipeline)]
        [string]$inputFile
    )

    Process {

        $stringWithoutEscapedTags = $inputFile -replace "(!.)"

        return $stringWithoutEscapedTags
    }
}

Enum State {
    Garbage
    Clean
}

function CountGarbage {
    Param(
        [parameter(ValueFromPipeline)]
        [string]$inputString
    )

    process {

        $state = [State]::Clean

        $numGarbage = 0

        foreach($char in $inputString.GetEnumerator()) {
            switch ($char) {
                "<" {
                    if($state -eq [State]::Clean){
                        $state = [State]::Garbage
                    }
                    else {
                        $numGarbage++
                    }
                }
                ">" {
                    if($state -eq [State]::Garbage){
                        $state = [State]::Clean
                    }
                }
                default {
                    if($state -eq [State]::Garbage){
                        $numGarbage++
                    }
                }
            }
        }

        return $numGarbage
    }
}

Function RemoveCharacters {
    Param(
        [parameter(ValueFromPipeline)]
        [string]$stringWithDoubleChars,

        [string]$Characters
    )

    Process {
        return $stringWithDoubleChars.Replace($Characters, "")
    }
}

Function ScoreString {
    Param(
        [parameter(ValueFromPipeline)]
        [string]$inputString
    )

    Process {
        
        [int]$score = 0

        [int]$layers = 0

        foreach($char in $inputString.GetEnumerator()) {
            switch ($char) {
                "{" { 
                    $layers++ 
                    $score += $layers
                }
                "}" { 
                    $layers--
                }
            }
        }
        return $score
    }
}


$ans = ($file | CleanGarbage | ScoreString)

write-host "First answer is: " $ans

write-host -NoNewline "Second answer is: "
$file | RemoveNonGarbage | CountGarbage | write-host 