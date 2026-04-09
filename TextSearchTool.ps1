# ============================================================
#  Text Search Tool - PowerShell WinForms
#  Compatible: PowerShell 2.0+ / Windows 7+
# ============================================================

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName System.ComponentModel

# ------ Main Form ---------------------------------------------------------------------------------------------------------------------------------------------
$form                  = New-Object System.Windows.Forms.Form
$form.Text             = "Text Search Tool"
$form.Size             = New-Object System.Drawing.Size(820, 660)
$form.StartPosition    = "CenterScreen"
$form.BackColor        = [System.Drawing.Color]::FromArgb(240, 240, 240)
$form.MinimumSize      = New-Object System.Drawing.Size(820, 660)

# ------ Title ------------------------------------------------------------------------------------------------------------------------------------------------------------
$titleLabel            = New-Object System.Windows.Forms.Label
$titleLabel.Text       = "Text Search Tool"
$titleLabel.Font       = New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)
$titleLabel.ForeColor  = [System.Drawing.Color]::FromArgb(0, 120, 215)
$titleLabel.Size       = New-Object System.Drawing.Size(400, 40)
$titleLabel.Location   = New-Object System.Drawing.Point(20, 15)
$form.Controls.Add($titleLabel)

# ------ Row 1: Folder selection ------------------------------------------------------------------------------------------------------
$folderLabel           = New-Object System.Windows.Forms.Label
$folderLabel.Text      = "Search Folder:"
$folderLabel.Font      = New-Object System.Drawing.Font("Segoe UI", 10)
$folderLabel.Size      = New-Object System.Drawing.Size(100, 25)
$folderLabel.Location  = New-Object System.Drawing.Point(20, 70)
$form.Controls.Add($folderLabel)

$folderTextBox         = New-Object System.Windows.Forms.TextBox
$folderTextBox.Text    = (Get-Location).Path
$folderTextBox.Font    = New-Object System.Drawing.Font("Segoe UI", 10)
$folderTextBox.Size    = New-Object System.Drawing.Size(530, 25)
$folderTextBox.Location= New-Object System.Drawing.Point(125, 68)
$folderTextBox.ReadOnly= $true
$folderTextBox.BackColor = [System.Drawing.Color]::White
$form.Controls.Add($folderTextBox)

$browseButton          = New-Object System.Windows.Forms.Button
$browseButton.Text     = "Browse..."
$browseButton.Font     = New-Object System.Drawing.Font("Segoe UI", 10)
$browseButton.Size     = New-Object System.Drawing.Size(90, 27)
$browseButton.Location = New-Object System.Drawing.Point(665, 67)
$browseButton.BackColor= [System.Drawing.Color]::FromArgb(220, 220, 220)
$browseButton.FlatStyle= [System.Windows.Forms.FlatStyle]::Flat
$form.Controls.Add($browseButton)

# ------ Row 2: Extension + Search Word ---------------------------------------------------------------------------------
$extLabel              = New-Object System.Windows.Forms.Label
$extLabel.Text         = "Extension:"
$extLabel.Font         = New-Object System.Drawing.Font("Segoe UI", 10)
$extLabel.Size         = New-Object System.Drawing.Size(75, 25)
$extLabel.Location     = New-Object System.Drawing.Point(20, 110)
$form.Controls.Add($extLabel)

$extTextBox            = New-Object System.Windows.Forms.TextBox
$extTextBox.Text       = "txt"
$extTextBox.Font       = New-Object System.Drawing.Font("Segoe UI", 10)
$extTextBox.Size       = New-Object System.Drawing.Size(110, 25)
$extTextBox.Location   = New-Object System.Drawing.Point(100, 108)
$form.Controls.Add($extTextBox)

