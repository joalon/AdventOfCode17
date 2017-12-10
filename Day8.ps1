$file = Get-Content .\input_day8.txt

$registers = @{}

$file | % { 
    $a = $_.Split(" ", [System.StringSplitOptions]::RemoveEmptyEntries)

    if($registers.ContainsKey($a[0]) -eq $false) {
        $registers.Add($a[0], 0)
    }
}

$largestValueEver = -100000

$file | % { 
    $split = $_.Split(" ", [System.StringSplitOptions]::RemoveEmptyEntries)

    switch($split[5]){
        "<" {
            if ($registers[$split[4]] -lt [int]$split[6]) {
                switch($split[1]){
                    "inc" { $registers[$split[0]] += [int]$split[2] }
                    "dec" { $registers[$split[0]] -= [int]$split[2] }
                }
            }
        }
        ">" {
            if ($registers[$split[4]] -gt [int]$split[6]) {
                switch($split[1]){
                    "inc" { $registers[$split[0]] += [int]$split[2] }
                    "dec" { $registers[$split[0]] -= [int]$split[2] }
                }
            } 
        }
        ">=" { 
            if ($registers[$split[4]] -ge [int]$split[6]) {
                switch($split[1]){
                    "inc" { $registers[$split[0]] += [int]$split[2] }
                    "dec" { $registers[$split[0]] -= [int]$split[2] }
                }
            } 
        }
        "<=" { 
            if ($registers[$split[4]] -le [int]$split[6]) {
                switch($split[1]){
                    "inc" { $registers[$split[0]] += [int]$split[2] }
                    "dec" { $registers[$split[0]] -= [int]$split[2] }
                }
            }
        }
        "!=" { 
            if ($registers[$split[4]] -ne [int]$split[6]) {
                switch($split[1]){
                    "inc" { $registers[$split[0]] += [int]$split[2] }
                    "dec" { $registers[$split[0]] -= [int]$split[2] }
                }
            } 
        }
        "==" { 
            if ($registers[$split[4]] -eq [int]$split[6]) {
                switch($split[1]){
                    "inc" { $registers[$split[0]] += [int]$split[2] }
                    "dec" { $registers[$split[0]] -= [int]$split[2] }
                }
            }
        }
        default {
            write-host "Didn't handle: " $split[5]
        }
    }
    if($registers[$split[0]] -gt $largestValueEver) {
            $largestValueEver = $registers[$split[0]]
    }
}

$largestValueAtEnd = -10000
$registers.Values | foreach {
    if($_ -gt $largestValueAtEnd) {
        $largestValueAtEnd = $_
    }
}

write-host "Largest value at the end was: " $largestValue
write-host "Largest value ever was: " $largestValueEver