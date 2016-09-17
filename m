From: Selva Nair <selva.nair@...277...>
Date: Sat, 17 Sep 2016 00:10:38 -0400
Message-Id: <1474085439-28766-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1472096708-5561-2-git-send-email-selva.nair@...277...>
References: <1472096708-5561-2-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH master v2] Support --block-outside-dns on
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

v2: Simplify the "add sublayer" code.

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
- Permit filters for tun/tap interfaces are added with higher priority
  than filters that block all DNS traffic. This is not strictly
  necessary as WFP assigns higher priority to specific filters over generic
  ones, but it may be safer not to rely on that feature.
- All filters are added in dynamic sessions as before. They get
  automatically removed when the process exits. The sublayer will,
  however, persist until reboot.

Resolves Trac 718
Tested on Windows 7, 10 with/without interactive service

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/block_dns.c |   96 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 75 insertions(+), 21 deletions(-)

diff --git a/src/openvpn/block_dns.c b/src/openvpn/block_dns.c
index af2db18..b07ff07 100644
--- a/src/openvpn/block_dns.c
+++ b/src/openvpn/block_dns.c
@@ -87,6 +87,18 @@ DEFINE_GUID(
    0xb7, 0xf3, 0xbd, 0xa5, 0xd3, 0x28, 0x90, 0xa4
 );
 
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
+static WCHAR *FIREWALL_NAME = L"OpenVPN";
+
 /*
  * Default msg handler does nothing
  */
@@ -100,6 +112,39 @@ default_msg_handler (DWORD err, const char *msg)
    if (err) { msg_handler (err, msg); goto out; }
 
 /*
+ * Add a persistent sublayer with specified uuid.
+ */
+static DWORD
+add_sublayer (GUID uuid)
+{
+  FWPM_SESSION0 session;
+  HANDLE engine = NULL;
+  DWORD err = 0;
+  FWPM_SUBLAYER0 sublayer;
+
+  memset (&session, 0, sizeof(session));
+  memset (&sublayer, 0, sizeof(sublayer));
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
+/*
  * Block outgoing port 53 traffic except for
  * (i) adapter with the specified index
  * OR
@@ -124,13 +169,12 @@ add_block_dns_filters (HANDLE *engine_handle,
                       )
 {
   FWPM_SESSION0 session = {0};
-  FWPM_SUBLAYER0 SubLayer = {0};
+  FWPM_SUBLAYER0 *sublayer_ptr = NULL;
   NET_LUID tapluid;
   UINT64 filterid;
   FWP_BYTE_BLOB *openvpnblob = NULL;
   FWPM_FILTER0 Filter = {0};
   FWPM_FILTER_CONDITION0 Condition[2] = {0};
-  WCHAR *FIREWALL_NAME = L"OpenVPN";
   DWORD err = 0;
 
   if (!msg_handler)
@@ -143,22 +187,26 @@ add_block_dns_filters (HANDLE *engine_handle,
 
   err = FwpmEngineOpen0 (NULL, RPC_C_AUTHN_WINNT, NULL, &session, engine_handle);
   CHECK_ERROR (err, "FwpEngineOpen: open fwp session failed");
-
-  err = UuidCreate (&SubLayer.subLayerKey);
-  CHECK_ERROR (err, "UuidCreate: create sublayer key failed");
-
-  /* Populate packet filter layer information. */
-  SubLayer.displayData.name = FIREWALL_NAME;
-  SubLayer.displayData.description = FIREWALL_NAME;
-  SubLayer.flags = 0;
-  SubLayer.weight = 0x100;
-
-  /* Add sublayer to the session */
-  err = FwpmSubLayerAdd0 (*engine_handle, &SubLayer, NULL);
-  CHECK_ERROR (err, "FwpmSubLayerAdd: add sublayer to session failed");
-
   msg_handler (0, "Block_DNS: WFP engine opened");
 
+  /* Check sublayer exists and add one if it does not. */
+  if (FwpmSubLayerGetByKey0 (*engine_handle, &OPENVPN_BLOCK_OUTSIDE_DNS_SUBLAYER, &sublayer_ptr)
+       == ERROR_SUCCESS)
+    {
+      msg_handler (0, "Block_DNS: Using existing sublayer");
+      FwpmFreeMemory0 ((void **)&sublayer_ptr);
+    }
+  else
+    {  /* Add a new sublayer -- as another process may add it in the meantime,
+          do not treat "already exists" as an error */
+      err = add_sublayer (OPENVPN_BLOCK_OUTSIDE_DNS_SUBLAYER);
+
+      if (err == FWP_E_ALREADY_EXISTS || err == ERROR_SUCCESS)
+        msg_handler (0, "Block_DNS: Added a persistent sublayer with pre-defined UUID");
+      else
+        CHECK_ERROR (err, "add_sublayer: failed to add persistent sublayer");
+    }
+
   err = ConvertInterfaceIndexToLuid (index, &tapluid);
   CHECK_ERROR (err, "Convert interface index to luid failed");
 
@@ -166,7 +214,7 @@ add_block_dns_filters (HANDLE *engine_handle,
   CHECK_ERROR (err, "Get byte blob for openvpn executable name failed");
 
   /* Prepare filter. */
-  Filter.subLayerKey = SubLayer.subLayerKey;
+  Filter.subLayerKey = OPENVPN_BLOCK_OUTSIDE_DNS_SUBLAYER;
   Filter.displayData.name = FIREWALL_NAME;
   Filter.weight.type = FWP_UINT8;
   Filter.weight.uint8 = 0xF;
@@ -207,15 +255,20 @@ add_block_dns_filters (HANDLE *engine_handle,
   err = FwpmFilterAdd0(*engine_handle, &Filter, NULL, &filterid);
   CHECK_ERROR (err, "Add filter to block IPv4 DNS traffic failed");
 
-  msg_handler (0, "Block_DNS: Added block filters for all");
-
   /* Forth filter. Block all IPv6 DNS queries. */
   Filter.layerKey = FWPM_LAYER_ALE_AUTH_CONNECT_V6;
 
   err = FwpmFilterAdd0(*engine_handle, &Filter, NULL, &filterid);
   CHECK_ERROR (err, "Add filter to block IPv6 DNS traffic failed");
 
-  /* Fifth filter. Permit IPv4 DNS queries from TAP. */
+  msg_handler (0, "Block_DNS: Added block filters for all interfaces");
+
+  /* Fifth filter. Permit IPv4 DNS queries from TAP.
+   * Use a non-zero weight so that the permit filters get higher priority
+   * over the block filter added with automatic weighting */
+
+  Filter.weight.type = FWP_UINT8;
+  Filter.weight.uint8 = 0xE;
   Filter.layerKey = FWPM_LAYER_ALE_AUTH_CONNECT_V4;
   Filter.action.type = FWP_ACTION_PERMIT;
   Filter.numFilterConditions = 2;
@@ -228,7 +281,8 @@ add_block_dns_filters (HANDLE *engine_handle,
   err = FwpmFilterAdd0(*engine_handle, &Filter, NULL, &filterid);
   CHECK_ERROR (err, "Add filter to permit IPv4 DNS traffic through TAP failed");
 
-  /* Sixth filter. Permit IPv6 DNS queries from TAP. */
+  /* Sixth filter. Permit IPv6 DNS queries from TAP.
+   * Use same weight as IPv4 filter */
   Filter.layerKey = FWPM_LAYER_ALE_AUTH_CONNECT_V6;
 
   err = FwpmFilterAdd0(*engine_handle, &Filter, NULL, &filterid);
-- 
1.7.10.4


