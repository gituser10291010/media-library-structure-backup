# Prompt user for source directory
$SourceDirectory = Read-Host -Prompt "Enter the source directory path"

# Validate source directory exists
if (-not (Test-Path -Path $SourceDirectory -PathType Container)) {
    Write-Error "Source directory '$SourceDirectory' does not exist or is not a directory."
    exit 1
}

# Prompt user for destination directory
$DestinationDirectory = Read-Host -Prompt "Enter the destination directory path"

# Create destination directory if it doesn't exist
if (-not (Test-Path -Path $DestinationDirectory -PathType Container)) {
    Write-Host "Creating destination directory: $DestinationDirectory"
    New-Item -Path $DestinationDirectory -ItemType Directory | Out-Null
}

# Get all directories from source (to recreate structure)
Write-Host "Scanning directory structure..."
$directories = Get-ChildItem -Path $SourceDirectory -Directory -Recurse

# Create directory structure in destination
Write-Host "Creating directory structure..."
foreach ($dir in $directories) {
    $relativePath = $dir.FullName.Substring($SourceDirectory.Length)
    $destinationPath = Join-Path -Path $DestinationDirectory -ChildPath $relativePath
    
    if (-not (Test-Path -Path $destinationPath -PathType Container)) {
        Write-Host "Creating directory: $destinationPath"
        New-Item -Path $destinationPath -ItemType Directory | Out-Null
    }
}

# Get all files except .mkv and .mp4
Write-Host "Finding non-video files to copy..."
$files = Get-ChildItem -Path $SourceDirectory -File -Recurse | Where-Object { $_.Extension -ne ".mkv" -and $_.Extension -ne ".mp4" }

# Copy files to destination
$totalFiles = $files.Count
$copiedFiles = 0

Write-Host "Copying $totalFiles files..."
foreach ($file in $files) {
    $relativePath = $file.FullName.Substring($SourceDirectory.Length)
    $destinationPath = Join-Path -Path $DestinationDirectory -ChildPath $relativePath
    
    $destinationFolder = Split-Path -Path $destinationPath -Parent
    if (-not (Test-Path -Path $destinationFolder -PathType Container)) {
        New-Item -Path $destinationFolder -ItemType Directory | Out-Null
    }
    
    Copy-Item -Path $file.FullName -Destination $destinationPath -Force
    
    $copiedFiles++
    
    # Update progress every 10 files
    if ($copiedFiles % 10 -eq 0) {
        Write-Host "Copied $copiedFiles of $totalFiles files..."
    }
}

Write-Host "Directory structure and non-video files copied successfully."
Write-Host "Copied $copiedFiles files from '$SourceDirectory' to '$DestinationDirectory'"