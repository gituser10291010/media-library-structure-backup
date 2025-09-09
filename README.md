# CopyStructure - Media Library Backup Script

A PowerShell script designed to backup media library folder structures while excluding large video files (.mkv and .mp4). Perfect for preserving metadata, subtitles, artwork, and other supporting files without consuming excessive storage space.

## 📋 Overview

This script creates a complete mirror of your media library's directory structure and copies all non-video files, making it ideal for:
- Backing up Plex/Jellyfin/Emby metadata
- Preserving subtitle files, artwork, and NFO files
- Creating lightweight backups without large video files
- Maintaining folder organization for later restoration

## 🚀 Features

- **Interactive prompts** for source and destination directories
- **Automatic directory creation** if destination doesn't exist
- **Complete folder structure replication**
- **Selective file copying** (excludes .mkv and .mp4 files)
- **Progress tracking** with periodic status updates
- **Error handling** for invalid paths
- **Force overwrite** of existing files

## 📋 Prerequisites

- Windows PowerShell 5.1 or PowerShell Core 6.0+
- Appropriate read permissions on source directory
- Write permissions on destination directory (or parent folder for creation)

## 🛠️ Installation

1. Download the `copystructure.ps1` script
2. Place it in a convenient location
3. Ensure PowerShell execution policy allows script execution:
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```

## 📖 Usage

### Basic Usage

1. Open PowerShell as Administrator (recommended)
2. Navigate to the script location or provide full path
3. Run the script:
   ```powershell
   .\copystructure.ps1
   ```

### Interactive Prompts

The script will prompt you for:
1. **Source directory path**: Your media library root folder
2. **Destination directory path**: Where the backup should be created

### Example Session

```
PS C:\Scripts> .\copystructure.ps1
Enter the source directory path: D:\MediaLibrary
Enter the destination directory path: E:\Backup\MediaLibrary
Creating destination directory: E:\Backup\MediaLibrary
Scanning directory structure...
Creating directory structure...
Creating directory: E:\Backup\MediaLibrary\Movies\Action
Creating directory: E:\Backup\MediaLibrary\TV Shows\Drama
Finding non-video files to copy...
Copying 1250 files...
Copied 10 of 1250 files...
Copied 20 of 1250 files...
...
Directory structure and non-video files copied successfully.
Copied 1250 files from 'D:\MediaLibrary' to 'E:\Backup\MediaLibrary'
```

## 📁 What Gets Copied

### ✅ Included Files
- Subtitle files (`.srt`, `.vtt`, `.ass`, etc.)
- Metadata files (`.nfo`, `.xml`)
- Image files (`.jpg`, `.png`, `.webp`, etc.)
- Audio files (`.mp3`, `.flac`, etc.)
- Text files (`.txt`, `.md`)
- Configuration files
- Any other non-video files

### ❌ Excluded Files
- `.mkv` files (Matroska Video)
- `.mp4` files (MPEG-4 Video)

## 🎯 Common Use Cases

### Media Server Backup
```
Source: D:\Plex\Movies
Destination: E:\Backups\Plex\Movies
```

### Migration Preparation
```
Source: \\NAS\MediaLibrary
Destination: D:\Temp\MediaStructure
```

### Metadata Preservation
```
Source: C:\Users\User\Videos\Collection
Destination: D:\Backup\VideoMetadata
```

## ⚠️ Important Notes

- **Disk Space**: While this script excludes large video files, ensure sufficient space for metadata and supporting files
- **Permissions**: Run as Administrator if backing up system directories
- **Network Drives**: Works with UNC paths (`\\server\share`) but may be slower
- **Overwrite Behavior**: Existing files will be overwritten without confirmation
- **Progress Updates**: Status shown every 10 copied files

## 🔧 Customization

### Excluding Additional File Types

To exclude more file types, modify line 32:
```powershell
# Current
$files = Get-ChildItem -Path $SourceDirectory -File -Recurse | Where-Object { $_.Extension -ne ".mkv" -and $_.Extension -ne ".mp4" }

# Add more exclusions
$files = Get-ChildItem -Path $SourceDirectory -File -Recurse | Where-Object { 
    $_.Extension -ne ".mkv" -and 
    $_.Extension -ne ".mp4" -and 
    $_.Extension -ne ".avi" -and 
    $_.Extension -ne ".mov" 
}
```

### Changing Progress Update Frequency

Modify line 48 to change how often progress is displayed:
```powershell
# Update every 50 files instead of 10
if ($copiedFiles % 50 -eq 0) {
```

## 🐛 Troubleshooting

### Common Issues

**"Source directory does not exist"**
- Verify the path is correct and accessible
- Check for typos in the path
- Ensure you have read permissions

**"Access denied"**
- Run PowerShell as Administrator
- Check folder permissions
- Verify destination drive has sufficient space

**Script won't run**
- Check PowerShell execution policy: `Get-ExecutionPolicy`
- Set appropriate policy: `Set-ExecutionPolicy RemoteSigned`

### Performance Tips

- Use local drives when possible for better performance
- Close other applications that might lock files
- Consider running during off-peak hours for large libraries

## 📊 Output Information

The script provides detailed feedback including:
- Directory creation confirmations
- File copy progress updates
- Final summary with total files copied
- Source and destination paths confirmation

## 🤝 Contributing

Feel free to fork this script and submit improvements! Common enhancement areas:
- GUI interface
- Configuration file support
- Additional file type filtering options
- Resume capability for interrupted operations
- Logging to file

## 📄 License

This script is provided as-is for educational and personal use. Modify and distribute freely.

## 📞 Support

For issues or questions:
1. Check the troubleshooting section above
2. Verify your PowerShell version and permissions
3. Test with a small sample directory first
