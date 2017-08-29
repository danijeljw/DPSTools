function tree {

   [void][System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
   [void][System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")

   # create Window
   $Form = New-Object System.Windows.Forms.Form
   $Form.Text = "Files"
   $Form.Size = New-Object System.Drawing.Size(390, 390)
   # create Treeview-Object
   $TreeView = New-Object System.Windows.Forms.TreeView
   $TreeView.Location = New-Object System.Drawing.Point(48, 12)
   $TreeView.Size = New-Object System.Drawing.Size(290, 322)
   $Form.Controls.Add($TreeView)

   ###### Add Nodes to Treeview
   $rootnode = New-Object System.Windows.Forms.TreeNode
   $rootnode.text = "Root"
   $rootnode.name = "Root"
   [void]$TreeView.Nodes.Add($rootnode)

   #here i'm going to import the csv file into an array
   $array=@(Get-ChildItem -Path C:\)
   Write-Host $array
   foreach ( $obj in $array ) {                                                                                                             
        Write-Host $obj
        $subnode = New-Object System.Windows.Forms.TreeNode
        $subnode.text = $obj
        [void]$rootnode.Nodes.Add($subnode)
     }

   # Show Form // this always needs to be at the bottom of the script!
   $Form.Add_Shown({$Form.Activate()})
   [void] $Form.ShowDialog()

   }
tree