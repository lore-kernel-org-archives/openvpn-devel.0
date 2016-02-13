From: Selva Nair <selva.nair@...277...>
Date: Sat, 13 Feb 2016 16:15:08 -0500
Message-Id: <1455398109-28880-2-git-send-email-selva.nair@...277...>
In-Reply-To: <1455398109-28880-1-git-send-email-selva.nair@...277...>
References: <1455398109-28880-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH 1/2] Refactor and move the block-outside-dns
	code to a new file (block_dns.[ch])
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

- Move the core of win_wfp_block_dns() to a new function
- Remove globals and make it independent of the rest of the code

This facilitates implementing support for block-outside-dns through
the interactive service. Should not change any functionality.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/Makefile.am |    2 +-
 src/openvpn/block_dns.c |  265 +++++++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/block_dns.h |   40 +++++++
 src/openvpn/win32.c     |  213 ++++++-------------------------------
 4 files changed, 337 insertions(+), 183 deletions(-)
 create mode 100644 src/openvpn/block_dns.c
 create mode 100644 src/openvpn/block_dns.h

diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index c55a520..bf1d749 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -126,6 +126,6 @@ openvpn_LDADD = \
 	$(OPTIONAL_SYSTEMD_LIBS) \
 	$(OPTIONAL_DL_LIBS)
 if WIN32
-openvpn_SOURCES += openvpn_win32_resources.rc
+openvpn_SOURCES += openvpn_win32_resources.rc block_dns.c block_dns.h
 openvpn_LDADD += -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinmm -lfwpuclnt -lrpcrt4
 endif