$wordLabel             = New-Object System.Windows.Forms.Label
$wordLabel.Text        = "Search Word:"
$wordLabel.Font        = New-Object System.Drawing.Font("Segoe UI", 10)
$wordLabel.Size        = New-Object System.Drawing.Size(90, 25)
$wordLabel.Location    = New-Object System.Drawing.Point(230, 110)
$form.Controls.Add($wordLabel)

$wordTextBox           = New-Object System.Windows.Forms.TextBox
$wordTextBox.Font      = New-Object System.Drawing.Font("Segoe UI", 10)
$wordTextBox.Size      = New-Object System.Drawing.Size(220, 25)
$wordTextBox.Location  = New-Object System.Drawing.Point(325, 108)
$form.Controls.Add($wordTextBox)

# ------ Row 3: Options ---------------------------------------------------------------------------------------------------------------------------------
$caseCheckbox          = New-Object System.Windows.Forms.CheckBox
$caseCheckbox.Text     = "Case Sensitive"
$caseCheckbox.Font     = New-Object System.Drawing.Font("Segoe UI", 10)
$caseCheckbox.Size     = New-Object System.Drawing.Size(130, 25)
$caseCheckbox.Location = New-Object System.Drawing.Point(20, 148)
$form.Controls.Add($caseCheckbox)

$recurseCheckbox       = New-Object System.Windows.Forms.CheckBox
$recurseCheckbox.Text  = "Search Subfolders"
$recurseCheckbox.Font  = New-Object System.Drawing.Font("Segoe UI", 10)
$recurseCheckbox.Size  = New-Object System.Drawing.Size(155, 25)
$recurseCheckbox.Location = New-Object System.Drawing.Point(165, 148)
$form.Controls.Add($recurseCheckbox)

# ------ Buttons: Search + Cancel ---------------------------------------------------------------------------------------------------
$searchButton          = New-Object System.Windows.Forms.Button
$searchButton.Text     = "Search"
$searchButton.Font     = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
$searchButton.BackColor= [System.Drawing.Color]::FromArgb(0, 120, 215)
$searchButton.ForeColor= [System.Drawing.Color]::White
$searchButton.Size     = New-Object System.Drawing.Size(100, 35)
$searchButton.Location = New-Object System.Drawing.Point(560, 140)
$searchButton.FlatStyle= [System.Windows.Forms.FlatStyle]::Flat
$form.Controls.Add($searchButton)

$cancelButton          = New-Object System.Windows.Forms.Button
$cancelButton.Text     = "Cancel"
$cancelButton.Font     = New-Object System.Drawing.Font("Segoe UI", 10)
$cancelButton.BackColor= [System.Drawing.Color]::FromArgb(200, 60, 60)
$cancelButton.ForeColor= [System.Drawing.Color]::White
$cancelButton.Size     = New-Object System.Drawing.Size(100, 35)
$cancelButton.Location = New-Object System.Drawing.Point(670, 140)
$cancelButton.FlatStyle= [System.Windows.Forms.FlatStyle]::Flat
$cancelButton.Enabled  = $false
$form.Controls.Add($cancelButton)

# ------ Results area ---------------------------------------------------------------------------------------------------------------------------------------
$resultsLabel          = New-Object System.Windows.Forms.Label
$resultsLabel.Text     = "Results:"
$resultsLabel.Font     = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
$resultsLabel.Size     = New-Object System.Drawing.Size(100, 25)
$resultsLabel.Location = New-Object System.Drawing.Point(20, 190)
$form.Controls.Add($resultsLabel)

$resultsPanel          = New-Object System.Windows.Forms.Panel
$resultsPanel.Size     = New-Object System.Drawing.Size(760, 390)
$resultsPanel.Location = New-Object System.Drawing.Point(20, 215)
$resultsPanel.AutoScroll = $true
$resultsPanel.BackColor= [System.Drawing.Color]::White
$resultsPanel.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle
$form.Controls.Add($resultsPanel)

