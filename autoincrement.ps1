param(
    [parameter(Mandatory=$true)]
    [String]$branch,
    [parameter(Mandatory=$true)]
    [String]$versionFile
)
Write-Host "Branch: $branch"
$fileVersion = [version](Get-Content $versionFile)
$stringArray = $branch.ToString().Split("/")
$branchType = $stringArray[0].ToLower()  # Convert to lowercase
$major = $fileVersion.Major
$minor = $fileVersion.Minor
$patch = $fileVersion.Build

if($branchType -eq "release")
{
    $major = $major + 1
}

if($branchType -eq "feature")
{
    $minor = $minor + 1
}

if($branchType -eq "bug" -or $branchType -eq "bugfix")
{
    $patch = $patch + 1
}

$version = "$major.$minor.$patch"
Write-Host "Version: $version"
Set-Content $versionFile $version