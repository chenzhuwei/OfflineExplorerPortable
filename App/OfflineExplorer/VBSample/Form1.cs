using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;
using System.Data;

namespace oee_sample
{
	/// <summary>
	/// Summary description for Form1.
	/// </summary>
	public class Form1 : System.Windows.Forms.Form
	{
		private System.Windows.Forms.Button btClose;
		private System.Windows.Forms.GroupBox groupBox1;
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.Label label2;
		private System.Windows.Forms.Button btStart;
		private System.Windows.Forms.Button btStop;
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.Container components = null;
		private System.Windows.Forms.TreeView Tree;
		private System.Windows.Forms.Button btLoadTree;
		private OE.MainOE OE = new OE.MainOEClass();
//		private OE.OEFolder Folder = new OE.OEFolderClass();

		protected ImageList Images;

		public Form1()
		{
			//
			// Required for Windows Form Designer support
			//
			InitializeComponent();
			Application.EnableVisualStyles();
			//
			// TODO: Add any constructor code after InitializeComponent call
			//
		}

		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		protected override void Dispose( bool disposing )
		{
			if( disposing )
			{
				if (components != null) 
				{
					components.Dispose();
				}
			}
			base.Dispose( disposing );
		}

		#region Windows Form Designer generated code
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			System.Resources.ResourceManager resources = new System.Resources.ResourceManager(typeof(Form1));
			this.Tree = new System.Windows.Forms.TreeView();
			this.btLoadTree = new System.Windows.Forms.Button();
			this.btClose = new System.Windows.Forms.Button();
			this.groupBox1 = new System.Windows.Forms.GroupBox();
			this.btStop = new System.Windows.Forms.Button();
			this.btStart = new System.Windows.Forms.Button();
			this.label2 = new System.Windows.Forms.Label();
			this.label1 = new System.Windows.Forms.Label();
			this.groupBox1.SuspendLayout();
			this.SuspendLayout();
			// 
			// Tree
			// 
			this.Tree.HideSelection = false;
			this.Tree.ImageIndex = -1;
			this.Tree.Location = new System.Drawing.Point(8, 8);
			this.Tree.Name = "Tree";
			this.Tree.SelectedImageIndex = -1;
			this.Tree.Size = new System.Drawing.Size(272, 248);
			this.Tree.TabIndex = 0;
			this.Tree.AfterSelect += new System.Windows.Forms.TreeViewEventHandler(this.Tree_AfterSelect);
			// 
			// btLoadTree
			// 
			this.btLoadTree.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.btLoadTree.Location = new System.Drawing.Point(288, 8);
			this.btLoadTree.Name = "btLoadTree";
			this.btLoadTree.TabIndex = 1;
			this.btLoadTree.Text = "Load &Tree";
			this.btLoadTree.Click += new System.EventHandler(this.btLoad_Click);
			// 
			// btClose
			// 
			this.btClose.DialogResult = System.Windows.Forms.DialogResult.Cancel;
			this.btClose.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.btClose.Location = new System.Drawing.Point(288, 40);
			this.btClose.Name = "btClose";
			this.btClose.TabIndex = 3;
			this.btClose.Text = "&Close";
			this.btClose.Click += new System.EventHandler(this.btClose_Click);
			// 
			// groupBox1
			// 
			this.groupBox1.Controls.Add(this.btStop);
			this.groupBox1.Controls.Add(this.btStart);
			this.groupBox1.Controls.Add(this.label2);
			this.groupBox1.Controls.Add(this.label1);
			this.groupBox1.Location = new System.Drawing.Point(8, 264);
			this.groupBox1.Name = "groupBox1";
			this.groupBox1.Size = new System.Drawing.Size(352, 80);
			this.groupBox1.TabIndex = 4;
			this.groupBox1.TabStop = false;
			this.groupBox1.Text = " Project information ";
			// 
			// btStop
			// 
			this.btStop.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.btStop.Location = new System.Drawing.Point(264, 48);
			this.btStop.Name = "btStop";
			this.btStop.TabIndex = 3;
			this.btStop.Text = "S&top";
			this.btStop.Click += new System.EventHandler(this.btStop_Click);
			// 
			// btStart
			// 
			this.btStart.FlatStyle = System.Windows.Forms.FlatStyle.System;
			this.btStart.Location = new System.Drawing.Point(176, 48);
			this.btStart.Name = "btStart";
			this.btStart.TabIndex = 2;
			this.btStart.Text = "&Start";
			this.btStart.Click += new System.EventHandler(this.btStart_Click);
			// 
			// label2
			// 
			this.label2.Location = new System.Drawing.Point(48, 24);
			this.label2.Name = "label2";
			this.label2.Size = new System.Drawing.Size(296, 16);
			this.label2.TabIndex = 1;
			this.label2.Text = "- No project is selected-";
			this.label2.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
			// 
			// label1
			// 
			this.label1.Location = new System.Drawing.Point(8, 24);
			this.label1.Name = "label1";
			this.label1.Size = new System.Drawing.Size(32, 16);
			this.label1.TabIndex = 0;
			this.label1.Text = "URL:";
			this.label1.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
			// 
			// Form1
			// 
			this.AutoScaleBaseSize = new System.Drawing.Size(5, 14);
			this.CancelButton = this.btClose;
			this.ClientSize = new System.Drawing.Size(368, 352);
			this.Controls.Add(this.groupBox1);
			this.Controls.Add(this.btClose);
			this.Controls.Add(this.btLoadTree);
			this.Controls.Add(this.Tree);
			this.Font = new System.Drawing.Font("Tahoma", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((System.Byte)(204)));
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
			this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
			this.MaximizeBox = false;
			this.MinimizeBox = false;
			this.Name = "Form1";
			this.Text = "OEE automation sample";
			this.groupBox1.ResumeLayout(false);
			this.ResumeLayout(false);

		}
		#endregion

