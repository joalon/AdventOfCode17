$file = Get-Content  ..\input\input_day12.txt

class Program {

    [int]$Id

    [int[]]$ProgramIds

    Program([int]$id, [string[]]$unparsedGroup) {
        $this.Id = $id

        $this.ProgramIds = @()
        $unparsedGroup | % {
            $this.ProgramIds += [int]$_
        }

    }

}

Function ParsePrograms {

    Param(
        [parameter(ValueFromPipeline)]
        [string]$inputvalue
    )

    Begin {
        [program[]]$results = @()
    }

    Process{
        $unparsed = $_ -split '\s+'
        $unparsed = $unparsed.Split('<->', [System.StringSplitOptions]::RemoveEmptyEntries)
        $unparsed = $unparsed.Split(',', [System.StringSplitOptions]::RemoveEmptyEntries)
        
        $program = new-object Program $unparsed[0], $unparsed.Substring(0)
        $results += $program 
    }

    End {
        return $results
    }
}

Function Solve {
    
    Param(
        [parameter(ValueFromPipeline)]
        [Program[]]$Programs
    )

    Begin {
        $toInvestigate = @(0)
        $result = @{}
    }

    Process {
        while ($toInvestigate.Count -gt 0) {
            [Program]$var = [System.Linq]::SingleOrDefault($Programs, { Param([Program]$p) $p.Id -eq $toInvestigate.Get(0)})

            if($result.ContainsKey($var.Id) -eq $false) {
                
            }

            $toInvestigate.RemoveAt(0)
        }
    }

    End {
        return $result.Count
    }

}

$test = "0 <-> 2",
"1 <-> 1",
"2 <-> 0, 3, 4",
"3 <-> 2, 4",
"4 <-> 2, 3, 6",
"5 <-> 6",
"6 <-> 4, 5"

$test | ParsePrograms | Solve

$test2 = ($test | ParsePrograms)

solve $test2


$file | ParsePrograms | Solve


[int[]]$arr = 1,2,3

$arr += 1