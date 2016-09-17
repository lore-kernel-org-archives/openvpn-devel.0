From: Selva Nair <selva.nair@...277...>
Date: Sat, 17 Sep 2016 00:10:39 -0400
Message-Id: <1474085439-28766-2-git-send-email-selva.nair@...277...>
In-Reply-To: <1474085439-28766-1-git-send-email-selva.nair@...277...>
References: <1472096708-5561-2-git-send-email-selva.nair@...277...>
	<1474085439-28766-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH 2.3 v2] Support --block-outside-dns on
	multiple tunnels
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

v2: Simplified "add sublayer" code

Currently each instance of openvpn adds WFP filters into an independent
sublayer. As a block in one sublayer can over-ride a permit in another,
this causes all DNS traffic to block when --block-outside-dns is used
in multiple tunnels.

Fix using a common sublayer for adding firewall rules (filters) from all
instances of openvpn and interactive service.
- The sublayer is added in a persistent session so that it could be
  accessed from multiple sessions.
- The sublayer is identified by a fixed UUID defined in block_dns.c
- Permit filters for tun/tap interfaces are added with explicitly higher
  priority than filters that block all DNS traffic. This is not strictly
  necessary as WFP assigns higher priority to specific filters over generic
  ones, but it may be safer not to rely on that feature.
- All filters are added in dynamic sessions as before. They get
  automatically removed when the process exits. The sublayer will,
  however, persist until reboot.

Resolves Trac 718

- While at it also make sure the WFP session is closed on error in
  win_wfp_block_dns().
- Also fix the function prototype typedefs in win32_wfp.h for
  run-time-resolved fwpm functions

Tested on Windows 7, 10

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/win32.c     |  108 +++++++++++++++++++++++++++++++++++++----------
 src/openvpn/win32_wfp.h |   23 +++++++---
 2 files changed, 102 insertions(+), 29 deletions(-)

diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 4f2df14..e136449 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -63,6 +63,7 @@ func_FwpmSubLayerAdd0 FwpmSubLayerAdd0 = NULL;
 func_FwpmSubLayerDeleteByKey0 FwpmSubLayerDeleteByKey0 = NULL;
 func_FwpmFreeMemory0 FwpmFreeMemory0 = NULL;
 func_FwpmGetAppIdFromFileName0 FwpmGetAppIdFromFileName0 = NULL;
