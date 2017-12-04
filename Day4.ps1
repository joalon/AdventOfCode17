$file = Get-Content .\input_day4.txt

Function ContainsDuplicateString
{
    Param(
        [parameter(ValueFromPipeline)]
        [String]$passphrase
    )

    Process
    {
        $individualWords = $passphrase -split '\s+'
        
        $uniqueHashedWords = @()
        foreach ($word in $individualWords)
        {
            $hash = Hash $word
            if($uniqueHashedWords.Contains($hash) -eq $false)
            {
                $uniqueHashedWords += $hash
            }
            else
            {
                return $false
            }
        }

        return $true
    }
}

# Hash function written by alias Ivovan at
# https://blogs.msdn.microsoft.com/luc/2011/01/21/powershell-getting-the-hash-value-for-a-string/
function Hash($textToHash)
{
    $hasher = new-object System.Security.Cryptography.SHA256Managed
    $toHash = [System.Text.Encoding]::UTF8.GetBytes($textToHash)
    $hashByteArray = $hasher.ComputeHash($toHash)
    foreach($byte in $hashByteArray)
    {
         $res += $byte.ToString()
    }
    return $res;
}

ContainsDuplicateString "aa bb cc dd ee" #Should return true

ContainsDuplicateString "aa bb cc dd aa" #Should return false

$file | Where-Object { (ContainsDuplicateString $_) } | Measure-Object