# ------ Status bar ---------------------------------------------------------------------------------------------------------------------------------------------
$statusLabel           = New-Object System.Windows.Forms.Label
$statusLabel.Text      = "Ready"
$statusLabel.Font      = New-Object System.Drawing.Font("Segoe UI", 9)
$statusLabel.ForeColor = [System.Drawing.Color]::Gray
$statusLabel.Size      = New-Object System.Drawing.Size(760, 22)
$statusLabel.Location  = New-Object System.Drawing.Point(20, 618)
$form.Controls.Add($statusLabel)

# ------ Helper: open file ------------------------------------------------------------------------------------------------------------------------
function Open-File {
    param([string]$filePath)
    try {
        Start-Process $filePath
        $statusLabel.Text      = "Opened: $([System.IO.Path]::GetFileName($filePath))"
        $statusLabel.ForeColor = [System.Drawing.Color]::Green
    } catch {
        $statusLabel.Text      = "Error opening file: $($_.Exception.Message)"
        $statusLabel.ForeColor = [System.Drawing.Color]::Red
    }
}

# ------ Helper: reveal in Explorer ---------------------------------------------------------------------------------------------
function Open-ContainingFolder {
    param([string]$filePath)
    try {
        Start-Process explorer.exe -ArgumentList "/select,`"$filePath`""
    } catch {
        $statusLabel.Text      = "Error opening folder: $($_.Exception.Message)"
        $statusLabel.ForeColor = [System.Drawing.Color]::Red
    }
}

# ------ Helper: build a result button with context menu ------------------------------
function New-ResultButton {
    param([int]$index, [string]$filePath, [int]$yPos)

    $btn               = New-Object System.Windows.Forms.Button
    $btn.Text          = "$index.  $([System.IO.Path]::GetFileName($filePath))   ---   $([System.IO.Path]::GetDirectoryName($filePath))"
    $btn.Font          = New-Object System.Drawing.Font("Segoe UI", 9)
    $btn.Size          = New-Object System.Drawing.Size(730, 35)
    $btn.Location      = New-Object System.Drawing.Point(10, $yPos)
    $btn.TextAlign     = [System.Drawing.ContentAlignment]::MiddleLeft
    $btn.BackColor     = [System.Drawing.Color]::FromArgb(250, 250, 250)
    $btn.FlatStyle     = [System.Windows.Forms.FlatStyle]::Flat
    $btn.Tag           = $filePath

    # Hover
    $btn.Add_MouseEnter({
        $this.BackColor = [System.Drawing.Color]::FromArgb(225, 240, 255)
        $this.Cursor    = [System.Windows.Forms.Cursors]::Hand
    })
    $btn.Add_MouseLeave({
        $this.BackColor = [System.Drawing.Color]::FromArgb(250, 250, 250)
    })

    # Left-click --- open
    $btn.Add_Click({ Open-File -filePath $this.Tag })

    # Right-click context menu
    $ctxMenu = New-Object System.Windows.Forms.ContextMenuStrip

    $menuOpen = New-Object System.Windows.Forms.ToolStripMenuItem
    $menuOpen.Text = "Open file"
    $menuOpen.Add_Click({ Open-File -filePath $btn.Tag })

    $menuFolder = New-Object System.Windows.Forms.ToolStripMenuItem
    $menuFolder.Text = "Open containing folder"
    $menuFolder.Add_Click({ Open-ContainingFolder -filePath $btn.Tag })

    $menuCopyPath = New-Object System.Windows.Forms.ToolStripMenuItem
    $menuCopyPath.Text = "Copy full path"
    $menuCopyPath.Add_Click({ [System.Windows.Forms.Clipboard]::SetText($btn.Tag) })

    $menuCopyName = New-Object System.Windows.Forms.ToolStripMenuItem
    $menuCopyName.Text = "Copy file name"
    $menuCopyName.Add_Click({
        [System.Windows.Forms.Clipboard]::SetText([System.IO.Path]::GetFileName($btn.Tag))
    })

    $ctxMenu.Items.Add($menuOpen)    | Out-Null
    $ctxMenu.Items.Add($menuFolder)  | Out-Null
    $ctxMenu.Items.Add((New-Object System.Windows.Forms.ToolStripSeparator)) | Out-Null
    $ctxMenu.Items.Add($menuCopyPath)| Out-Null
    $ctxMenu.Items.Add($menuCopyName)| Out-Null

    $btn.ContextMenuStrip = $ctxMenu
    return $btn
}

# ------ Search function (runs in background using PowerShell job) -------------------------------------------------------------------
function Start-Search {
    if ($script:searching) { return }
    
    $ext        = $extTextBox.Text.Trim().TrimStart('.')
    $searchWord = $wordTextBox.Text.Trim()
    $folder     = $folderTextBox.Text.Trim()
    $caseSensitive = $caseCheckbox.Checked
    $recurse       = $recurseCheckbox.Checked

    if ([string]::IsNullOrWhiteSpace($searchWord)) {
        [System.Windows.Forms.MessageBox]::Show(
            "Please enter a search word.", "Input Required",
            [System.Windows.Forms.MessageBoxButtons]::OK,
            [System.Windows.Forms.MessageBoxIcon]::Warning)
        return
    }

    if (-not (Test-Path $folder)) {
        [System.Windows.Forms.MessageBox]::Show(
            "The selected folder does not exist.", "Invalid Folder",
            [System.Windows.Forms.MessageBoxButtons]::OK,
            [System.Windows.Forms.MessageBoxIcon]::Warning)
        return
    }

    if ([string]::IsNullOrEmpty($ext)) { $ext = "*" }

    $resultsPanel.Controls.Clear()
    $searchButton.Enabled  = $false
    $cancelButton.Enabled  = $true
    $form.Cursor           = [System.Windows.Forms.Cursors]::WaitCursor
    $statusLabel.Text      = "Starting search..."
    $statusLabel.ForeColor = [System.Drawing.Color]::FromArgb(0, 100, 180)
    
    $script:searching = $true
    
    # Run search in a background PowerShell job
    $script:searchJob = Start-Job -Name "FileSearch" -ScriptBlock {
        param($path, $ext, $word, $caseSensitive, $recurse)
        
        # Get files
        if ($ext -eq "*") {
            if ($recurse) {
                $files = Get-ChildItem -Path $path -Recurse -ErrorAction SilentlyContinue | Where-Object { -not $_.PSIsContainer }
            } else {
                $files = Get-ChildItem -Path $path -ErrorAction SilentlyContinue | Where-Object { -not $_.PSIsContainer }
            }
        } else {
            if ($recurse) {
                $files = Get-ChildItem -Path $path -Filter "*.$ext" -Recurse -ErrorAction SilentlyContinue | Where-Object { -not $_.PSIsContainer }
            } else {
                $files = Get-ChildItem -Path $path -Filter "*.$ext" -ErrorAction SilentlyContinue | Where-Object { -not $_.PSIsContainer }
            }
        }
        
        $total = @($files).Count
        $results = @()
        $index = 0
        
        foreach ($file in $files) {
            $index++
            try {
                $hit = Select-String -Path $file.FullName `
                                     -Pattern $word `
                                     -SimpleMatch `
                                     -CaseSensitive:$caseSensitive `
                                     -Quiet `
                                     -ErrorAction SilentlyContinue
                if ($hit) {
                    $results += $file.FullName
                }
            } catch {
                # Skip unreadable files
            }
        }
        
        return @{ Results = $results; Total = $total }
    } -ArgumentList $folder, $ext, $searchWord, $caseSensitive, $recurse
    
    # Timer to check job status
    $script:timer = New-Object System.Windows.Forms.Timer
    $script:timer.Interval = 100
    $script:timer.Add_Tick({
        if ($script:searchJob.State -ne "Running") {
            $script:timer.Stop()
            $script:searching = $false
            $searchButton.Enabled = $true
            $cancelButton.Enabled = $false
            $form.Cursor = [System.Windows.Forms.Cursors]::Default
            
            if ($script:searchJob.State -eq "Completed") {
                $result = Receive-Job -Job $script:searchJob
                $results = $result.Results
                $total = $result.Total
                
                $resultsPanel.Controls.Clear()
                
                if ($results.Count -eq 0) {
                    $noLabel = New-Object System.Windows.Forms.Label
                    $noLabel.Text = "No matching files found."
                    $noLabel.Font = New-Object System.Drawing.Font("Segoe UI", 10)
                    $noLabel.ForeColor = [System.Drawing.Color]::Gray
                    $noLabel.Size = New-Object System.Drawing.Size(730, 30)
                    $noLabel.Location = New-Object System.Drawing.Point(10, 15)
                    $noLabel.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
                    $resultsPanel.Controls.Add($noLabel)
                    
                    $statusLabel.Text = "No matches found. ($total file(s) scanned)"
                    $statusLabel.ForeColor = [System.Drawing.Color]::Red
                } else {
                    $yPos = 10
                    for ($i = 0; $i -lt $results.Count; $i++) {
                        $btn = New-ResultButton -index ($i + 1) -filePath $results[$i] -yPos $yPos
                        $resultsPanel.Controls.Add($btn)
                        $yPos += 45
                    }
                    $statusLabel.Text = "Found $($results.Count) match(es) in $total file(s) scanned. Left-click to open -- Right-click for more options."
                    $statusLabel.ForeColor = [System.Drawing.Color]::Green
                }
            } elseif ($script:searchJob.State -eq "Failed") {
                $statusLabel.Text = "Search failed: $($script:searchJob.JobStateInfo.Reason.Message)"
                $statusLabel.ForeColor = [System.Drawing.Color]::Red
            }
            
            Remove-Job -Job $script:searchJob -Force
        } else {
            $statusLabel.Text = "Searching... (processing files)"
            $statusLabel.ForeColor = [System.Drawing.Color]::FromArgb(0, 100, 180)
            [System.Windows.Forms.Application]::DoEvents()
        }
    })
    $script:timer.Start()
}