diff --git a/src/openvpn/block_dns.c b/src/openvpn/block_dns.c
new file mode 100644
index 0000000..936e4be
--- /dev/null
+++ b/src/openvpn/block_dns.c
@@ -0,0 +1,265 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
+ *                2015-2016  <iam@...2070...>
+ *                2016 Selva Nair <selva.nair@...277...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifdef WIN32
+
+#include <fwpmu.h>
+#include <initguid.h>
+#include <fwpmtypes.h>
+#include <iphlpapi.h>
+#include "block_dns.h"
+
+/*
+ * WFP-related defines and GUIDs not in mingw32
+ */
+
+#ifndef FWPM_SESSION_FLAG_DYNAMIC
+#define FWPM_SESSION_FLAG_DYNAMIC 0x00000001
+#endif
+
+// c38d57d1-05a7-4c33-904f-7fbceee60e82
+DEFINE_GUID(
+   FWPM_LAYER_ALE_AUTH_CONNECT_V4,
+   0xc38d57d1,
+   0x05a7,
+   0x4c33,
+   0x90, 0x4f, 0x7f, 0xbc, 0xee, 0xe6, 0x0e, 0x82
+);
+
+// 4a72393b-319f-44bc-84c3-ba54dcb3b6b4
+DEFINE_GUID(
+   FWPM_LAYER_ALE_AUTH_CONNECT_V6,
+   0x4a72393b,
+   0x319f,
+   0x44bc,
+   0x84, 0xc3, 0xba, 0x54, 0xdc, 0xb3, 0xb6, 0xb4
+);
+
+// d78e1e87-8644-4ea5-9437-d809ecefc971
+DEFINE_GUID(
+   FWPM_CONDITION_ALE_APP_ID,
+   0xd78e1e87,
+   0x8644,
+   0x4ea5,
+   0x94, 0x37, 0xd8, 0x09, 0xec, 0xef, 0xc9, 0x71
+);
+
+// c35a604d-d22b-4e1a-91b4-68f674ee674b
+DEFINE_GUID(
+   FWPM_CONDITION_IP_REMOTE_PORT,
+   0xc35a604d,
+   0xd22b,
+   0x4e1a,
+   0x91, 0xb4, 0x68, 0xf6, 0x74, 0xee, 0x67, 0x4b
+);
+
+// 4cd62a49-59c3-4969-b7f3-bda5d32890a4
+DEFINE_GUID(
+   FWPM_CONDITION_IP_LOCAL_INTERFACE,
+   0x4cd62a49,
+   0x59c3,
+   0x4969,
+   0xb7, 0xf3, 0xbd, 0xa5, 0xd3, 0x28, 0x90, 0xa4
+);
+
+/*
+ * Default msg handler does nothing
+ */
+static inline void
+default_msg_handler (DWORD err, const char *msg)
+{
+  return;
+}
+
+#define CHECK_ERROR(err, msg) \
+   if (err) { msg_handler (err, msg); goto out; }
+
+/*
+ * Block outgoing port 53 traffic except for
+ * (i) adapter with the specified index
+ * OR
+ * (ii) processes with the specified executable path
+ * The firewall filters added here are automatically removed when the process exits or
+ * on calling DeleteBlockDNS().
+ * Arguments:
+ *   engine_handle : On successful return contains the handle for a newly opened fwp session
+ *                   in which the filters are added.
+ *                   May be closed by passing to delete_block_dns_filters to remove the filters.
+ *   index         : The index of adapter for which traffic is permitted.
+ *   exe_path      : Path of executable for which traffic is permitted.
+ *   msg_handler   : An optional callback function for error reporting.
+ * Returns 0 on success, a non-zero status code of the last failed action on failure.
+ */
+
+DWORD
+add_block_dns_filters (HANDLE *engine_handle,
+                       int index,
+                       const WCHAR *exe_path,
+                       block_dns_msg_handler_t msg_handler
+                      )
+{
+  FWPM_SESSION0 session = {0};
+  FWPM_SUBLAYER0 SubLayer = {0};
+  NET_LUID tapluid;
+  UINT64 filterid;
+  FWP_BYTE_BLOB *openvpnblob = NULL;
+  FWPM_FILTER0 Filter = {0};
+  FWPM_FILTER_CONDITION0 Condition[2] = {0};
+  WCHAR *FIREWALL_NAME = L"OpenVPN";
+  DWORD err = 0;
+
+  if (!msg_handler)
+    msg_handler = default_msg_handler;
+
+  /* Add temporary filters which don't survive reboots or crashes. */
+  session.flags = FWPM_SESSION_FLAG_DYNAMIC;
+
+  *engine_handle = NULL;
+
+  err = FwpmEngineOpen0 (NULL, RPC_C_AUTHN_WINNT, NULL, &session, engine_handle);
+  CHECK_ERROR (err, "FwpEngineOpen: open fwp session failed");
+
+  err = UuidCreate (&SubLayer.subLayerKey);
+  CHECK_ERROR (err, "UuidCreate: create sublayer key failed");
+
+  /* Populate packet filter layer information. */
+  SubLayer.displayData.name = FIREWALL_NAME;
+  SubLayer.displayData.description = FIREWALL_NAME;
+  SubLayer.flags = 0;
+  SubLayer.weight = 0x100;
+
+  /* Add sublayer to the session */
+  err = FwpmSubLayerAdd0 (*engine_handle, &SubLayer, NULL);
+  CHECK_ERROR (err, "FwpmSubLayerAdd: add sublayer to session failed");
+
+  msg_handler (0, "Block_DNS: WFP engine opened");
+
+  err = ConvertInterfaceIndexToLuid (index, &tapluid);
+  CHECK_ERROR (err, "Convert interface index to luid failed");
+
+  err = FwpmGetAppIdFromFileName0 (exe_path, &openvpnblob);
+  CHECK_ERROR (err, "Get byte blob for openvpn executable name failed");
+
+  /* Prepare filter. */
+  Filter.subLayerKey = SubLayer.subLayerKey;
+  Filter.displayData.name = FIREWALL_NAME;
+  Filter.weight.type = FWP_UINT8;
+  Filter.weight.uint8 = 0xF;
+  Filter.filterCondition = Condition;
+  Filter.numFilterConditions = 2;
+
+  /* First filter. Permit IPv4 DNS queries from OpenVPN itself. */
+  Filter.layerKey = FWPM_LAYER_ALE_AUTH_CONNECT_V4;
+  Filter.action.type = FWP_ACTION_PERMIT;
+
+  Condition[0].fieldKey = FWPM_CONDITION_IP_REMOTE_PORT;
+  Condition[0].matchType = FWP_MATCH_EQUAL;
+  Condition[0].conditionValue.type = FWP_UINT16;
+  Condition[0].conditionValue.uint16 = 53;
+
+  Condition[1].fieldKey = FWPM_CONDITION_ALE_APP_ID;
+  Condition[1].matchType = FWP_MATCH_EQUAL;
+  Condition[1].conditionValue.type = FWP_BYTE_BLOB_TYPE;
+  Condition[1].conditionValue.byteBlob = openvpnblob;
+
+  err = FwpmFilterAdd0(*engine_handle, &Filter, NULL, &filterid);
+  CHECK_ERROR (err, "Add filter to permit IPv4 port 53 traffic from OpenVPN failed");
+
+  /* Second filter. Permit IPv6 DNS queries from OpenVPN itself. */
+  Filter.layerKey = FWPM_LAYER_ALE_AUTH_CONNECT_V6;
+
+  err = FwpmFilterAdd0(*engine_handle, &Filter, NULL, &filterid);
+  CHECK_ERROR (err, "Add filter to permit IPv6 port 53 traffic from OpenVPN failed");
+
+  msg_handler (0, "Block_DNS: Added permit filters for exe_path");
+
+  /* Third filter. Block all IPv4 DNS queries. */
+  Filter.layerKey = FWPM_LAYER_ALE_AUTH_CONNECT_V4;
+  Filter.action.type = FWP_ACTION_BLOCK;
+  Filter.weight.type = FWP_EMPTY;
+  Filter.numFilterConditions = 1;
+
+  err = FwpmFilterAdd0(*engine_handle, &Filter, NULL, &filterid);
+  CHECK_ERROR (err, "Add filter to block IPv4 DNS traffic failed");
+
+  msg_handler (0, "Block_DNS: Added block filters for all");
+
+  /* Forth filter. Block all IPv6 DNS queries. */
+  Filter.layerKey = FWPM_LAYER_ALE_AUTH_CONNECT_V6;
+
+  err = FwpmFilterAdd0(*engine_handle, &Filter, NULL, &filterid);
+  CHECK_ERROR (err, "Add filter to block IPv6 DNS traffic failed");
+
+  /* Fifth filter. Permit IPv4 DNS queries from TAP. */
+  Filter.layerKey = FWPM_LAYER_ALE_AUTH_CONNECT_V4;
+  Filter.action.type = FWP_ACTION_PERMIT;
+  Filter.numFilterConditions = 2;
+
+  Condition[1].fieldKey = FWPM_CONDITION_IP_LOCAL_INTERFACE;
+  Condition[1].matchType = FWP_MATCH_EQUAL;
+  Condition[1].conditionValue.type = FWP_UINT64;
+  Condition[1].conditionValue.uint64 = &tapluid.Value;
+
+  err = FwpmFilterAdd0(*engine_handle, &Filter, NULL, &filterid);
+  CHECK_ERROR (err, "Add filter to permit IPv4 DNS traffic through TAP failed");
+
+  /* Sixth filter. Permit IPv6 DNS queries from TAP. */
+  Filter.layerKey = FWPM_LAYER_ALE_AUTH_CONNECT_V6;
+
+  err = FwpmFilterAdd0(*engine_handle, &Filter, NULL, &filterid);
+  CHECK_ERROR (err, "Add filter to permit IPv6 DNS traffic through TAP failed");
+
+  msg_handler (0, "Block_DNS: Added permit filters for TAP interface");
+
+out:
+
+  if (openvpnblob)
+    FwpmFreeMemory0 ((void **)&openvpnblob);
+
+  if (err && *engine_handle)
+    {
+      FwpmEngineClose0 (*engine_handle);
+      *engine_handle = NULL;
+    }
+
+  return err;
+}
+
+DWORD
+delete_block_dns_filters (HANDLE engine_handle)
+{
+  DWORD err = 0;
+  /*
+   * For dynamic sessions closing the engine removes all filters added in the session
+   */
+  if (engine_handle)
+    {
+      err = FwpmEngineClose0(engine_handle);
+    }
+  return err;
+}
+
+#endif
diff --git a/src/openvpn/block_dns.h b/src/openvpn/block_dns.h
new file mode 100644
index 0000000..e945351
--- /dev/null
+++ b/src/openvpn/block_dns.h
@@ -0,0 +1,40 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2016 Selva Nair <selva.nair@...277...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifdef WIN32
+
+#ifndef OPENVPN_BLOCK_DNS_H
+#define OPENVPN_BLOCK_DNS_H
+
+typedef void (*block_dns_msg_handler_t) (DWORD err, const char *msg);
+
+DWORD
+delete_block_dns_filters (HANDLE engine);
+
+DWORD
+add_block_dns_filters (HANDLE *engine, int iface_index, const WCHAR *exe_path,
+                       block_dns_msg_handler_t msg_handler_callback);
+
+#endif
+#endif
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 6b7a6ae..9efc0bc 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -43,6 +43,7 @@
 #include "sig.h"
 #include "win32.h"
 #include "misc.h"
