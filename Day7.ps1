$file = Get-Content .\input_day7.txt

$test = "pbga (66)",
"xhth (57)",
"ebii (61)",
"havc (66)",
"ktlj (57)",
"fwft (72) -> ktlj, cntj, xhth",
"qoyq (66)",
"padx (45) -> pbga, havc, qoyq",
"tknk (41) -> ugml, padx, fwft",
"jptl (61)",
"ugml (68) -> gyxo, ebii, jptl",
"gyxo (61)",
"cntj (57)"

class Program {
    [string]$Name
    [int]$Weight
    [string[]]$ChildrensNames
    [Program[]]$Children
    [Program[]]$Parent

    Program([string]$name, [int]$weight){
        $this.Name = $name
        $this.Weight = $weight
        $this.ChildrensNames = @()
        $this.Children = @()
    }

    Program([string]$name, [int]$weight, [string[]]$childrensNames) {
        $this.Name =$name
        $this.Weight = $weight
        $this.ChildrensNames = $childrensNames
        $this.Children = @()
    }
}


Function ParseProgram {
    Param(
        [parameter(ValueFromPipeline)]
        [string]$unparsedProgram
    )

    Process 
    {
        [string[]]$splitString = $unparsedProgram -split '\W\s*'

        $splitString = $splitString | ?{$_} # Remove empty array positions

        $programName = $splitString[0]
        $programWeight = [int]$splitString[1]
        $childrensNames = @()
        if($splitString.Count -ge 3) {
            
            for($i = 2; $i -lt $splitString.Count; $i++) {
                $childrensNames += $splitString[$i]
            }
        }

        return [Program]::new($programName, $programWeight, $childrensNames)
    }
}


[Program[]]$unsorted = @()
#$file | foreach { $unsorted += (ParseProgram $_) }
$file | foreach { $unsorted += (ParseProgram $_) }

[Program[]]$nextPass = @()
$unsorted | foreach { $nextPass += $_}

foreach ($prog in $unsorted) {
    if($prog.ChildrensNames -gt 0){
        foreach($childName in $prog.ChildrensNames) {

            $child = [System.Linq.Enumerable]::Single($unsorted, [Func[Program,bool]]{ param($p) $p.Name -eq $childName })
            
            $child.Parent = $prog
            $prog.Children += $child
        }
    }
}

[Program]$root = [System.Linq.Enumerable]::Single($unsorted, [Func[Program,bool]]{ param($p) $p.Parent -eq $null })

function CalculateChildWeights {

    Param(
        [Program]$node
    )

    Process {
        if($node.Children.Count -eq 0) {
            return $node.Weight
        }
        
        [int]$childWeights = 0

        foreach($child in $node.Children) {
            $childWeights += (CalculateChildWeights $child)
        }

        return $childWeights
    }
}

function CalculateLayerWeights {
    Param(
        [Program]$node,
        [int]$targetLayer,
        [int]$currentLayer = 0
    )
    process {
        if($targetLayer -eq $currentLayer){
            return $node.Weight
        }

        [int]$layerWeight = 0
        foreach($child in $node.Children) {
            $layerWeight += (CalculateLayerWeights $child $targetLayer ($currentLayer++))
        }

        return $layerWeight
    }
}

write-host "Child weights: "
foreach($child in $root.Children) {
    $weight = (CalculateChildWeights $child)
    write-host $child.Name ": " ($weight + $child.Weight)
}

write-host "layer weights: "
foreach($child in $root.Children) {
    $weight = (CalculateLayerWeights $child 10)
    write-host $child.Name ": " $weight
}

