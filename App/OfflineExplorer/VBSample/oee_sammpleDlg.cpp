// oee_sammpleDlg.cpp : implementation file
//

#include "stdafx.h"
#include "oee_sammple.h"
#include "oee_sammpleDlg.h"
#include ".\oee_sammpledlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// CAboutDlg dialog used for App About

class CAboutDlg : public CDialog
{
public:
	CAboutDlg();

// Dialog Data
	enum { IDD = IDD_ABOUTBOX };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support

// Implementation
protected:
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialog(CAboutDlg::IDD)
{
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialog)
END_MESSAGE_MAP()


// Coee_sammpleDlg dialog



Coee_sammpleDlg::Coee_sammpleDlg(CWnd* pParent /*=NULL*/)
	: CDialog(Coee_sammpleDlg::IDD, pParent)
{
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
	m_MainOE = NULL;
}

void Coee_sammpleDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	DDX_Control(pDX, IDC_TREE, m_Tree);
	DDX_Control(pDX, IDC_ATTACH, m_Attach);
	DDX_Control(pDX, IDC_URL, m_URL);
	DDX_Control(pDX, IDC_START, m_Start);
	DDX_Control(pDX, IDC_STOP, m_Stop);
	DDX_Control(pDX, IDC_LOADTREE, m_LoadTree);
}

BEGIN_MESSAGE_MAP(Coee_sammpleDlg, CDialog)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	//}}AFX_MSG_MAP
	ON_BN_CLICKED(IDC_LOADTREE, OnBnClickedLoadtree)
	ON_BN_CLICKED(IDC_ATTACH, OnBnClickedAttach)
	ON_NOTIFY(TVN_SELCHANGED, IDC_TREE, OnTvnSelchangedTree)
	ON_BN_CLICKED(IDC_START, OnBnClickedStart)
	ON_BN_CLICKED(IDC_STOP, OnBnClickedStop)
END_MESSAGE_MAP()


// Coee_sammpleDlg message handlers

BOOL Coee_sammpleDlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// Add "About..." menu item to system menu.

	// IDM_ABOUTBOX must be in the system command range.
	ASSERT((IDM_ABOUTBOX & 0xFFF0) == IDM_ABOUTBOX);
	ASSERT(IDM_ABOUTBOX < 0xF000);

	CMenu* pSysMenu = GetSystemMenu(FALSE);
	if (pSysMenu != NULL)
	{
		CString strAboutMenu;
		strAboutMenu.LoadString(IDS_ABOUTBOX);
		if (!strAboutMenu.IsEmpty())
		{
			pSysMenu->AppendMenu(MF_SEPARATOR);
			pSysMenu->AppendMenu(MF_STRING, IDM_ABOUTBOX, strAboutMenu);
		}
	}

	// Set the icon for this dialog.  The framework does this automatically
	//  when the application's main window is not a dialog
	SetIcon(m_hIcon, TRUE);			// Set big icon
	SetIcon(m_hIcon, FALSE);		// Set small icon

	// TODO: Add extra initialization here
	m_Images.Create( IDB_TREE, 16, 1, NULL );
	m_Tree.SetImageList( &m_Images, TVSIL_NORMAL );

	return TRUE;  // return TRUE  unless you set the focus to a control
}

void Coee_sammpleDlg::OnSysCommand(UINT nID, LPARAM lParam)
{
	if ((nID & 0xFFF0) == IDM_ABOUTBOX)
	{
		CAboutDlg dlgAbout;
		dlgAbout.DoModal();
	}
	else
	{
		CDialog::OnSysCommand(nID, lParam);
	}
}

void Coee_sammpleDlg::OnBnClickedLoadtree()
{
	long i, j;
	COEFolder folder;
	COEProject project;
	HTREEITEM	root, item;

	if (!m_MainOE)
	{
		AfxMessageBox("Please press \"Load OE\" first!", MB_OK | MB_ICONEXCLAMATION );
		return;
	}
	m_Tree.DeleteAllItems();
	for ( i = 0; i < m_MainOE.get_FoldersCount(); i++ )
	{
		folder = m_MainOE.GetFolder( i );
		root = m_Tree.InsertItem( folder.get_Caption(), 0, 0 );
		m_Tree.SetItemData( root, i );
		for ( j = 0; j < folder.get_ItemsCount(); j++ )
		{
			project = folder.GetItem( j );
			item = m_Tree.InsertItem( project.get_Caption(), 1, 1, root );
			m_Tree.SetItemData( item, j ); 
		}
	}
}

void Coee_sammpleDlg::OnBnClickedAttach()
{
	CString caption = "OE Automation sample";
	if ( m_MainOE ) 
	{
		m_MainOE.Close();
		m_MainOE = NULL;
		m_Attach.SetWindowText( "Load OE" );
		m_LoadTree.EnableWindow( FALSE );
	}
	else 
	{
		CoInitializeEx(NULL,COINIT_MULTITHREADED);
		if ( !m_MainOE.CreateDispatch( "OE.MainOE" ) )
		{
			AfxMessageBox( "OLE Automation object not found. Please run Offline Explorer Enterprise once to register.", MB_OK | MB_ICONSTOP );
			return;
		}
		m_Attach.SetWindowText( "UnLoad OE" );
		caption = m_MainOE.Version();
		m_LoadTree.EnableWindow( TRUE );
	}
	SetWindowText( caption );
}
void Coee_sammpleDlg::OnTvnSelchangedTree(NMHDR *pNMHDR, LRESULT *pResult)
{
	m_Start.EnableWindow( FALSE ); 
	m_Stop.EnableWindow( FALSE ); 
	if ( !m_MainOE ) return;

	LPNMTREEVIEW pNMTreeView = reinterpret_cast<LPNMTREEVIEW>(pNMHDR);
	// TODO: Add your control notification handler code here
	m_URL.SetWindowText( _T("") );

	COEProject project = GetOEProject( pNMTreeView->itemNew.hItem );
	if ( !project ) return;

	m_URL.SetWindowText( project.get_URL() );
	m_Start.EnableWindow( TRUE ); 
	m_Stop.EnableWindow( TRUE ); 
	
	UpdateData();
	*pResult = 0;
}

void Coee_sammpleDlg::OnBnClickedStart()
{
	COEProject project = GetOEProject( m_Tree.GetSelectedItem() );
	if ( !project ) return;
	project.Start();
}

void Coee_sammpleDlg::OnBnClickedStop()
{	
	COEProject project = GetOEProject( m_Tree.GetSelectedItem() );
	if ( !project ) return;
	project.Stop();
}

COEProject Coee_sammpleDlg::GetOEProject(HTREEITEM item)
{
	if ( !item ) return NULL;
	HTREEITEM root = m_Tree.GetParentItem( item );
	if ( !root ) return NULL;
	COEFolder folder = m_MainOE.GetFolder( (long) m_Tree.GetItemData( root ) );
	COEProject project = folder.GetItem( (long) m_Tree.GetItemData( item ) );
	return project;
}
