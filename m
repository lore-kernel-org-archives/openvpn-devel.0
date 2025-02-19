From: Gert Doering <gert@...1296...>
Date: Wed, 19 Feb 2025 11:59:30 +0100
Message-ID: <20250219105930.29508-1-gert@...1296...>
In-Reply-To: <gerrit.1739948782000.I1a9738ad73c79661a8beb4d9881eba0b4d3aea53@...2715...>
References: <gerrit.1739948782000.I1a9738ad73c79661a8beb4d9881eba0b4d3aea53@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] add more (void) to windows specific
 function prototypes and declarations
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Change-Id: I1a9738ad73c79661a8beb4d9881eba0b4d3aea53
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/899
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 86556a8..edac71e 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -103,7 +103,7 @@
  * Set OpenSSL environment variables to a safe directory
  */
 static void
-set_openssl_env_vars();
+set_openssl_env_vars(void);
 
 void
 init_win32(void)
@@ -1518,7 +1518,7 @@
 }
 
 static void
-set_openssl_env_vars()
+set_openssl_env_vars(void)
 {
     const WCHAR *ssl_fallback_dir = L"C:\\Windows\\System32";
 
diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index a88a724..74bec6e 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -181,7 +181,7 @@
 
 
 LPCTSTR
-GetLastErrorText()
+GetLastErrorText(void)
 {
     DWORD error;
     static TCHAR buf[256];
diff --git a/src/openvpnserv/service.c b/src/openvpnserv/service.c
index 054fc5f..84fd11a 100644
--- a/src/openvpnserv/service.c
+++ b/src/openvpnserv/service.c
@@ -54,7 +54,7 @@
 }
 
 static int
-CmdInstallServices()
+CmdInstallServices(void)
 {
     SC_HANDLE service;
     SC_HANDLE svc_ctl_mgr;
@@ -146,7 +146,7 @@
 
 
 static int
-CmdRemoveServices()
+CmdRemoveServices(void)
 {
     SC_HANDLE service;
     SC_HANDLE svc_ctl_mgr;
diff --git a/src/openvpnserv/service.h b/src/openvpnserv/service.h
index da20433..c5f587b 100644
--- a/src/openvpnserv/service.h
+++ b/src/openvpnserv/service.h
@@ -86,7 +86,7 @@
 
 BOOL ReportStatusToSCMgr(SERVICE_STATUS_HANDLE service, SERVICE_STATUS *status);
 
-LPCTSTR GetLastErrorText();
+LPCTSTR GetLastErrorText(void);
 
 DWORD MsgToEventLog(DWORD flags, LPCTSTR lpszMsg, ...);
 

