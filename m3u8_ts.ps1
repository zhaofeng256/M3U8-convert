#requires -Version 5.1

if ($args.count -ne 1 -or -Not $args[0].ToString().EndsWith(".m3u8")) {
	echo "usage:"
	echo $($args[0]) + "file.m3u8" -NoNewLine
	exit
}

function Write-ColorOutput($ForegroundColor)
{
    # save the current color
    $fc = $host.UI.RawUI.ForegroundColor

    # set the new color
    $host.UI.RawUI.ForegroundColor = $ForegroundColor

    # output
    if ($args) {
        Write-Output $args
    }
    else {
        $input | Write-Output
    }

    # restore the original color
    $host.UI.RawUI.ForegroundColor = $fc
}

function main($source)
{
	Write-ColorOutput red  "start convert..."

	(gc $source) -replace '#.*', '' | Out-File temp.m3u8
	(gc temp.m3u8) -notmatch '^\s*$' | Out-File temp.m3u8

	$line = gc temp.m3u8 -TotalCount 1
	$folder_end = $line.LastIndexOf("/") - 1
	$folder_start= $line.LastIndexOf("/", $folder_end) + 1
	$folder = $line.Substring($folder_start, $folder_end - $folder_start + 1)

	$dir = $(Get-Location).ToString()
	$target = $source.ToString().Replace(".m3u8", ".mp4")
	$target = $target.trim(".\\")
	$tmp_file = $dir + $folder + "/tmp.ts"
	New-Item -ItemType file $tmp_file –force | Out-Null

	$cmd = "copy /b tmp.ts+"
	$cnt = 0
	foreach($line in gc temp.m3u8) {
		$len = $line.Length
		$file_start = $line.LastIndexOf("/") + 1
		$file =  $line.Substring($file_start, $len - $file_start)
		$cmd += $file

		if ($cnt % 1000 -eq 0) {
			if ($cnt -ne 0) {
				$cmd += " tmp.ts >NUL"
				cd $folder
				cmd.exe /c $cmd
				cd ..
				$cmd = "copy /b tmp.ts+"
			}else {
				$cmd += "+"
			}
		} else {
			$cmd += "+"
		}
		$cnt += 1
	}

	if ($cnt % 1000 -ne 1) {
		$cmd = $cmd.Substring(0, $cmd.Length - 1)
		$cmd += " tmp.ts >NUL"
		cd $folder
		cmd.exe /c $cmd
		cd ..
	}

	mv $tmp_file $target -Force
	rm temp.m3u8
	
	Write-ColorOutput green "success !"
	echo ""
	Write-ColorOutput yellow  $target
	echo ""
}

main($args[0])