+#include "openvpn-msg.h"
 
 #include "memdbg.h"
 
@@ -52,70 +53,10 @@
 #include "compat-versionhelpers.h"
 #endif
 
-/*
- * WFP-related defines and GUIDs.
- */
-#include <fwpmu.h>
-#include <initguid.h>
-#include <fwpmtypes.h>
-#include <iphlpapi.h>
-
-#ifndef FWPM_SESSION_FLAG_DYNAMIC
-#define FWPM_SESSION_FLAG_DYNAMIC 0x00000001
-#endif
-
-// c38d57d1-05a7-4c33-904f-7fbceee60e82
-DEFINE_GUID(
-   FWPM_LAYER_ALE_AUTH_CONNECT_V4,
-   0xc38d57d1,
-   0x05a7,
-   0x4c33,
-   0x90, 0x4f, 0x7f, 0xbc, 0xee, 0xe6, 0x0e, 0x82
-);
-
-// 4a72393b-319f-44bc-84c3-ba54dcb3b6b4
-DEFINE_GUID(
-   FWPM_LAYER_ALE_AUTH_CONNECT_V6,
-   0x4a72393b,
-   0x319f,
-   0x44bc,
-   0x84, 0xc3, 0xba, 0x54, 0xdc, 0xb3, 0xb6, 0xb4
-);
-
-// d78e1e87-8644-4ea5-9437-d809ecefc971
-DEFINE_GUID(
-   FWPM_CONDITION_ALE_APP_ID,
-   0xd78e1e87,
-   0x8644,
-   0x4ea5,
-   0x94, 0x37, 0xd8, 0x09, 0xec, 0xef, 0xc9, 0x71
-);
-
-// c35a604d-d22b-4e1a-91b4-68f674ee674b
-DEFINE_GUID(
-   FWPM_CONDITION_IP_REMOTE_PORT,
-   0xc35a604d,
-   0xd22b,
-   0x4e1a,
-   0x91, 0xb4, 0x68, 0xf6, 0x74, 0xee, 0x67, 0x4b
-);
-
-// 4cd62a49-59c3-4969-b7f3-bda5d32890a4
-DEFINE_GUID(
-   FWPM_CONDITION_IP_LOCAL_INTERFACE,
-   0x4cd62a49,
-   0x59c3,
-   0x4969,
-   0xb7, 0xf3, 0xbd, 0xa5, 0xd3, 0x28, 0x90, 0xa4
-);
-
-/*
- * WFP firewall name.
- */
-WCHAR * FIREWALL_NAME = L"OpenVPN"; /* GLOBAL */
+#include "block_dns.h"
 
 /*
- * WFP handle and GUID.
+ * WFP handle
  */
 static HANDLE m_hEngineHandle = NULL; /* GLOBAL */
 
