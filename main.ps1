Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# === Main Form ===
$form = New-Object System.Windows.Forms.Form
$form.Text = "PowerShell GUI Example"
$form.Size = New-Object System.Drawing.Size(800, 500)
$form.StartPosition = "CenterScreen"
$form.BackColor = [System.Drawing.Color]::FromArgb(32, 33, 36)
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false

# === Sidebar ===
$sidebar = New-Object System.Windows.Forms.Panel
$sidebar.Dock = "Left"
$sidebar.Width = 180
$sidebar.BackColor = [System.Drawing.Color]::FromArgb(52, 53, 65)
$form.Controls.Add($sidebar)

# === Main Panel ===
$mainPanel = New-Object System.Windows.Forms.Panel
$mainPanel.Dock = "Fill"
$mainPanel.BackColor = [System.Drawing.Color]::FromArgb(40, 40, 40)
$form.Controls.Add($mainPanel)

# === Icon Loader (update to your paths!) ===
function Load-Icon($path) {
    return [System.Drawing.Image]::FromFile($path)
}
$iconInstall     = Load-Icon "C:\Users\Bjarne\Documents\Code\icons\install.png"
$iconTools = Load-Icon "C:\Users\Bjarne\Documents\Code\icons\tool.png"
$iconSearch    = Load-Icon "C:\Users\Bjarne\Documents\Code\icons\search.png"

# === Highlight Selected Sidebar Button ===
function Highlight-SelectedButton {
    param ($selected)
    foreach ($btn in @($installBtn, $toolsBtn, $searchBtn)) {
        $btn.BackColor = [System.Drawing.Color]::FromArgb(52, 53, 65)
    }
    $selected.BackColor = [System.Drawing.Color]::FromArgb(64, 65, 79)
}

# === View Loaders ===

function Load-Install {
    $mainPanel.Controls.Clear()

     # === Label: Select Software ===
    $labelSoftware = New-Object System.Windows.Forms.Label
    $labelSoftware.Text = "Select software"
    $labelSoftware.Location = New-Object System.Drawing.Point(190, 20)
    $labelSoftware.ForeColor = "White"
    $labelSoftware.AutoSize = $true
    $mainPanel.Controls.Add($labelSoftware)

    # === ComboBox: Software selection ===
    $script:comboBox = New-Object System.Windows.Forms.ComboBox
    $script:comboBox.Location = New-Object System.Drawing.Point(190, 40)
    $script:comboBox.Size = New-Object System.Drawing.Size(200, 30)
    $script:comboBox.Items.AddRange(@("Chrome", "7-Zip", "Notepad++", "VLC", "Git"))
    $script:comboBox.DropDownStyle = 'DropDownList'
    $mainPanel.Controls.Add($script:comboBox)

    # === Label: Enter Hostname ===
    $labelHost = New-Object System.Windows.Forms.Label
    $labelHost.Text = "Enter hostname"
    $labelHost.Location = New-Object System.Drawing.Point(190, 75)
    $labelHost.ForeColor = "White"
    $labelHost.AutoSize = $true
    $mainPanel.Controls.Add($labelHost)

    # === TextBox: Hostname input ===
    $script:hostInput = New-Object System.Windows.Forms.TextBox
    $script:hostInput.Location = New-Object System.Drawing.Point(190, 95)
    $script:hostInput.Size = New-Object System.Drawing.Size(200, 30)
    $script:hostInput.ForeColor = "Black"
    $mainPanel.Controls.Add($script:hostInput)

    # === RadioButton: Install ===
    $script:radioInstall = New-Object System.Windows.Forms.RadioButton
    $script:radioInstall.Text = "Install"
    $script:radioInstall.Location = New-Object System.Drawing.Point(190, 140)
    $script:radioInstall.ForeColor = "White"
    $script:radioInstall.AutoSize = $true
    $mainPanel.Controls.Add($script:radioInstall)

    # === RadioButton: Uninstall ===
    $script:radioUninstall = New-Object System.Windows.Forms.RadioButton
    $script:radioUninstall.Text = "Uninstall"
    $script:radioUninstall.Location = New-Object System.Drawing.Point(260, 140)
    $script:radioUninstall.ForeColor = "White"
    $script:radioUninstall.AutoSize = $true
    $mainPanel.Controls.Add($script:radioUninstall)

    # === Button: Submit ===
    $script:button = New-Object System.Windows.Forms.Button
    $script:button.Text = "Execute"
    $script:button.Size = New-Object System.Drawing.Size(120, 40)
    $script:button.Location = New-Object System.Drawing.Point(200, 190)
    $script:button.BackColor = "#444444"
    $script:button.ForeColor = "White"
    $script:button.FlatStyle = "Flat"
    $script:button.Add_Click({
        $software = $script:comboBox.SelectedItem
        $hostname = $script:hostInput.Text
        $action = if ($script:radioInstall.Checked) { "Install" } elseif ($script:radioUninstall.Checked) { "Uninstall" } else { "None" }

        Write-Host "Action: $action | Software: $software | Host: $hostname"
    })

    $mainPanel.Controls.Add($script:button)
}

