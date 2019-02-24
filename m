From: Simon Rozman <simon@...2293...>
Date: Sun, 24 Feb 2019 19:12:52 +0100
Message-Id: <20190224181252.43996-1-simon@...2293...>
In-Reply-To: <20190117155829.GA92142@...1296...>
References: <20190117155829.GA92142@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Disambiguate thread local storage
 references from TLS
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

Since OpenVPN is security software, "TLS" usually stands for Transport
Layer Security.

Furthermore, repetitive copy&paste code was refactored using a macro.

This patch follows Gert's recommendations from [openvpn-devel].

Signed-off-by: Simon Rozman <simon@...2293...>
Message-ID: <20190117155829.GA92142@...1296...>
---
 src/openvpnmsica/dllmain.c      | 30 +++++++++++++++---------------
 src/openvpnmsica/openvpnmsica.c | 20 +++++---------------
 src/openvpnmsica/openvpnmsica.h | 18 ++++++++++++++----
 3 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/src/openvpnmsica/dllmain.c b/src/openvpnmsica/dllmain.c
index 50231e4c..5f5092a0 100644
--- a/src/openvpnmsica/dllmain.c
+++ b/src/openvpnmsica/dllmain.c
@@ -36,7 +36,7 @@
 #include <tchar.h>
 
 
-DWORD openvpnmsica_tlsidx_session = TLS_OUT_OF_INDEXES;
+DWORD openvpnmsica_thread_data_idx = TLS_OUT_OF_INDEXES;
 
 
 /**
@@ -54,9 +54,9 @@ DllMain(
     switch (dwReason)
     {
         case DLL_PROCESS_ATTACH:
-            /* Allocate TLS index. */
-            openvpnmsica_tlsidx_session = TlsAlloc();
-            if (openvpnmsica_tlsidx_session == TLS_OUT_OF_INDEXES)
+            /* Allocate thread local storage index. */
+            openvpnmsica_thread_data_idx = TlsAlloc();
+            if (openvpnmsica_thread_data_idx == TLS_OUT_OF_INDEXES)
             {
                 return FALSE;
             }
@@ -64,25 +64,25 @@ DllMain(
 
         case DLL_THREAD_ATTACH:
         {
-            /* Create TLS data. */
-            struct openvpnmsica_tls_data *s = (struct openvpnmsica_tls_data *)malloc(sizeof(struct openvpnmsica_tls_data));
-            memset(s, 0, sizeof(struct openvpnmsica_tls_data));
-            TlsSetValue(openvpnmsica_tlsidx_session, s);
+            /* Create thread local storage data. */
+            struct openvpnmsica_thread_data *s = (struct openvpnmsica_thread_data *)malloc(sizeof(struct openvpnmsica_thread_data));
+            memset(s, 0, sizeof(struct openvpnmsica_thread_data));
+            TlsSetValue(openvpnmsica_thread_data_idx, s);
             break;
         }
 
         case DLL_PROCESS_DETACH:
-            if (openvpnmsica_tlsidx_session != TLS_OUT_OF_INDEXES)
+            if (openvpnmsica_thread_data_idx != TLS_OUT_OF_INDEXES)
             {
-                /* Free TLS data and TLS index. */
-                free(TlsGetValue(openvpnmsica_tlsidx_session));
-                TlsFree(openvpnmsica_tlsidx_session);
+                /* Free thread local storage data and index. */
+                free(TlsGetValue(openvpnmsica_thread_data_idx));
+                TlsFree(openvpnmsica_thread_data_idx);
             }
             break;
 
         case DLL_THREAD_DETACH:
-            /* Free TLS data. */
-            free(TlsGetValue(openvpnmsica_tlsidx_session));
+            /* Free thread local storage data. */
+            free(TlsGetValue(openvpnmsica_thread_data_idx));
             break;
     }
 
@@ -105,7 +105,7 @@ x_msg_va(const unsigned int flags, const char *format, va_list arglist)
     /* Secure last error before it is overridden. */
     DWORD dwResult = (flags & M_ERRNO) != 0 ? GetLastError() : ERROR_SUCCESS;
 
