// oee_sammpleDlg.h : header file
//

#pragma once
#include "afxcmn.h"
#include "afxwin.h"

// Coee_sammpleDlg dialog
class Coee_sammpleDlg : public CDialog
{
// Construction
public:
	Coee_sammpleDlg(CWnd* pParent = NULL);	// standard constructor

// Dialog Data
	enum { IDD = IDD_OEE_SAMMPLE_DIALOG };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support

// Implementation
protected:
	HICON m_hIcon;

	// Generated message map functions
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	DECLARE_MESSAGE_MAP()
public:
	afx_msg void OnBnClickedLoadtree();
	CTreeCtrl m_Tree;
	CMainOE m_MainOE;
	afx_msg void OnBnClickedAttach();
	CButton m_Attach;
	CImageList m_Images;
	afx_msg void OnTvnSelchangedTree(NMHDR *pNMHDR, LRESULT *pResult);
	CStatic m_URL;
	CButton m_Start;
	CButton m_Stop;
	afx_msg void OnBnClickedStart();
	afx_msg void OnBnClickedStop();
	COEProject GetOEProject(HTREEITEM item);
	CButton m_LoadTree;
};
