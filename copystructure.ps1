# Simplified Media Library Structure Copy Script
# Excludes multiple large file types commonly found in media libraries

# Define excluded file extensions (large media files)
$ExcludedExtensions = @(
    # Video files
    ".mkv", ".mp4", ".avi", ".mov", ".wmv", ".flv", ".webm", ".m4v", ".3gp",
    ".mpg", ".mpeg", ".m2v", ".ts", ".mts", ".m2ts", ".vob", ".ogv", ".divx",
    
    # High-quality audio files (optional - remove if you want to keep these)
    ".flac", ".ape", ".wav", ".dsd", ".dsf", ".dff",
    
    # Disc images
    ".iso", ".img", ".bin", ".nrg", ".mdf", ".cue",
    
    # Archives (optional - remove if you want to keep these)
    ".zip", ".rar", ".7z", ".tar", ".gz", ".bz2"
)

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

# Display excluded file types
Write-Host "Excluded file types:" -ForegroundColor Yellow
$ExcludedExtensions | Sort-Object | ForEach-Object { Write-Host "  $_" -ForegroundColor Gray }
Write-Host ""

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

# Get all files excluding the specified large file types
Write-Host "Finding files to copy (excluding large media files)..."
try {
    $files = @()
    $fileCount = 0
    
    Get-ChildItem -Path $SourceDirectory -File -Recurse | Where-Object { 
        $_.Extension -notin $ExcludedExtensions 
    } | ForEach-Object {
        $files += $_
        $fileCount++
        
        # Show progress every 500 files
        if ($fileCount % 500 -eq 0) {
            Write-Host "Found $fileCount files to copy..." -ForegroundColor Cyan
        }
    }
    
    Write-Host "File scan complete. Found $fileCount files to copy." -ForegroundColor Green
}
catch {
    Write-Error "Failed to scan files: $($_.Exception.Message)"
    exit 1
}

# Display file count
Write-Host ""
Write-Host "Found $($files.Count) files to copy" -ForegroundColor Green
Write-Host ""

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
    
    try {
        Copy-Item -Path $file.FullName -Destination $destinationPath -Force
        $copiedFiles++
        
        # Update progress every 10 files
        if ($copiedFiles % 10 -eq 0) {
            Write-Host "Copied $copiedFiles of $totalFiles files..." -ForegroundColor Green
        }
    }
    catch {
        Write-Warning "Failed to copy: $($file.FullName) - $($_.Exception.Message)"
    }
}

Write-Host ""
Write-Host "Directory structure and selected files copied successfully." -ForegroundColor Green
Write-Host "Copied $copiedFiles files from '$SourceDirectory' to '$DestinationDirectory'" -ForegroundColor Green
