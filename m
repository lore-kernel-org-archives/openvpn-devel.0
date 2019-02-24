From: Simon Rozman <simon@...2293...>
Date: Sun, 24 Feb 2019 19:15:44 +0100
Message-Id: <20190224181544.17232-1-simon@...2293...>
In-Reply-To: <201901181944.x0IJiGuV003728@...2054...>
References: <201901181944.x0IJiGuV003728@...2054...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Refactor OpenVPNService state detection code
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

The code was standardized to avoid "E1072: a declaration cannot have a
label" warning of Visual Studio 2017 IntelliSense.

Furthermore, a comment explaining what `dwStartType <=
SERVICE_AUTO_START` condition is about.

This patch follows Gert's recommendations from [openvpn-devel].

Signed-off-by: Simon Rozman <simon@...2293...>
Message-ID: <201901181944.x0IJiGuV003728@...2054...>
---
 src/openvpnmsica/openvpnmsica.c | 59 +++++++++++++++++----------------
 1 file changed, 31 insertions(+), 28 deletions(-)

diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index 00ed2765..2477e81a 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -365,40 +365,42 @@ openvpnmsica_set_openvpnserv_state(_In_ MSIHANDLE hInstall)
     /* Query service status. */
     SERVICE_STATUS_PROCESS ssp;
     DWORD dwBufSize;
-    if (!QueryServiceStatusEx(hService, SC_STATUS_PROCESS_INFO, (LPBYTE)&ssp, sizeof(ssp), &dwBufSize))
+    if (QueryServiceStatusEx(hService, SC_STATUS_PROCESS_INFO, (LPBYTE)&ssp, sizeof(ssp), &dwBufSize))
     {
-        uiResult = GetLastError();
-        msg(M_NONFATAL | M_ERRNO, "%s: QueryServiceStatusEx(\"OpenVPNService\") failed", __FUNCTION__);
-        goto finish_QueryServiceStatusEx;
-    }
-
-    switch (ssp.dwCurrentState)
-    {
-        case SERVICE_START_PENDING:
-        case SERVICE_RUNNING:
-        case SERVICE_STOP_PENDING:
-        case SERVICE_PAUSE_PENDING:
-        case SERVICE_PAUSED:
-        case SERVICE_CONTINUE_PENDING:
+        switch (ssp.dwCurrentState)
         {
-            /* Set OPENVPNSERVICE property to service PID. */
-            TCHAR szPID[10 /*MAXDWORD in decimal*/ + 1 /*terminator*/];
-            _stprintf_s(
-                szPID, _countof(szPID),
-                TEXT("%u"),
-                ssp.dwProcessId);
-
-            uiResult = MsiSetProperty(hInstall, TEXT("OPENVPNSERVICE"), szPID);
-            if (uiResult != ERROR_SUCCESS)
+            case SERVICE_START_PENDING:
+            case SERVICE_RUNNING:
+            case SERVICE_STOP_PENDING:
+            case SERVICE_PAUSE_PENDING:
+            case SERVICE_PAUSED:
+            case SERVICE_CONTINUE_PENDING:
             {
-                SetLastError(uiResult); /* MSDN does not mention MsiSetProperty() to set GetLastError(). But we do have an error code. Set last error manually. */
-                msg(M_NONFATAL | M_ERRNO, "%s: MsiSetProperty(\"OPENVPNSERVICE\") failed", __FUNCTION__);
+                /* Service is started (kind of). Set OPENVPNSERVICE property to service PID. */
+                TCHAR szPID[10 /*MAXDWORD in decimal*/ + 1 /*terminator*/];
+                _stprintf_s(
+                    szPID, _countof(szPID),
+                    TEXT("%u"),
+                    ssp.dwProcessId);
+
+                uiResult = MsiSetProperty(hInstall, TEXT("OPENVPNSERVICE"), szPID);
+                if (uiResult != ERROR_SUCCESS)
+                {
+                    SetLastError(uiResult); /* MSDN does not mention MsiSetProperty() to set GetLastError(). But we do have an error code. Set last error manually. */
+                    msg(M_NONFATAL | M_ERRNO, "%s: MsiSetProperty(\"OPENVPNSERVICE\") failed", __FUNCTION__);
+                }
+
+                /* We know user is using the service. Skip auto-start setting check. */
+                goto cleanup_OpenService;
             }
-            goto cleanup_OpenService;
+            break;
         }
-        break;
     }
-finish_QueryServiceStatusEx:;
+    else
+    {
+        uiResult = GetLastError();
+        msg(M_NONFATAL | M_ERRNO, "%s: QueryServiceStatusEx(\"OpenVPNService\") failed", __FUNCTION__);
+    }
 
     /* Service is not started. Is it set to auto-start? */
     /* MSDN describes the maximum buffer size for QueryServiceConfig() to be 8kB. */
@@ -415,6 +417,7 @@ finish_QueryServiceStatusEx:;
 
     if (pQsc->dwStartType <= SERVICE_AUTO_START)
     {
+        /* Service is set to auto-start. Set OPENVPNSERVICE property to its path. */
         uiResult = MsiSetProperty(hInstall, TEXT("OPENVPNSERVICE"), pQsc->lpBinaryPathName);
         if (uiResult != ERROR_SUCCESS)
         {
-- 
2.19.0.windows.1


