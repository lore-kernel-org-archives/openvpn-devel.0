From: Gert Doering <gert@...1296...>
Date: Tue, 10 Feb 2026 16:16:31 +0100
Message-ID: <20260210151639.913-1-gert@...1296...>
In-Reply-To: <gerrit.1770735616000.Iaf0d8f528211f1971f163a8006b054efb4917e2a@...2715...>
References: <gerrit.1770735616000.Iaf0d8f528211f1971f163a8006b054efb4917e2a@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Update the clang-format reference
 version to 21.1.8
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

From: Frank Lichtenheld <frank@...2641...>

Latest v21.x version.
Changes a few file in Windows specific code due
to bug fixes.

Change-Id: Iaf0d8f528211f1971f163a8006b054efb4917e2a
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1514
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1514
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/.pre-commit-config.yaml b/.pre-commit-config.yaml
index c1bca47..5fd5465 100644
--- a/.pre-commit-config.yaml
+++ b/.pre-commit-config.yaml
@@ -1,6 +1,6 @@
 repos:
   - repo: https://github.com/pre-commit/mirrors-clang-format
-    rev: 'v20.1.0'
+    rev: 'v21.1.8'
     hooks:
       - id: clang-format
         files: \.[ch]$
diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index b5d8cd2..a145b64 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -308,7 +308,8 @@
 }
 
 
-UINT __stdcall FindSystemInfo(_In_ MSIHANDLE hInstall)
+UINT __stdcall
+FindSystemInfo(_In_ MSIHANDLE hInstall)
 {
 #ifdef DLLEXP_EXPORT
 #pragma comment(linker, DLLEXP_EXPORT)
@@ -335,7 +336,8 @@
 }
 
 
-UINT __stdcall CloseOpenVPNGUI(_In_ MSIHANDLE hInstall)
+UINT __stdcall
+CloseOpenVPNGUI(_In_ MSIHANDLE hInstall)
 {
 #ifdef DLLEXP_EXPORT
 #pragma comment(linker, DLLEXP_EXPORT)
@@ -359,7 +361,8 @@
 }
 
 
-UINT __stdcall StartOpenVPNGUI(_In_ MSIHANDLE hInstall)
+UINT __stdcall
+StartOpenVPNGUI(_In_ MSIHANDLE hInstall)
 {
 #ifdef DLLEXP_EXPORT
 #pragma comment(linker, DLLEXP_EXPORT)
@@ -620,7 +623,8 @@
 }
 
 
-UINT __stdcall EvaluateTUNTAPAdapters(_In_ MSIHANDLE hInstall)
+UINT __stdcall
+EvaluateTUNTAPAdapters(_In_ MSIHANDLE hInstall)
 {
 #ifdef DLLEXP_EXPORT
 #pragma comment(linker, DLLEXP_EXPORT)
@@ -963,7 +967,8 @@
     }
 }
 
-UINT __stdcall ProcessDeferredAction(_In_ MSIHANDLE hInstall)
+UINT __stdcall
+ProcessDeferredAction(_In_ MSIHANDLE hInstall)
 {
 #ifdef DLLEXP_EXPORT
 #pragma comment(linker, DLLEXP_EXPORT)
@@ -1166,7 +1171,8 @@
     return uiResult;
 }
 
-UINT __stdcall CheckAndScheduleReboot(_In_ MSIHANDLE hInstall)
+UINT __stdcall
+CheckAndScheduleReboot(_In_ MSIHANDLE hInstall)
 {
 #ifdef DLLEXP_EXPORT
 #pragma comment(linker, DLLEXP_EXPORT)
diff --git a/src/tapctl/main.c b/src/tapctl/main.c
index 6bb4119..1d047dd 100644
--- a/src/tapctl/main.c
+++ b/src/tapctl/main.c
@@ -609,7 +609,8 @@
 /**
  * Program entry point
  */
-int __cdecl wmain(int argc, LPCWSTR argv[])
+int __cdecl
+wmain(int argc, LPCWSTR argv[])
 {
     int iResult;
     BOOL bRebootRequired = FALSE;

