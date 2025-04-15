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
    $comboBox = New-Object System.Windows.Forms.ComboBox
    $comboBox.Location = New-Object System.Drawing.Point(190, 40)
    $comboBox.Size = New-Object System.Drawing.Size(200, 30)
    $comboBox.Items.AddRange(@("Chrome", "7-Zip", "Notepad++", "VLC", "Git"))
    $comboBox.DropDownStyle = 'DropDownList'
    $mainPanel.Controls.Add($comboBox)

    # === Label: Enter Hostname ===
    $labelHost = New-Object System.Windows.Forms.Label
    $labelHost.Text = "Enter hostname"
    $labelHost.Location = New-Object System.Drawing.Point(190, 75)
    $labelHost.ForeColor = "White"
    $labelHost.AutoSize = $true
    $mainPanel.Controls.Add($labelHost)

    # === TextBox: Hostname input ===
    $hostInput = New-Object System.Windows.Forms.TextBox
    $hostInput.Location = New-Object System.Drawing.Point(190, 95)
    $hostInput.Size = New-Object System.Drawing.Size(200, 30)
    $hostInput.ForeColor = "Black"
    $mainPanel.Controls.Add($hostInput)

    # === RadioButton: Install ===
    $radioInstall = New-Object System.Windows.Forms.RadioButton
    $radioInstall.Text = "Install"
    $radioInstall.Location = New-Object System.Drawing.Point(190, 140)
    $radioInstall.ForeColor = "White"
    $radioInstall.AutoSize = $true
    $mainPanel.Controls.Add($radioInstall)

    # === RadioButton: Uninstall ===
    $radioUninstall = New-Object System.Windows.Forms.RadioButton
    $radioUninstall.Text = "Uninstall"
    $radioUninstall.Location = New-Object System.Drawing.Point(260, 140)
    $radioUninstall.ForeColor = "White"
    $radioUninstall.AutoSize = $true
    $mainPanel.Controls.Add($radioUninstall)

    # === Button: Submit ===
    $button = New-Object System.Windows.Forms.Button
    $button.Text = "Execute"
    $button.Size = New-Object System.Drawing.Size(120, 40)
    $button.Location = New-Object System.Drawing.Point(200, 190)
    $button.BackColor = "#444444"
    $button.ForeColor = "White"
    $button.FlatStyle = "Flat"
    $button.Add_Click({
        $software = $comboBox.SelectedItem
        $hostname = $hostInput.Text
        $action = if ($radioInstall.Checked) { "Install" } elseif ($radioUninstall.Checked) { "Uninstall" } else { "None" }

        Write-Host "Action: $action | Software: $software | Host: $hostname"
    })

    $mainPanel.Controls.Add($button)
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
$installBtn.Text = "  Home"
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
$toolsBtn.Text = "  Settings"
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
$searchBtn.Text = "  About"
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

# === Default View ===
$installBtn.PerformClick()

# === Run ===
[System.Windows.Forms.Application]::Run($form)
