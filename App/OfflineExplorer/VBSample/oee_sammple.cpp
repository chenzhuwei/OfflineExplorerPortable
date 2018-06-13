// oee_sammple.cpp : Defines the class behaviors for the application.
//

#include "stdafx.h"
#include "oee_sammple.h"
#include "oee_sammpleDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// Coee_sammpleApp

BEGIN_MESSAGE_MAP(Coee_sammpleApp, CWinApp)
	ON_COMMAND(ID_HELP, CWinApp::OnHelp)
END_MESSAGE_MAP()


// Coee_sammpleApp construction

Coee_sammpleApp::Coee_sammpleApp()
{
	// TODO: add construction code here,
	// Place all significant initialization in InitInstance
}


// The one and only Coee_sammpleApp object

Coee_sammpleApp theApp;


// Coee_sammpleApp initialization

BOOL Coee_sammpleApp::InitInstance()
{
	// InitCommonControls() is required on Windows XP if an application
	// manifest specifies use of ComCtl32.dll version 6 or later to enable
	// visual styles.  Otherwise, any window creation will fail.
	InitCommonControls();

	CWinApp::InitInstance();
	AfxEnableControlContainer();

	SetRegistryKey(_T("MetaProducts"));

	Coee_sammpleDlg dlg;
	m_pMainWnd = &dlg;
	dlg.DoModal();
	return FALSE;
}