+func_FwpmSubLayerGetByKey0 FwpmSubLayerGetByKey0 = NULL;
 
 /*
  * WFP firewall name.
@@ -1140,6 +1141,7 @@ win_wfp_init_funcs ()
   FwpmSubLayerDeleteByKey0 = (func_FwpmSubLayerDeleteByKey0)GetProcAddress(fwpuclntHandle, "FwpmSubLayerDeleteByKey0");
   FwpmFreeMemory0 = (func_FwpmFreeMemory0)GetProcAddress(fwpuclntHandle, "FwpmFreeMemory0");
   FwpmGetAppIdFromFileName0 = (func_FwpmGetAppIdFromFileName0)GetProcAddress(fwpuclntHandle, "FwpmGetAppIdFromFileName0");
+  FwpmSubLayerGetByKey0 = (func_FwpmSubLayerGetByKey0) GetProcAddress(fwpuclntHandle, "FwpmSubLayerGetByKey0");
 
   if (!ConvertInterfaceIndexToLuid ||
       !FwpmFilterAdd0 ||
@@ -1148,6 +1150,7 @@ win_wfp_init_funcs ()
       !FwpmSubLayerAdd0 ||
       !FwpmSubLayerDeleteByKey0 ||
       !FwpmFreeMemory0 ||
+      !FwpmSubLayerGetByKey0 ||
       !FwpmGetAppIdFromFileName0)
   {
     msg (M_NONFATAL, "Can't get address for all WFP-related procedures.");
@@ -1157,6 +1160,49 @@ win_wfp_init_funcs ()
   return true;
 }
 
+/* UUID of WFP sublayer used by all instances of openvpn
+   2f660d7e-6a37-11e6-a181-001e8c6e04a2 */
+DEFINE_GUID(
+   OPENVPN_BLOCK_OUTSIDE_DNS_SUBLAYER,
+   0x2f660d7e,
+   0x6a37,
+   0x11e6,
+   0xa1, 0x81, 0x00, 0x1e, 0x8c, 0x6e, 0x04, 0xa2
+);
+
+/*
+ * Add a persistent sublayer with specified uuid
+ */
+static DWORD
+add_sublayer (GUID uuid)
+{
+  FWPM_SESSION0 session;
+  HANDLE engine = NULL;
+  DWORD err = 0;
+  FWPM_SUBLAYER0 sublayer;
+
+  CLEAR (session);
+  CLEAR (sublayer);
+
+  err = FwpmEngineOpen0 (NULL, RPC_C_AUTHN_WINNT, NULL, &session, &engine);
+  if (err != ERROR_SUCCESS)
+    goto out;
+
+  sublayer.subLayerKey = uuid;
+  sublayer.displayData.name = FIREWALL_NAME;
+  sublayer.displayData.description = FIREWALL_NAME;
+  sublayer.flags = 0;
+  sublayer.weight = 0x100;
+
+  /* Add sublayer to the session */
+  err = FwpmSubLayerAdd0 (engine, &sublayer, NULL);
+
+out:
+  if (engine)
+    FwpmEngineClose0 (engine);
+  return err;
+}
+
 bool
 win_wfp_add_filter (HANDLE engineHandle,
                     const FWPM_FILTER0 *filter,
@@ -1175,13 +1221,14 @@ bool
 win_wfp_block_dns (const NET_IFINDEX index)
 {
     FWPM_SESSION0 session = {0};
-    FWPM_SUBLAYER0 SubLayer = {0};
+    FWPM_SUBLAYER0 *sublayer_ptr = NULL;
     NET_LUID tapluid;
     UINT64 filterid;
     WCHAR openvpnpath[MAX_PATH];
     FWP_BYTE_BLOB *openvpnblob = NULL;
     FWPM_FILTER0 Filter = {0};
     FWPM_FILTER_CONDITION0 Condition[2] = {0};
+    DWORD status;
 
     /* Add temporary filters which don't survive reboots or crashes. */
     session.flags = FWPM_SESSION_FLAG_DYNAMIC;
@@ -1194,28 +1241,32 @@ win_wfp_block_dns (const NET_IFINDEX index)
         return false;
     }
 
-    if (UuidCreate(&SubLayer.subLayerKey) != NO_ERROR)
-        return false;
-
-    /* Populate packet filter layer information. */
-    SubLayer.displayData.name = FIREWALL_NAME;
-    SubLayer.displayData.description = FIREWALL_NAME;
-    SubLayer.flags = 0;
-    SubLayer.weight = 0x100;
-
-    /* Add packet filter to our interface. */
-    dmsg (D_LOW, "Adding WFP sublayer");
-    if (FwpmSubLayerAdd0(m_hEngineHandle, &SubLayer, NULL) != ERROR_SUCCESS)
+    /* Check sublayer exists and add one if it does not. */
+    if (FwpmSubLayerGetByKey0 (m_hEngineHandle, &OPENVPN_BLOCK_OUTSIDE_DNS_SUBLAYER, &sublayer_ptr)
+            == ERROR_SUCCESS)
     {
-        msg (M_NONFATAL, "Can't add WFP sublayer");
-        return false;
+        msg (D_LOW, "Retrieved existing sublayer");
+        FwpmFreeMemory0 ((void **)&sublayer_ptr);
+    }
+    else
+    {  /* Add a new sublayer -- as another process may add it in the meantime,
+          do not treat "already exists" as an error */
+        status = add_sublayer (OPENVPN_BLOCK_OUTSIDE_DNS_SUBLAYER);
+
+        if (status == FWP_E_ALREADY_EXISTS || status == ERROR_SUCCESS)
+            msg (D_LOW, "Added a persistent sublayer with pre-defined UUID");
+        else
+        {
+            msg (M_NONFATAL, "Failed to add persistent sublayer (status = %lu)", status);
+            goto err;
+        }
     }
 
-    dmsg (D_LOW, "Blocking DNS using WFP");
+    dmsg (M_INFO, "Blocking DNS using WFP");
     if (ConvertInterfaceIndexToLuid(index, &tapluid) != NO_ERROR)
     {
         msg (M_NONFATAL, "Can't convert interface index to LUID");
-        return false;
+        goto err;
     }
     dmsg (D_LOW, "Tap Luid: %I64d", tapluid.Value);
 
@@ -1223,10 +1274,10 @@ win_wfp_block_dns (const NET_IFINDEX index)
     GetModuleFileNameW(NULL, openvpnpath, MAX_PATH);
 
     if (FwpmGetAppIdFromFileName0(openvpnpath, &openvpnblob) != ERROR_SUCCESS)
-        return false;
+        goto err;
 
     /* Prepare filter. */
-    Filter.subLayerKey = SubLayer.subLayerKey;
+    Filter.subLayerKey = OPENVPN_BLOCK_OUTSIDE_DNS_SUBLAYER;
     Filter.displayData.name = FIREWALL_NAME;
     Filter.weight.type = FWP_UINT8;
     Filter.weight.uint8 = 0xF;
@@ -1277,7 +1328,12 @@ win_wfp_block_dns (const NET_IFINDEX index)
         goto err;
     dmsg (D_LOW, "Filter (Block IPv6 DNS) added with ID=%I64d", filterid);
 
-    /* Fifth filter. Permit IPv4 DNS queries from TAP. */
+    /* Fifth filter. Permit IPv4 DNS queries from TAP.
+     * Use a non-zero weight so that the permit filters get higher priority
+     * over the block filter added with automatic weighting */
+
+    Filter.weight.type = FWP_UINT8;
+    Filter.weight.uint8 = 0xE;
     Filter.layerKey = FWPM_LAYER_ALE_AUTH_CONNECT_V4;
     Filter.action.type = FWP_ACTION_PERMIT;
     Filter.numFilterConditions = 2;
@@ -1292,7 +1348,8 @@ win_wfp_block_dns (const NET_IFINDEX index)
         goto err;
     dmsg (D_LOW, "Filter (Permit IPv4 DNS queries from TAP) added with ID=%I64d", filterid);
 
-    /* Sixth filter. Permit IPv6 DNS queries from TAP. */
+    /* Sixth filter. Permit IPv6 DNS queries from TAP.
+     * Use same weight as IPv4 filter */
     Filter.layerKey = FWPM_LAYER_ALE_AUTH_CONNECT_V6;
 
     /* Add filter condition to our interface. */
@@ -1304,7 +1361,14 @@ win_wfp_block_dns (const NET_IFINDEX index)
     return true;
 
     err:
-        FwpmFreeMemory0((void **)&openvpnblob);
+        if (openvpnblob)
+           FwpmFreeMemory0((void **)&openvpnblob);
+        if (m_hEngineHandle)
+        {
+            FwpmEngineClose0 (m_hEngineHandle);
+            m_hEngineHandle = NULL;
+        }
+
         return false;
 }
 