# ------ Cancel search ---------------------------------------------------------------------------------------------------------------------------------------
$cancelButton.Add_Click({
    if ($script:searching -and $script:searchJob) {
        Stop-Job -Job $script:searchJob
        $script:timer.Stop()
        $script:searching = $false
        $searchButton.Enabled = $true
        $cancelButton.Enabled = $false
        $form.Cursor = [System.Windows.Forms.Cursors]::Default
        $statusLabel.Text = "Search cancelled."
        $statusLabel.ForeColor = [System.Drawing.Color]::Orange
        Remove-Job -Job $script:searchJob -Force
    }
})

# ------ Browse button ---------------------------------------------------------------------------------------------------------------------------------------
$browseButton.Add_Click({
    $dlg = New-Object System.Windows.Forms.FolderBrowserDialog
    $dlg.Description         = "Select the folder to search in"
    $dlg.SelectedPath        = $folderTextBox.Text
    $dlg.ShowNewFolderButton = $false
    if ($dlg.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
        $folderTextBox.Text = $dlg.SelectedPath
    }
})

# ------ Wire up Search button + Enter key ------------------------------------------------------------------------
$searchButton.Add_Click({ Start-Search })
$wordTextBox.Add_KeyDown({
    if ($_.KeyCode -eq [System.Windows.Forms.Keys]::Enter) { Start-Search }
})

# ------ Initialize script variables -------------------------------------------------------------------------------------------------------------------------
$script:searching = $false
$script:searchJob = $null
$script:timer = $null

# ------ Initial focus ---------------------------------------------------------------------------------------------------------------------------------------
$wordTextBox.Select()

# ------ Launch ------------------------------------------------------------------------------------------------------------------------------------------------------------
$form.ShowDialog() | Out-Null