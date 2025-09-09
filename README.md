# Enhanced Media Library Structure Copy Script

A PowerShell script designed to replicate the directory structure of media libraries while selectively copying files and excluding large media files to save space and transfer time.  

This script will copy all files/types in the folder structure unless specifically excluded, default exclusions listed below.

## Overview

This script is perfect for scenarios where you need to:
- Back up your media library's organizational structure and metadata
- Create a lightweight copy of your media collection for indexing or cataloging
- Migrate folder structures without transferring large video/audio files
- Preserve accompanying files like subtitles, thumbnails, and metadata while excluding the actual media

## Features

- **Selective File Copying**: Excludes large media files while preserving folder structure
- **Comprehensive Format Support**: Recognizes and excludes various video, audio, disc image, and archive formats
- **Interactive Setup**: Prompts for source and destination directories
- **Progress Tracking**: Real-time progress updates during the copy process
- **Statistics Display**: Shows file counts, sizes, and space savings
- **Error Handling**: Gracefully handles copy failures with detailed error messages
- **Automatic Directory Creation**: Creates destination directories as needed

## Excluded File Types

The script automatically excludes the following file types:

### Video Files
- `.mkv`, `.mp4`, `.avi`, `.mov`, `.wmv`, `.flv`, `.webm`, `.m4v`, `.3gp`
- `.mpg`, `.mpeg`, `.m2v`, `.ts`, `.mts`, `.m2ts`, `.vob`, `.ogv`, `.divx`

### High-Quality Audio Files
- `.flac`, `.ape`, `.wav`, `.dsd`, `.dsf`, `.dff`

### Disc Images
- `.iso`, `.img`, `.bin`, `.nrg`, `.mdf`, `.cue`

### Archives
- `.zip`, `.rar`, `.7z`, `.tar`, `.gz`, `.bz2`

## What Gets Copied

The script will copy all other files such as:
- Subtitle files (`.srt`, `.sub`, `.vtt`, etc.)
- Metadata files (`.nfo`, `.xml`, etc.)
- Thumbnail and poster images (`.jpg`, `.png`, `.gif`, etc.)
- Text files (`.txt`, `.md`, etc.)
- Smaller audio files (`.mp3`, `.m4a`, `.ogg`, etc.)
- Any other files not in the exclusion list

## Usage

### Prerequisites
- Windows PowerShell 5.1 or PowerShell 7+
- Read access to source directory
- Write access to destination directory (or its parent for creation)

### Running the Script

1. **Download the script** to your local machine
2. **Open PowerShell** as Administrator (recommended)
3. **Navigate** to the script directory
4. **Run the script**:
   ```powershell
   .\copystructure.ps1
   ```
5. **Follow the prompts**:
   - Enter the source directory path when prompted
   - Enter the destination directory path when prompted
6. **Monitor progress** as the script processes your media library

### Example Session

```
Enter the source directory path: C:\Media\Movies
Enter the destination directory path: C:\Backup\Movies-Structure

Excluded file types:
  .7z
  .ape
  .avi
  [... full list displayed ...]

Scanning directory structure...
Creating directory structure...
Finding files to copy (excluding large media files)...

File Statistics:
  Files to copy: 1,247 (234.56 MB)
  Files excluded: 423 (1.2 TB)
  Space saved: 1.2 TB

Copying 1,247 files...
Copied 10 of 1,247 files...
Copied 20 of 1,247 files...
[... progress continues ...]

Directory structure and selected files copied successfully.
Copied 1,247 files from 'C:\Media\Movies' to 'C:\Backup\Movies-Structure'
Space saved by excluding large files: 1.2 TB
```

## Use Cases

### Media Library Backup
Create a lightweight backup of your media organization without the storage overhead of actual video files.

### Migration Preparation
Prepare for media server migrations by copying folder structures and metadata while leaving large files for separate transfer.

### Cataloging and Indexing
Generate a complete directory structure with metadata for cataloging purposes without requiring terabytes of storage.

### Remote Synchronization
Sync folder structures and small files to remote locations without bandwidth concerns.

## Customization

### Modifying Excluded Extensions

To customize which file types are excluded, edit the `$ExcludedExtensions` array at the top of the script:

```powershell
$ExcludedExtensions = @(
    # Add or remove extensions as needed
    ".your_extension_here"
)
```

### Including High-Quality Audio

If you want to include high-quality audio files like FLAC, remove them from the exclusion list:

```powershell
# Comment out or remove these lines:
# ".flac", ".ape", ".wav", ".dsd", ".dsf", ".dff",
```

## Error Handling

The script includes robust error handling:
- Validates source directory existence before proceeding
- Creates destination directories automatically
- Reports individual file copy failures without stopping the entire process
- Provides detailed error messages for troubleshooting

## Performance Considerations

- **Large Libraries**: For very large media libraries (10,000+ files), the initial scan may take several minutes
- **Network Drives**: Performance may be slower when working with network-attached storage
- **Progress Updates**: Progress is displayed every 10 files to balance information and performance

## Requirements

- **Operating System**: Windows 10/11 or Windows Server 2016+
- **PowerShell**: Version 5.1 or later
- **Permissions**: Read access to source, write access to destination
- **Storage**: Sufficient space in destination for small files and folder structure

## Contributing

Feel free to submit issues, feature requests, or pull requests to improve the script functionality.

## License

This script is provided as-is for personal and commercial use. Modify and distribute freely.

---

**Note**: Always test the script on a small subset of your media library before running it on your entire collection to ensure it meets your specific needs.
