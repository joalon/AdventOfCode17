$file = Get-Content ..\input\input_day24.txt

$test = "0/2",
"2/2",
"2/3",
"3/4",
"3/5",
"0/1",
"10/1",
"9/10"

class Component {

    [int[]]$Adapters

    Component([int[]]$adapters) {
        $this.Adapters = $adapters
    }

    Component([string]$unparsed) {
        $split = $unparsed -split '/'
        $this.Adapters = @([int]$split[0], [int]$split[1])
    }

    [int] GetStrength() {
        return ($this.Adapters[0] + $this.Adapters[1])
    }
}


class Bridge {

    [Component[]]$Components

    Bridge() {
        $this.Components = @()
    }

    [bool] AddComponent([Component]$comp) {
        $this.Components += $comp

        return $true
    }

    [int] GetStrength() {
        return ($this.Components | % { $strength = 0 } { $strength += $_.GetStrength() } { return $strength } )
    }

}


$bridge = $test | % { $bridge = [Bridge]::new() } { $bridge.AddComponent([Component]::new($_)) } { return $bridge }




write-output $bridge.Components