[String[]]$file = Get-Content ..\input\input_day2.txt

function CalculateChecksum
{

    Param(
        [parameter(ValueFromPipeline)]
        [String[]]$file
    )

    Process
    {
        $checksums = @()

        foreach($line in $file)
        {
            $split = $line -split '\s+'

            $lowestValue = 100000000

            $highestValue = 0

            foreach($unparsedString in $split)
            {
                
                $value = [int]$unparsedString

                if ($value -gt $highestValue)
                {
                    $highestValue = $value
                }
                if($value -lt $lowestValue)
                {
                    $lowestValue = $value
                }
            }

            $lineChecksum = $highestValue - $lowestValue
            $checksums += $lineChecksum
        }

        $fileChecksum = 0
        foreach($checksum in $checksums)
        {
            $fileChecksum = $fileChecksum + $checksum
        }

        return $fileChecksum
    }
}

$example = [String[]]"5   1   9   5", "7 5 3", "2 4 6 8"
    
CalculateChecksum $example

CalculateChecksum $file




function CalculateEvenlyDivisibleChecksum
{

    Param(
        [parameter(ValueFromPipeline)]
        [String[]]$file
    )

    Process
    {
        $checksums = @()

        foreach($line in $file)
        {
            $split = $line -split '\s+'

            $lineValues = @()
            foreach($unparsedString in $split)
            {
                $value = [int]$unparsedString
                $lineValues += $value
            }

            $lineChecksum = 0
            foreach($value in $lineValues)
            {
                foreach($value2 in $lineValues)
                {
                    if($value -ne $value2)
                    {
                        if( !($value%$value2) )
                        {
                            $lineChecksum = ($value/$value2)
                            $checksums += $lineChecksum
                            write-host "Modulo is: " $lineChecksum " from " $value " / " $value2
                            break
                        }
                    }
                }
            }
        }

        $fileChecksum = 0
        foreach($checksum in $checksums)
        {
            write-host "Linechecksum: " $checksum
            $fileChecksum = $fileChecksum + $checksum
        }

        return $fileChecksum
    }
}
$example2 = [String[]]"5 9 2 8", "9 4 7 3", "3 8 6 5"

CalculateEvenlyDivisibleChecksum $example2

CalculateEvenlyDivisibleChecksum $file