function Load-Tools {
    $mainPanel.Controls.Clear()

    $checkbox = New-Object System.Windows.Forms.CheckBox
    $checkbox.Text = "Enable feature"
    $checkbox.ForeColor = "White"
    $checkbox.Location = New-Object System.Drawing.Point(190, 100)
    $checkbox.AutoSize = $true
    $mainPanel.Controls.Add($checkbox)
}

function Load-Search {
    $mainPanel.Controls.Clear()

    $label = New-Object System.Windows.Forms.Label
    $label.Text = "This is a PowerShell GUI example."
    $label.ForeColor = "White"
    $label.AutoSize = $true
    $label.Font = New-Object System.Drawing.Font("Segoe UI", 12, [System.Drawing.FontStyle]::Bold)
    $label.Location = New-Object System.Drawing.Point(190, 40)
    $mainPanel.Controls.Add($label)
}

# === Sidebar Buttons ===

$installBtn = New-Object System.Windows.Forms.Button
$installBtn.Text = "  Software"
$installBtn.Image = $iconInstall
$installBtn.TextAlign = 'MiddleLeft'
$installBtn.ImageAlign = 'MiddleLeft'
$installBtn.TextImageRelation = 'ImageBeforeText'
$installBtn.Size = New-Object System.Drawing.Size(160, 40)
$installBtn.Location = New-Object System.Drawing.Point(10, 30)
$installBtn.ForeColor = "White"
$installBtn.BackColor = [System.Drawing.Color]::FromArgb(52, 53, 65)
$installBtn.FlatStyle = "Flat"
$installBtn.FlatAppearance.BorderSize = 0
$installBtn.Font = New-Object System.Drawing.Font("Segoe UI", 10)
$installBtn.Add_Click({
    Highlight-SelectedButton $installBtn
    Load-Install
})

$toolsBtn = New-Object System.Windows.Forms.Button
$toolsBtn.Text = "  Tools"
$toolsBtn.Image = $iconTools
$toolsBtn.TextAlign = 'MiddleLeft'
$toolsBtn.ImageAlign = 'MiddleLeft'
$toolsBtn.TextImageRelation = 'ImageBeforeText'
$toolsBtn.Size = New-Object System.Drawing.Size(160, 40)
$toolsBtn.Location = New-Object System.Drawing.Point(10, 80)
$toolsBtn.ForeColor = "White"
$toolsBtn.BackColor = [System.Drawing.Color]::FromArgb(52, 53, 65)
$toolsBtn.FlatStyle = "Flat"
$toolsBtn.FlatAppearance.BorderSize = 0
$toolsBtn.Font = New-Object System.Drawing.Font("Segoe UI", 10)
$toolsBtn.Add_Click({
    Highlight-SelectedButton $toolsBtn
    Load-Tools
})

$searchBtn = New-Object System.Windows.Forms.Button
$searchBtn.Text = "  Search"
$searchBtn.Image = $iconSearch
$searchBtn.TextAlign = 'MiddleLeft'
$searchBtn.ImageAlign = 'MiddleLeft'
$searchBtn.TextImageRelation = 'ImageBeforeText'
$searchBtn.Size = New-Object System.Drawing.Size(160, 40)
$searchBtn.Location = New-Object System.Drawing.Point(10, 130)
$searchBtn.ForeColor = "White"
$searchBtn.BackColor = [System.Drawing.Color]::FromArgb(52, 53, 65)
$searchBtn.FlatStyle = "Flat"
$searchBtn.FlatAppearance.BorderSize = 0
$searchBtn.Font = New-Object System.Drawing.Font("Segoe UI", 10)
$searchBtn.Add_Click({
    Highlight-SelectedButton $searchBtn
    Load-Search
})

# === Add Buttons to Sidebar ===
$sidebar.Controls.AddRange(@($installBtn, $toolsBtn, $searchBtn))

# === Default View (fires once form is shown) ===
$form.Add_Shown({
    $installBtn.PerformClick()  # Simulate click to load the Install view by default
})

# === Run ===
[System.Windows.Forms.Application]::Run($form)