diff --git a/src/openvpn/win32_wfp.h b/src/openvpn/win32_wfp.h
index 7559e5b..5e1a96a 100644
--- a/src/openvpn/win32_wfp.h
+++ b/src/openvpn/win32_wfp.h
@@ -62,6 +62,9 @@
 #ifndef FWPM_SESSION_FLAG_DYNAMIC
 #define FWPM_SESSION_FLAG_DYNAMIC 0x00000001
 #endif
+#ifndef FWP_E_ALREADY_EXISTS
+#define FWP_E_ALREADY_EXISTS 0x80320009
+#endif
 
 // c38d57d1-05a7-4c33-904f-7fbceee60e82
 DEFINE_GUID(
@@ -317,7 +320,7 @@ typedef NETIO_STATUS *(WINAPI *func_ConvertInterfaceIndexToLuid)(
   PNET_LUID InterfaceLuid
 );
 
-typedef DWORD *(WINAPI *func_FwpmEngineOpen0)(
+typedef DWORD (WINAPI *func_FwpmEngineOpen0)(
   const wchar_t *serverName,
   UINT32 authnService,
   SEC_WINNT_AUTH_IDENTITY_W *authIdentity,
@@ -325,35 +328,41 @@ typedef DWORD *(WINAPI *func_FwpmEngineOpen0)(
   HANDLE *engineHandle
 );
 
-typedef DWORD *(WINAPI *func_FwpmEngineClose0)(
+typedef DWORD (WINAPI *func_FwpmEngineClose0)(
   HANDLE engineHandle
 );
 
-typedef DWORD *(WINAPI *func_FwpmFilterAdd0)(
+typedef DWORD (WINAPI *func_FwpmFilterAdd0)(
   HANDLE engineHandle,
   const FWPM_FILTER0 *filter,
   PSECURITY_DESCRIPTOR sd,
   UINT64 *id
 );
 
-typedef DWORD *(WINAPI *func_FwpmSubLayerAdd0)(
+typedef DWORD (WINAPI *func_FwpmSubLayerAdd0)(
   HANDLE engineHandle,
   const FWPM_SUBLAYER0 *subLayer,
   PSECURITY_DESCRIPTOR sd
 );
 
-typedef DWORD *(WINAPI *func_FwpmSubLayerDeleteByKey0)(
+typedef DWORD (WINAPI *func_FwpmSubLayerDeleteByKey0)(
   HANDLE engineHandle,
   const GUID *key
 );
 
-typedef void *(WINAPI *func_FwpmFreeMemory0)(
+typedef void (WINAPI *func_FwpmFreeMemory0)(
   void **p
 );
 
-typedef DWORD *(WINAPI *func_FwpmGetAppIdFromFileName0)(
+typedef DWORD (WINAPI *func_FwpmGetAppIdFromFileName0)(
   const wchar_t *fileName,
   FWP_BYTE_BLOB **appId
 );
 
+typedef DWORD (WINAPI *func_FwpmSubLayerGetByKey0)(
+  HANDLE engineHandle,
+  const GUID *key,
+  FWPM_SUBLAYER0 **subLayer
+);
+
 #endif
-- 
1.7.10.4