		/// <summary>
		/// The main entry point for the application.
		/// </summary>
		[STAThread]
		static void Main() 
		{
			Application.Run(new Form1());
		}

		private void btClose_Click(object sender, System.EventArgs e)
		{
			Close();
		}

		private void btLoad_Click(object sender, System.EventArgs e)
		{
			OE.OEFolder folder;
			OE.OEProject project;
			int i, p = 0;
			int cnt = OE.FoldersCount;
			TreeNode root;
			TreeNode node;

			Tree.BeginUpdate();
			Tree.Nodes.Clear();
			for ( i = 0; i < cnt; i++ ) 
			{
				folder = OE.GetFolder( i );
				root = new TreeNode( folder.Caption );
				root.Tag = folder;
				Tree.Nodes.Add( root );
				for ( p = 0; p < folder.ItemsCount; p++ )
				{
					project = (OE.OEProject) folder.GetItem( p );
					node = new TreeNode( project.Caption );
					root.Nodes.Add( node );
					node.Tag = project;
//					node = Tree.Nodes.Add( root );
//					node.Text = project.Caption;
				}
			}
			Tree.EndUpdate();
		}

		private void Tree_AfterSelect(object sender, System.Windows.Forms.TreeViewEventArgs e)
		{
			if ( e.Node.Parent == null )
			{
				label2.Text = " - ";
			} 
			else 
			{
				OE.OEProject project = e.Node.Tag as OE.OEProject;
				label2.Text = project.URL;
			}
		}

		private void btStart_Click(object sender, System.EventArgs e)
		{
			if ( Tree.SelectedNode == null ) return;
			if ( Tree.SelectedNode.Parent != null )
			{
				OE.OEProject project = Tree.SelectedNode.Tag as OE.OEProject;
				project.Start();
			}
		}

		private void btStop_Click(object sender, System.EventArgs e)
		{
			if ( Tree.SelectedNode == null ) return;
			if ( Tree.SelectedNode.Parent != null )
			{
				OE.OEProject project = Tree.SelectedNode.Tag as OE.OEProject;
				project.Stop();
			}
		}
	}
}
