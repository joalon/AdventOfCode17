$file = Get-Content  ..\input\input_day4.txt

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
                return $true
            }
        }

        return $false
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

ContainsDuplicateString "aa bb cc dd ee" #Should return false

ContainsDuplicateString "aa bb cc dd aa" #Should return true

$file | Where-Object { (ContainsDuplicateString $_) -eq $false } | Measure-Object



Function ContainsAnagram
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
            $sortedWord = ($word -split '(.{1})' | Where-Object { $_ } | sort)
            $hash = Hash $sortedWord
            if($uniqueHashedWords.Contains($hash) -eq $false)
            {
                $uniqueHashedWords += $hash
            }
            else
            {
                return $true
            }
        }

        return $false
    }
}

ContainsAnagram "abcde fghij" #Should return false

ContainsAnagram "abcde xyz ecdab" #Should return true

$file | Where-Object { (ContainsAnagram $_) -eq $false } | Measure-Object