@@ -1151,146 +1092,54 @@ win_get_tempdir()
   return tmpdir;
 }
 
-bool
-win_wfp_add_filter (HANDLE engineHandle,
-                    const FWPM_FILTER0 *filter,
-                    PSECURITY_DESCRIPTOR sd,
-                    UINT64 *id)
+static void
+block_dns_msg_handler (DWORD err, const char *msg)
 {
-    if (FwpmFilterAdd0(engineHandle, filter, sd, id) != ERROR_SUCCESS)
+  struct gc_arena gc = gc_new ();
+
+  if (err == 0)
     {
-        msg (M_NONFATAL, "Can't add WFP filter");
-        return false;
+      msg (M_INFO, "%s", msg);
     }
-    return true;
+  else
+    {
+      msg (M_WARN, "Error in add_block_dns_filters(): %s : %s [status=%lu]",
+           msg, strerror_win32 (err, &gc), err);
+    }
+
+  gc_free (&gc);
 }
 
 bool
 win_wfp_block_dns (const NET_IFINDEX index)
 {
-    FWPM_SESSION0 session = {0};
-    FWPM_SUBLAYER0 SubLayer = {0};
-    NET_LUID tapluid;
-    UINT64 filterid;
-    WCHAR openvpnpath[MAX_PATH];
-    FWP_BYTE_BLOB *openvpnblob = NULL;
-    FWPM_FILTER0 Filter = {0};
-    FWPM_FILTER_CONDITION0 Condition[2] = {0};
-
-    /* Add temporary filters which don't survive reboots or crashes. */
-    session.flags = FWPM_SESSION_FLAG_DYNAMIC;
-
-    dmsg (D_LOW, "Opening WFP engine");
+  WCHAR openvpnpath[MAX_PATH];
+  bool ret = false;
+  DWORD status;
 
-    if (FwpmEngineOpen0(NULL, RPC_C_AUTHN_WINNT, NULL, &session, &m_hEngineHandle) != ERROR_SUCCESS)
+  status = GetModuleFileNameW (NULL, openvpnpath, sizeof(openvpnpath));
+  if (status == 0 || status == sizeof(openvpnpath))
     {
-        msg (M_NONFATAL, "Can't open WFP engine");
-        return false;
+      msg (M_WARN|M_ERRNO, "block_dns: cannot get executable path");
+      goto out;
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
-    {
-        msg (M_NONFATAL, "Can't add WFP sublayer");
-        return false;
-    }
+  status = add_block_dns_filters (&m_hEngineHandle, index, openvpnpath,
+                                 block_dns_msg_handler);
+  ret = (status == 0);
 
-    dmsg (D_LOW, "Blocking DNS using WFP");
-    if (ConvertInterfaceIndexToLuid(index, &tapluid) != NO_ERROR)
-    {
-        msg (M_NONFATAL, "Can't convert interface index to LUID");
-        return false;
-    }
-    dmsg (D_LOW, "Tap Luid: %I64d", tapluid.Value);
-
-    /* Get OpenVPN path. */
-    GetModuleFileNameW(NULL, openvpnpath, MAX_PATH);
-
-    if (FwpmGetAppIdFromFileName0(openvpnpath, &openvpnblob) != ERROR_SUCCESS)
-        return false;
-
-    /* Prepare filter. */
-    Filter.subLayerKey = SubLayer.subLayerKey;
-    Filter.displayData.name = FIREWALL_NAME;
-    Filter.weight.type = FWP_EMPTY;
-    Filter.filterCondition = Condition;
-    Filter.numFilterConditions = 2;
-
-    /* First filter. Block IPv4 DNS queries except from OpenVPN itself. */
-    Filter.layerKey = FWPM_LAYER_ALE_AUTH_CONNECT_V4;
-    Filter.action.type = FWP_ACTION_BLOCK;
-
-    Condition[0].fieldKey = FWPM_CONDITION_IP_REMOTE_PORT;
-    Condition[0].matchType = FWP_MATCH_EQUAL;
-    Condition[0].conditionValue.type = FWP_UINT16;
-    Condition[0].conditionValue.uint16 = 53;
-
-    Condition[1].fieldKey = FWPM_CONDITION_ALE_APP_ID;
-    Condition[1].matchType = FWP_MATCH_NOT_EQUAL;
-    Condition[1].conditionValue.type = FWP_BYTE_BLOB_TYPE;
-    Condition[1].conditionValue.byteBlob = openvpnblob;
-
-    /* Add filter condition to our interface. */
-    if (!win_wfp_add_filter(m_hEngineHandle, &Filter, NULL, &filterid))
-        goto err;
-    dmsg (D_LOW, "Filter (Block IPv4 DNS) added with ID=%I64d", filterid);
-
-    /* Second filter. Block IPv6 DNS queries except from OpenVPN itself. */
-    Filter.layerKey = FWPM_LAYER_ALE_AUTH_CONNECT_V6;
-
-    /* Add filter condition to our interface. */
-    if (!win_wfp_add_filter(m_hEngineHandle, &Filter, NULL, &filterid))
-        goto err;
-    dmsg (D_LOW, "Filter (Block IPv6 DNS) added with ID=%I64d", filterid);
-
-    /* Third filter. Permit IPv4 DNS queries from TAP. */
-    Filter.layerKey = FWPM_LAYER_ALE_AUTH_CONNECT_V4;
-    Filter.action.type = FWP_ACTION_PERMIT;
-
-    Condition[1].fieldKey = FWPM_CONDITION_IP_LOCAL_INTERFACE;
-    Condition[1].matchType = FWP_MATCH_EQUAL;
-    Condition[1].conditionValue.type = FWP_UINT64;
-    Condition[1].conditionValue.uint64 = &tapluid.Value;
-
-    /* Add filter condition to our interface. */
-    if (!win_wfp_add_filter(m_hEngineHandle, &Filter, NULL, &filterid))
-        goto err;
-    dmsg (D_LOW, "Filter (Permit IPv4 DNS queries from TAP) added with ID=%I64d", filterid);
-
-    /* Forth filter. Permit IPv6 DNS queries from TAP. */
-    Filter.layerKey = FWPM_LAYER_ALE_AUTH_CONNECT_V6;
-
-    /* Add filter condition to our interface. */
-    if (!win_wfp_add_filter(m_hEngineHandle, &Filter, NULL, &filterid))
-        goto err;
-    dmsg (D_LOW, "Filter (Permit IPv6 DNS queries from TAP) added with ID=%I64d", filterid);
-
-    FwpmFreeMemory0((void **)&openvpnblob);
-    return true;
+out:
 
-    err:
-        FwpmFreeMemory0((void **)&openvpnblob);
-        return false;
+  return ret;
 }
 
 bool
 win_wfp_uninit()
 {
     dmsg (D_LOW, "Uninitializing WFP");
-    if (m_hEngineHandle) {
-        FwpmEngineClose0(m_hEngineHandle);
-        m_hEngineHandle = NULL;
-    }
+
+    delete_block_dns_filters (m_hEngineHandle);
+
     return true;
 }
 
-- 
1.7.10.4


