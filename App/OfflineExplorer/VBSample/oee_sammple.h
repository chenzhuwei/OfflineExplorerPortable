// oee_sammple.h : main header file for the PROJECT_NAME application
//

#pragma once

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"		// main symbols


// Coee_sammpleApp:
// See oee_sammple.cpp for the implementation of this class
//

class Coee_sammpleApp : public CWinApp
{
public:
	Coee_sammpleApp();

// Overrides
	public:
	virtual BOOL InitInstance();

// Implementation

	DECLARE_MESSAGE_MAP()
};

extern Coee_sammpleApp theApp;