-    struct openvpnmsica_tls_data *s = (struct openvpnmsica_tls_data *)TlsGetValue(openvpnmsica_tlsidx_session);
+    struct openvpnmsica_thread_data *s = (struct openvpnmsica_thread_data *)TlsGetValue(openvpnmsica_thread_data_idx);
     if (s->hInstall == 0)
     {
         /* No MSI session, no fun. */
diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index 3232a47c..b8108b99 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -435,9 +435,7 @@ FindSystemInfo(_In_ MSIHANDLE hInstall)
 
     BOOL bIsCoInitialized = SUCCEEDED(CoInitialize(NULL));
 
-    /* Set MSI session handle in TLS. */
-    struct openvpnmsica_tls_data *s = (struct openvpnmsica_tls_data *)TlsGetValue(openvpnmsica_tlsidx_session);
-    s->hInstall = hInstall;
+    OPENVPNMSICA_SAVE_MSI_SESSION(hInstall);
 
     openvpnmsica_set_driver_certification(hInstall);
     openvpnmsica_set_openvpnserv_state(hInstall);
@@ -462,9 +460,7 @@ FindTAPInterfaces(_In_ MSIHANDLE hInstall)
     UINT uiResult;
     BOOL bIsCoInitialized = SUCCEEDED(CoInitialize(NULL));
 
-    /* Set MSI session handle in TLS. */
-    struct openvpnmsica_tls_data *s = (struct openvpnmsica_tls_data *)TlsGetValue(openvpnmsica_tlsidx_session);
-    s->hInstall = hInstall;
+    OPENVPNMSICA_SAVE_MSI_SESSION(hInstall);
 
     /* Get available network interfaces. */
     struct tap_interface_node *pInterfaceList = NULL;
@@ -677,9 +673,7 @@ StartOpenVPNGUI(_In_ MSIHANDLE hInstall)
     UINT uiResult;
     BOOL bIsCoInitialized = SUCCEEDED(CoInitialize(NULL));
 
-    /* Set MSI session handle in TLS. */
-    struct openvpnmsica_tls_data *s = (struct openvpnmsica_tls_data *)TlsGetValue(openvpnmsica_tlsidx_session);
-    s->hInstall = hInstall;
+    OPENVPNMSICA_SAVE_MSI_SESSION(hInstall);
 
     /* Create and populate a MSI record. */
     MSIHANDLE hRecord = MsiCreateRecord(1);
@@ -759,9 +753,7 @@ EvaluateTAPInterfaces(_In_ MSIHANDLE hInstall)
     UINT uiResult;
     BOOL bIsCoInitialized = SUCCEEDED(CoInitialize(NULL));
 
-    /* Set MSI session handle in TLS. */
-    struct openvpnmsica_tls_data *s = (struct openvpnmsica_tls_data *)TlsGetValue(openvpnmsica_tlsidx_session);
-    s->hInstall = hInstall;
+    OPENVPNMSICA_SAVE_MSI_SESSION(hInstall);
 
     /* List of deferred custom actions EvaluateTAPInterfaces prepares operation sequence for. */
     static const LPCTSTR szActionNames[] =
@@ -1052,9 +1044,7 @@ ProcessDeferredAction(_In_ MSIHANDLE hInstall)
     UINT uiResult;
     BOOL bIsCoInitialized = SUCCEEDED(CoInitialize(NULL));
 
-    /* Set MSI session handle in TLS. */
-    struct openvpnmsica_tls_data *s = (struct openvpnmsica_tls_data *)TlsGetValue(openvpnmsica_tlsidx_session);
-    s->hInstall = hInstall;
+    OPENVPNMSICA_SAVE_MSI_SESSION(hInstall);
 
     BOOL bIsCleanup = MsiGetMode(hInstall, MSIRUNMODE_COMMIT) || MsiGetMode(hInstall, MSIRUNMODE_ROLLBACK);
 
diff --git a/src/openvpnmsica/openvpnmsica.h b/src/openvpnmsica/openvpnmsica.h
index 382064b6..d6a09127 100644
--- a/src/openvpnmsica/openvpnmsica.h
+++ b/src/openvpnmsica/openvpnmsica.h
@@ -33,18 +33,28 @@
 
 
 /**
- * TLS data
+ * Thread local storage data
  */
-struct openvpnmsica_tls_data
+struct openvpnmsica_thread_data
 {
     MSIHANDLE hInstall; /** Handle to the installation session. */
 };
 
 
 /**
- * MSI session handle TLS index
+ * MSI session handle thread local storage index
  */
-extern DWORD openvpnmsica_tlsidx_session;
+extern DWORD openvpnmsica_thread_data_idx;
+
+
+/**
+ * Set MSI session handle in thread local storage.
+ */
+#define OPENVPNMSICA_SAVE_MSI_SESSION(hInstall) \
+{ \
+    struct openvpnmsica_thread_data *s = (struct openvpnmsica_thread_data *)TlsGetValue(openvpnmsica_thread_data_idx); \
+    s->hInstall = (hInstall); \
+}
 
 
 /*
-- 
2.19.0.windows.1


