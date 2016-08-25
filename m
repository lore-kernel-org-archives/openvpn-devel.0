From: Selva Nair <selva.nair@...277...>
Date: Wed, 24 Aug 2016 23:45:08 -0400
Message-Id: <1472096708-5561-2-git-send-email-selva.nair@...277...>
In-Reply-To: <1472096708-5561-1-git-send-email-selva.nair@...277...>
References: <1472096708-5561-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH 2.3] Support --block-outside-dns on multiple
	tunnels
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

Currently each instance of openvpn adds WFP filters into an independent
sublayer. As a block in one sublayer can over-ride a permit in another,
this causes all DNS traffic to block when --block-outside-dns is used
in multiple tunnels.

Fix using a common sublayer for adding firewall rules (filters) from all
instances of openvpn and interactive service.
- The sublayer is added in a persistent session so that it could be
  accessed from multiple sessions.
- The sublayer is identified by a fixed UUID defined in block_dns.c
  shared between openvpn.exe and openvpnserv.exe.
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
 src/openvpn/win32.c     |  103 ++++++++++++++++++++++++++++++++++++++---------
 src/openvpn/win32_wfp.h |   20 +++++----
 2 files changed, 97 insertions(+), 26 deletions(-)

diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 4f2df14..1edc482 100644
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
@@ -1157,6 +1160,66 @@ win_wfp_init_funcs ()
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
+ * Retrieve the common sublayer for adding filters into. If the sublayer
+ * does not exist a new one with UUID = OPENVPN_BLOCK_OUTSIDE_DNS_SUBLAYER
+ * is added to the system.
+ * A common sublayer is used by all instances of openvpn.
+ */
+
+static DWORD
+get_sublayer (FWPM_SUBLAYER0 *SubLayer)
+{
+  FWPM_SESSION0 session;
+  HANDLE engine = NULL;
+  DWORD err = 0;
+  FWPM_SUBLAYER0 *sublayer_ptr;
+
+  memset (&session, 0, sizeof(session));
+
+  err = FwpmEngineOpen0 (NULL, RPC_C_AUTHN_WINNT, NULL, &session, &engine);
+  if (err != ERROR_SUCCESS)
+    goto out;
+
+  /* Try to retrieve the sublayer if already present */
+  err = FwpmSubLayerGetByKey0 (engine,
+          &OPENVPN_BLOCK_OUTSIDE_DNS_SUBLAYER, &sublayer_ptr);
+  if (err == ERROR_SUCCESS)
+    {
+      msg (D_LOW, "Retrieved existing sublayer");
+      memcpy (SubLayer, sublayer_ptr, sizeof(*SubLayer));
+      FwpmFreeMemory0 ((void **)&sublayer_ptr);
+      goto out;
+    }
+
+  /* Sublayer does not exist -- add it */
+  SubLayer->subLayerKey = OPENVPN_BLOCK_OUTSIDE_DNS_SUBLAYER;
+  SubLayer->displayData.name = FIREWALL_NAME;
+  SubLayer->displayData.description = FIREWALL_NAME;
+  SubLayer->flags = 0;
+  SubLayer->weight = 0x100;
+
+  /* Add sublayer to the session */
+  err = FwpmSubLayerAdd0 (engine, SubLayer, NULL);
+  if (err == ERROR_SUCCESS)
+    msg (D_LOW, "Added a persistent sublayer with pre-defined UUID");
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
@@ -1194,28 +1257,17 @@ win_wfp_block_dns (const NET_IFINDEX index)
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
+    if (get_sublayer (&SubLayer) != ERROR_SUCCESS)
     {
-        msg (M_NONFATAL, "Can't add WFP sublayer");
-        return false;
+        msg (M_NONFATAL, "Failed to retrieve or add persistent sublayer");
+        goto err;
     }
 
     dmsg (D_LOW, "Blocking DNS using WFP");
     if (ConvertInterfaceIndexToLuid(index, &tapluid) != NO_ERROR)
     {
         msg (M_NONFATAL, "Can't convert interface index to LUID");
-        return false;
+        goto err;
     }
     dmsg (D_LOW, "Tap Luid: %I64d", tapluid.Value);
 
@@ -1223,7 +1275,7 @@ win_wfp_block_dns (const NET_IFINDEX index)
     GetModuleFileNameW(NULL, openvpnpath, MAX_PATH);
 
     if (FwpmGetAppIdFromFileName0(openvpnpath, &openvpnblob) != ERROR_SUCCESS)
-        return false;
+        goto err;
 
     /* Prepare filter. */
     Filter.subLayerKey = SubLayer.subLayerKey;
@@ -1277,7 +1329,12 @@ win_wfp_block_dns (const NET_IFINDEX index)
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
@@ -1292,7 +1349,8 @@ win_wfp_block_dns (const NET_IFINDEX index)
         goto err;
     dmsg (D_LOW, "Filter (Permit IPv4 DNS queries from TAP) added with ID=%I64d", filterid);
 
-    /* Sixth filter. Permit IPv6 DNS queries from TAP. */
+    /* Sixth filter. Permit IPv6 DNS queries from TAP.
+     * Use same weight as IPv4 filter */
     Filter.layerKey = FWPM_LAYER_ALE_AUTH_CONNECT_V6;
 
     /* Add filter condition to our interface. */
@@ -1304,7 +1362,14 @@ win_wfp_block_dns (const NET_IFINDEX index)
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
index 7559e5b..f5c1955 100644
--- a/src/openvpn/win32_wfp.h
+++ b/src/openvpn/win32_wfp.h
@@ -317,7 +317,7 @@ typedef NETIO_STATUS *(WINAPI *func_ConvertInterfaceIndexToLuid)(
   PNET_LUID InterfaceLuid
 );
 
-typedef DWORD *(WINAPI *func_FwpmEngineOpen0)(
+typedef DWORD (WINAPI *func_FwpmEngineOpen0)(
   const wchar_t *serverName,
   UINT32 authnService,
   SEC_WINNT_AUTH_IDENTITY_W *authIdentity,
@@ -325,35 +325,41 @@ typedef DWORD *(WINAPI *func_FwpmEngineOpen0)(
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


