From: Gert Doering <gert@...1296...>
Date: Wed,  5 Jun 2024 14:38:56 +0200
Message-ID: <20240605123856.26267-1-gert@...1296...>
In-Reply-To: <gerrit.1704761332000.Ic9bf797bfc7e2d471998a84cb0f071db3e4832ba@...2715...>
References: <gerrit.1704761332000.Ic9bf797bfc7e2d471998a84cb0f071db3e4832ba@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v6] Windows: enforce 'block-local' with WFP
 filters
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

From: Heiko Hund <heiko@...2662...>

In an attempt to better defend against the TunnelCrack attacks, enforce
that no traffic can pass to anything else than the VPN interface when
the 'block-local' flags is given with either --redirect-gateway or
--redirect-private.

Reuse much of the existing --block-outside-dns code, but make it more
general, so that it can also block any traffic, not just port 53.

Uses the Windows Filtering Platform for enforcement in addition to the
routes redirecting the networks into the tunnel.

Change-Id: Ic9bf797bfc7e2d471998a84cb0f071db3e4832ba
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/489
This mail reflects revision 6 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index f8b37a9..096837d 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -369,8 +369,6 @@
     src/openvpn/base64.c
     src/openvpn/base64.h
     src/openvpn/basic.h
-    src/openvpn/block_dns.h
-    src/openvpn/block_dns.c
     src/openvpn/buffer.c
     src/openvpn/buffer.h
     src/openvpn/circ_list.h
@@ -550,6 +548,8 @@
     src/openvpn/ssl_util.h
     src/openvpn/vlan.c
     src/openvpn/vlan.h
+    src/openvpn/wfp_block.c
+    src/openvpn/wfp_block.h
     src/openvpn/win32.c
     src/openvpn/win32-util.c
     src/openvpn/win32.h
diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vpn-network-options.rst
index 98b4971..84d4273 100644
--- a/doc/man-sections/vpn-network-options.rst
+++ b/doc/man-sections/vpn-network-options.rst
@@ -352,6 +352,10 @@
       Block access to local LAN when the tunnel is active, except for
       the LAN gateway itself. This is accomplished by routing the local
       LAN (except for the LAN gateway address) into the tunnel.
+      On Windows WFP filters are added in addition to the routes which
+      block access to resources not routed through the VPN adapter.
+      Push this flag to protect against TunnelCrack type of attacks
+      (see: https://tunnelcrack.mathyvanhoef.com/).
 
   :code:`ipv6`
       Redirect IPv6 routing into the tunnel. This works similar to
diff --git a/include/openvpn-msg.h b/include/openvpn-msg.h
index 657eb5e..7a99335 100644
--- a/include/openvpn-msg.h
+++ b/include/openvpn-msg.h
@@ -24,6 +24,9 @@
 #ifndef OPENVPN_MSG_H_
 #define OPENVPN_MSG_H_
 
+#include <windef.h>
+#include <ws2tcpip.h>
+
 typedef enum {
     msg_acknowledgement,
     msg_add_address,
@@ -35,8 +38,8 @@
     msg_add_nbt_cfg,
     msg_del_nbt_cfg,
     msg_flush_neighbors,
-    msg_add_block_dns,
-    msg_del_block_dns,
+    msg_add_wfp_block,
+    msg_del_wfp_block,
     msg_register_dns,
     msg_enable_dhcp,
     msg_register_ring_buffers,
@@ -61,6 +64,11 @@
     char name[256];
 } interface_t;
 
+typedef enum {
+    wfp_block_local = 1<<0,
+    wfp_block_dns = 1<<1
+} wfp_block_flags_t;
+
 typedef struct {
     message_header_t header;
     short family;
@@ -120,8 +128,9 @@
 
 typedef struct {
     message_header_t header;
+    wfp_block_flags_t flags;
     interface_t iface;
-} block_dns_message_t;
+} wfp_block_message_t;
 
 typedef struct {
     message_header_t header;
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 7ceec0c..56cce9d 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -156,6 +156,6 @@
 	$(OPTIONAL_DL_LIBS) \
 	$(OPTIONAL_INOTIFY_LIBS)
 if WIN32
-openvpn_SOURCES += openvpn_win32_resources.rc block_dns.c block_dns.h ring_buffer.h
+openvpn_SOURCES += openvpn_win32_resources.rc wfp_block.c wfp_block.h ring_buffer.h
 openvpn_LDADD += -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinmm -lfwpuclnt -lrpcrt4 -lncrypt -lsetupapi -lbcrypt
 endif
diff --git a/src/openvpn/block_dns.c b/src/openvpn/block_dns.c
deleted file mode 100644
index 5f4925f..0000000
--- a/src/openvpn/block_dns.c
+++ /dev/null
@@ -1,423 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP networks
- *             over a single TCP/UDP port, with support for SSL/TLS-based
- *             session authentication and key exchange,
- *             packet encryption, packet authentication, and
- *             packet compression.
- *
- *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
- *                2015-2016  <iam@...2070...>
- *                2016 Selva Nair <selva.nair@...277...>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2
- *  as published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-#ifdef HAVE_CONFIG_H
-#include "config.h"
-#endif
-
-#include "syshead.h"
-
-#ifdef _WIN32
-
-#include <fwpmu.h>
-#include <initguid.h>
-#include <fwpmtypes.h>
-#include <winsock2.h>
-#include <ws2ipdef.h>
-#include <iphlpapi.h>
-#include "block_dns.h"
-
-/*
- * WFP-related defines and GUIDs not in mingw32
- */
-
-#ifndef FWPM_SESSION_FLAG_DYNAMIC
-#define FWPM_SESSION_FLAG_DYNAMIC 0x00000001
-#endif
-
-/* c38d57d1-05a7-4c33-904f-7fbceee60e82 */
-DEFINE_GUID(
-    FWPM_LAYER_ALE_AUTH_CONNECT_V4,
-    0xc38d57d1,
-    0x05a7,
-    0x4c33,
-    0x90, 0x4f, 0x7f, 0xbc, 0xee, 0xe6, 0x0e, 0x82
-    );
-
-/* 4a72393b-319f-44bc-84c3-ba54dcb3b6b4 */
-DEFINE_GUID(
-    FWPM_LAYER_ALE_AUTH_CONNECT_V6,
-    0x4a72393b,
-    0x319f,
-    0x44bc,
-    0x84, 0xc3, 0xba, 0x54, 0xdc, 0xb3, 0xb6, 0xb4
-    );
-
-/* d78e1e87-8644-4ea5-9437-d809ecefc971 */
-DEFINE_GUID(
-    FWPM_CONDITION_ALE_APP_ID,
-    0xd78e1e87,
-    0x8644,
-    0x4ea5,
-    0x94, 0x37, 0xd8, 0x09, 0xec, 0xef, 0xc9, 0x71
-    );
-
-/* c35a604d-d22b-4e1a-91b4-68f674ee674b */
-DEFINE_GUID(
-    FWPM_CONDITION_IP_REMOTE_PORT,
-    0xc35a604d,
-    0xd22b,
-    0x4e1a,
-    0x91, 0xb4, 0x68, 0xf6, 0x74, 0xee, 0x67, 0x4b
-    );
-
-/* 4cd62a49-59c3-4969-b7f3-bda5d32890a4 */
-DEFINE_GUID(
-    FWPM_CONDITION_IP_LOCAL_INTERFACE,
-    0x4cd62a49,
-    0x59c3,
-    0x4969,
-    0xb7, 0xf3, 0xbd, 0xa5, 0xd3, 0x28, 0x90, 0xa4
-    );
-
-/* UUID of WFP sublayer used by all instances of openvpn
- * 2f660d7e-6a37-11e6-a181-001e8c6e04a2 */
-DEFINE_GUID(
-    OPENVPN_BLOCK_OUTSIDE_DNS_SUBLAYER,
-    0x2f660d7e,
-    0x6a37,
-    0x11e6,
-    0xa1, 0x81, 0x00, 0x1e, 0x8c, 0x6e, 0x04, 0xa2
-    );
-
-static WCHAR *FIREWALL_NAME = L"OpenVPN";
-
-/*
- * Default msg handler does nothing
- */
-static inline void
-default_msg_handler(DWORD err, const char *msg)
-{
-    return;
-}
-
-#define CHECK_ERROR(err, msg) \
-    if (err) { msg_handler(err, msg); goto out; }
-
-/*
- * Add a persistent sublayer with specified uuid.
- */
-static DWORD
-add_sublayer(GUID uuid)
-{
-    FWPM_SESSION0 session;
-    HANDLE engine = NULL;
-    DWORD err = 0;
-    FWPM_SUBLAYER0 sublayer;
-
-    memset(&session, 0, sizeof(session));
-    memset(&sublayer, 0, sizeof(sublayer));
-
-    err = FwpmEngineOpen0(NULL, RPC_C_AUTHN_WINNT, NULL, &session, &engine);
-    if (err != ERROR_SUCCESS)
-    {
-        goto out;
-    }
-
-    sublayer.subLayerKey = uuid;
-    sublayer.displayData.name = FIREWALL_NAME;
-    sublayer.displayData.description = FIREWALL_NAME;
-    sublayer.flags = 0;
-    sublayer.weight = 0x100;
-
-    /* Add sublayer to the session */
-    err = FwpmSubLayerAdd0(engine, &sublayer, NULL);
-
-out:
-    if (engine)
-    {
-        FwpmEngineClose0(engine);
-    }
-    return err;
-}
-
-/*
- * Block outgoing port 53 traffic except for
- * (i) adapter with the specified index
- * OR
- * (ii) processes with the specified executable path
- * The firewall filters added here are automatically removed when the process exits or
- * on calling delete_block_dns_filters().
- * Arguments:
- *   engine_handle : On successful return contains the handle for a newly opened fwp session
- *                   in which the filters are added.
- *                   May be closed by passing to delete_block_dns_filters to remove the filters.
- *   index         : The index of adapter for which traffic is permitted.
- *   exe_path      : Path of executable for which traffic is permitted.
- *   msg_handler   : An optional callback function for error reporting.
- * Returns 0 on success, a non-zero status code of the last failed action on failure.
- */
-
-DWORD
-add_block_dns_filters(HANDLE *engine_handle,
-                      int index,
-                      const WCHAR *exe_path,
-                      block_dns_msg_handler_t msg_handler
-                      )
-{
-    FWPM_SESSION0 session = {0};
-    FWPM_SUBLAYER0 *sublayer_ptr = NULL;
-    NET_LUID tapluid;
-    UINT64 filterid;
-    FWP_BYTE_BLOB *openvpnblob = NULL;
-    FWPM_FILTER0 Filter = {0};
-    FWPM_FILTER_CONDITION0 Condition[2] = {0};
-    DWORD err = 0;
-
-    if (!msg_handler)
-    {
-        msg_handler = default_msg_handler;
-    }
-
-    /* Add temporary filters which don't survive reboots or crashes. */
-    session.flags = FWPM_SESSION_FLAG_DYNAMIC;
-
-    *engine_handle = NULL;
-
-    err = FwpmEngineOpen0(NULL, RPC_C_AUTHN_WINNT, NULL, &session, engine_handle);
-    CHECK_ERROR(err, "FwpEngineOpen: open fwp session failed");
-    msg_handler(0, "Block_DNS: WFP engine opened");
-
-    /* Check sublayer exists and add one if it does not. */
-    if (FwpmSubLayerGetByKey0(*engine_handle, &OPENVPN_BLOCK_OUTSIDE_DNS_SUBLAYER, &sublayer_ptr)
-        == ERROR_SUCCESS)
-    {
-        msg_handler(0, "Block_DNS: Using existing sublayer");
-        FwpmFreeMemory0((void **)&sublayer_ptr);
-    }
-    else
-    {  /* Add a new sublayer -- as another process may add it in the meantime,
-        * do not treat "already exists" as an error */
-        err = add_sublayer(OPENVPN_BLOCK_OUTSIDE_DNS_SUBLAYER);
-
-        if (err == FWP_E_ALREADY_EXISTS || err == ERROR_SUCCESS)
-        {
-            msg_handler(0, "Block_DNS: Added a persistent sublayer with pre-defined UUID");
-        }
-        else
-        {
-            CHECK_ERROR(err, "add_sublayer: failed to add persistent sublayer");
-        }
-    }
-
-    err = ConvertInterfaceIndexToLuid(index, &tapluid);
-    CHECK_ERROR(err, "Convert interface index to luid failed");
-
-    err = FwpmGetAppIdFromFileName0(exe_path, &openvpnblob);
-    CHECK_ERROR(err, "Get byte blob for openvpn executable name failed");
-
-    /* Prepare filter. */
-    Filter.subLayerKey = OPENVPN_BLOCK_OUTSIDE_DNS_SUBLAYER;
-    Filter.displayData.name = FIREWALL_NAME;
-    Filter.weight.type = FWP_UINT8;
-    Filter.weight.uint8 = 0xF;
-    Filter.filterCondition = Condition;
-    Filter.numFilterConditions = 2;
-
-    /* First filter. Permit IPv4 DNS queries from OpenVPN itself. */
-    Filter.layerKey = FWPM_LAYER_ALE_AUTH_CONNECT_V4;
-    Filter.action.type = FWP_ACTION_PERMIT;
-
-    Condition[0].fieldKey = FWPM_CONDITION_IP_REMOTE_PORT;
-    Condition[0].matchType = FWP_MATCH_EQUAL;
-    Condition[0].conditionValue.type = FWP_UINT16;
-    Condition[0].conditionValue.uint16 = 53;
-
-    Condition[1].fieldKey = FWPM_CONDITION_ALE_APP_ID;
-    Condition[1].matchType = FWP_MATCH_EQUAL;
-    Condition[1].conditionValue.type = FWP_BYTE_BLOB_TYPE;
-    Condition[1].conditionValue.byteBlob = openvpnblob;
-
-    err = FwpmFilterAdd0(*engine_handle, &Filter, NULL, &filterid);
-    CHECK_ERROR(err, "Add filter to permit IPv4 port 53 traffic from OpenVPN failed");
-
-    /* Second filter. Permit IPv6 DNS queries from OpenVPN itself. */
-    Filter.layerKey = FWPM_LAYER_ALE_AUTH_CONNECT_V6;
-
-    err = FwpmFilterAdd0(*engine_handle, &Filter, NULL, &filterid);
-    CHECK_ERROR(err, "Add filter to permit IPv6 port 53 traffic from OpenVPN failed");
-
-    msg_handler(0, "Block_DNS: Added permit filters for exe_path");
-
-    /* Third filter. Block all IPv4 DNS queries. */
-    Filter.layerKey = FWPM_LAYER_ALE_AUTH_CONNECT_V4;
-    Filter.action.type = FWP_ACTION_BLOCK;
-    Filter.weight.type = FWP_EMPTY;
-    Filter.numFilterConditions = 1;
-
-    err = FwpmFilterAdd0(*engine_handle, &Filter, NULL, &filterid);
-    CHECK_ERROR(err, "Add filter to block IPv4 DNS traffic failed");
-
-    /* Forth filter. Block all IPv6 DNS queries. */
-    Filter.layerKey = FWPM_LAYER_ALE_AUTH_CONNECT_V6;
-
-    err = FwpmFilterAdd0(*engine_handle, &Filter, NULL, &filterid);
-    CHECK_ERROR(err, "Add filter to block IPv6 DNS traffic failed");
-
-    msg_handler(0, "Block_DNS: Added block filters for all interfaces");
-
-    /* Fifth filter. Permit IPv4 DNS queries from TAP.
-     * Use a non-zero weight so that the permit filters get higher priority
-     * over the block filter added with automatic weighting */
-
-    Filter.weight.type = FWP_UINT8;
-    Filter.weight.uint8 = 0xE;
-    Filter.layerKey = FWPM_LAYER_ALE_AUTH_CONNECT_V4;
-    Filter.action.type = FWP_ACTION_PERMIT;
-    Filter.numFilterConditions = 2;
-
-    Condition[1].fieldKey = FWPM_CONDITION_IP_LOCAL_INTERFACE;
-    Condition[1].matchType = FWP_MATCH_EQUAL;
-    Condition[1].conditionValue.type = FWP_UINT64;
-    Condition[1].conditionValue.uint64 = &tapluid.Value;
-
-    err = FwpmFilterAdd0(*engine_handle, &Filter, NULL, &filterid);
-    CHECK_ERROR(err, "Add filter to permit IPv4 DNS traffic through TAP failed");
-
-    /* Sixth filter. Permit IPv6 DNS queries from TAP.
-     * Use same weight as IPv4 filter */
-    Filter.layerKey = FWPM_LAYER_ALE_AUTH_CONNECT_V6;
-
-    err = FwpmFilterAdd0(*engine_handle, &Filter, NULL, &filterid);
-    CHECK_ERROR(err, "Add filter to permit IPv6 DNS traffic through TAP failed");
-
-    msg_handler(0, "Block_DNS: Added permit filters for TAP interface");
-
-out:
-
-    if (openvpnblob)
-    {
-        FwpmFreeMemory0((void **)&openvpnblob);
-    }
-
-    if (err && *engine_handle)
-    {
-        FwpmEngineClose0(*engine_handle);
-        *engine_handle = NULL;
-    }
-
-    return err;
-}
-
-DWORD
-delete_block_dns_filters(HANDLE engine_handle)
-{
-    DWORD err = 0;
-    /*
-     * For dynamic sessions closing the engine removes all filters added in the session
-     */
-    if (engine_handle)
-    {
-        err = FwpmEngineClose0(engine_handle);
-    }
-    return err;
-}
-
-/*
- * Return interface metric value for the specified interface index.
- *
- * Arguments:
- *   index         : The index of TAP adapter.
- *   family        : Address family (AF_INET for IPv4 and AF_INET6 for IPv6).
- *   is_auto       : On return set to true if automatic metric is in use.
- *                   Unused if NULL.
- *
- * Returns positive metric value or -1 on error.
- */
-int
-get_interface_metric(const NET_IFINDEX index, const ADDRESS_FAMILY family, int *is_auto)
-{
-    DWORD err = 0;
-    MIB_IPINTERFACE_ROW ipiface;
-    InitializeIpInterfaceEntry(&ipiface);
-    ipiface.Family = family;
-    ipiface.InterfaceIndex = index;
-
-    if (is_auto)
-    {
-        *is_auto = 0;
-    }
-    err = GetIpInterfaceEntry(&ipiface);
-
-    /* On Windows metric is never > INT_MAX so return value of int is ok.
-     * But we check for overflow nevertheless.
-     */
-    if (err == NO_ERROR && ipiface.Metric <= INT_MAX)
-    {
-        if (is_auto)
-        {
-            *is_auto = ipiface.UseAutomaticMetric;
-        }
-        return (int)ipiface.Metric;
-    }
-    return -1;
-}
-
-/*
- * Sets interface metric value for specified interface index.
- *
- * Arguments:
- *   index         : The index of TAP adapter.
- *   family        : Address family (AF_INET for IPv4 and AF_INET6 for IPv6).
- *   metric        : Metric value. 0 for automatic metric.
- * Returns 0 on success, a non-zero status code of the last failed action on failure.
- */
-
-DWORD
-set_interface_metric(const NET_IFINDEX index, const ADDRESS_FAMILY family,
-                     const ULONG metric)
-{
-    DWORD err = 0;
-    MIB_IPINTERFACE_ROW ipiface;
-    InitializeIpInterfaceEntry(&ipiface);
-    ipiface.Family = family;
-    ipiface.InterfaceIndex = index;
-    err = GetIpInterfaceEntry(&ipiface);
-    if (err == NO_ERROR)
-    {
-        if (family == AF_INET)
-        {
-            /* required for IPv4 as per MSDN */
-            ipiface.SitePrefixLength = 0;
-        }
-        ipiface.Metric = metric;
-        if (metric == 0)
-        {
-            ipiface.UseAutomaticMetric = TRUE;
-        }
-        else
-        {
-            ipiface.UseAutomaticMetric = FALSE;
-        }
-        err = SetIpInterfaceEntry(&ipiface);
-        if (err == NO_ERROR)
-        {
-            return 0;
-        }
-    }
-    return err;
-}
-
-#endif /* ifdef _WIN32 */
diff --git a/src/openvpn/block_dns.h b/src/openvpn/block_dns.h
deleted file mode 100644
index 68fea83..0000000
--- a/src/openvpn/block_dns.h
+++ /dev/null
@@ -1,69 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP networks
- *             over a single TCP/UDP port, with support for SSL/TLS-based
- *             session authentication and key exchange,
- *             packet encryption, packet authentication, and
- *             packet compression.
- *
- *  Copyright (C) 2016-2024 Selva Nair <selva.nair@...277...>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2
- *  as published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-#ifdef _WIN32
-
-#ifndef OPENVPN_BLOCK_DNS_H
-#define OPENVPN_BLOCK_DNS_H
-
-/* Any value less than 5 should work fine. 3 is chosen without any real reason. */
-#define BLOCK_DNS_IFACE_METRIC 3
-
-typedef void (*block_dns_msg_handler_t) (DWORD err, const char *msg);
-
-DWORD
-delete_block_dns_filters(HANDLE engine);
-
-DWORD
-add_block_dns_filters(HANDLE *engine, int iface_index, const WCHAR *exe_path,
-                      block_dns_msg_handler_t msg_handler_callback);
-
-/**
- * Return interface metric value for the specified interface index.
- *
- * @param index         The index of TAP adapter.
- * @param family        Address family (AF_INET for IPv4 and AF_INET6 for IPv6).
- * @param is_auto       On return set to true if automatic metric is in use.
- *                      Unused if NULL.
- *
- * @return positive interface metric on success or -1 on error
- */
-int
-get_interface_metric(const NET_IFINDEX index, const ADDRESS_FAMILY family, int *is_auto);
-
-/**
- * Sets interface metric value for specified interface index.
- *
- * @param index The index of TAP adapter
- * @param family Address family (AF_INET for IPv4 and AF_INET6 for IPv6)
- * @param metric Metric value. 0 for automatic metric
- *
- * @return 0 on success, a non-zero status code of the last failed action on failure.
- */
-
-DWORD
-set_interface_metric(const NET_IFINDEX index, const ADDRESS_FAMILY family,
-                     const ULONG metric);
-
-#endif /* ifndef OPENVPN_BLOCK_DNS_H */
-#endif /* ifdef _WIN32 */
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index ec0c309..b081b2f 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1782,6 +1782,54 @@
 #endif
 }
 
+/**
+ * Add WFP filters to block traffic to local networks.
+ * Depending on the configuration all or just DNS is filtered.
+ * This functionality is only available on Windows on all other
+ * systems this function is a noop.
+ *
+ * @param c pointer to the connection context
+ */
+static void
+add_wfp_block(struct context *c)
+{
+#if defined(_WIN32)
+    /* Fortify 'redirect-gateway block-local' with firewall rules? */
+    bool block_local = block_local_needed(c->c1.route_list);
+
+    if (c->options.block_outside_dns || block_local)
+    {
+        BOOL dns_only = !block_local;
+        if (!win_wfp_block(c->c1.tuntap->adapter_index, c->options.msg_channel, dns_only))
+        {
+            msg(M_FATAL, "WFP: initialization failed");
+        }
+    }
+#endif
+}
+
+/**
+ * Remove any WFP block filters previously added.
+ * This functionality is only available on Windows on all other
+ * systems the function is a noop.
+ *
+ * @param c             pointer to the connection context
+ * @param adapter_index the VPN adapter index
+ */
+static void
+del_wfp_block(struct context *c, unsigned long adapter_index)
+{
+#if defined(_WIN32)
+    if (c->options.block_outside_dns || block_local_needed(c->c1.route_list))
+    {
+        if (!win_wfp_uninit(adapter_index, c->options.msg_channel))
+        {
+            msg(M_FATAL, "WFP: deinitialization failed");
+        }
+    }
+#endif
+}
+
 static bool
 do_open_tun(struct context *c, int *error_flags)
 {
@@ -1904,16 +1952,7 @@
                     "up",
                     c->c2.es);
 
-#if defined(_WIN32)
-        if (c->options.block_outside_dns)
-        {
-            dmsg(D_LOW, "Blocking outside DNS");
-            if (!win_wfp_block_dns(c->c1.tuntap->adapter_index, c->options.msg_channel))
-            {
-                msg(M_FATAL, "Blocking DNS failed!");
-            }
-        }
-#endif
+        add_wfp_block(c);
 
         /* possibly add routes */
         if ((route_order() == ROUTE_AFTER_TUN) && (!c->options.route_delay_defined))
@@ -1953,17 +1992,8 @@
                         "up",
                         c->c2.es);
         }
-#if defined(_WIN32)
-        if (c->options.block_outside_dns)
-        {
-            dmsg(D_LOW, "Blocking outside DNS");
-            if (!win_wfp_block_dns(c->c1.tuntap->adapter_index, c->options.msg_channel))
-            {
-                msg(M_FATAL, "Blocking DNS failed!");
-            }
-        }
-#endif
 
+        add_wfp_block(c);
     }
     gc_free(&gc);
     return ret;
@@ -2012,11 +2042,12 @@
 
     struct gc_arena gc = gc_new();
     const char *tuntap_actual = string_alloc(c->c1.tuntap->actual_name, &gc);
-#ifdef _WIN32
-    DWORD adapter_index = c->c1.tuntap->adapter_index;
-#endif
     const in_addr_t local = c->c1.tuntap->local;
     const in_addr_t remote_netmask = c->c1.tuntap->remote_netmask;
+    unsigned long adapter_index = 0;
+#ifdef _WIN32
+    adapter_index = c->c1.tuntap->adapter_index;
+#endif
 
     if (force || !(c->sig->signal_received == SIGUSR1 && c->options.persist_tun))
     {
@@ -2081,15 +2112,7 @@
                     "down",
                     c->c2.es);
 
-#if defined(_WIN32)
-        if (c->options.block_outside_dns)
-        {
-            if (!win_wfp_uninit(adapter_index, c->options.msg_channel))
-            {
-                msg(M_FATAL, "Uninitialising WFP failed!");
-            }
-        }
-#endif
+        del_wfp_block(c, adapter_index);
 
         /* actually close tun/tap device based on --down-pre flag */
         if (c->options.down_pre)
@@ -2120,16 +2143,7 @@
                         c->c2.es);
         }
 
-#if defined(_WIN32)
-        if (c->options.block_outside_dns)
-        {
-            if (!win_wfp_uninit(adapter_index, c->options.msg_channel))
-            {
-                msg(M_FATAL, "Uninitialising WFP failed!");
-            }
-        }
-#endif
-
+        del_wfp_block(c, adapter_index);
     }
     gc_free(&gc);
 }
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 68bbcfd..91f2032 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -25,6 +25,7 @@
  * Support routines for adding/deleting network routes.
  */
 #include <stddef.h>
+#include <stdbool.h>
 
 #ifdef HAVE_CONFIG_H
 #include "config.h"
@@ -74,7 +75,9 @@
 
 #endif
 
-static void delete_route(struct route_ipv4 *r, const struct tuntap *tt, unsigned int flags, const struct route_gateway_info *rgi, const struct env_set *es, openvpn_net_ctx_t *ctx);
+static void delete_route(struct route_ipv4 *r, const struct tuntap *tt, unsigned int flags,
+                         const struct route_gateway_info *rgi, const struct env_set *es,
+                         openvpn_net_ctx_t *ctx);
 
 static void get_bypass_addresses(struct route_bypass *rb, const unsigned int flags);
 
@@ -566,9 +569,7 @@
                      const struct route_gateway_address *gateway,
                      in_addr_t target)
 {
-    const int rgi_needed = (RGI_ADDR_DEFINED|RGI_NETMASK_DEFINED);
-    if ((rl->rgi.flags & rgi_needed) == rgi_needed
-        && rl->rgi.gateway.netmask < 0xFFFFFFFF)
+    if (rl->rgi.gateway.netmask < 0xFFFFFFFF)
     {
         struct route_ipv4 *r1, *r2;
         unsigned int l2;
@@ -593,39 +594,40 @@
 }
 
 static void
-add_block_local(struct route_list *rl)
+add_block_local_routes(struct route_list *rl)
 {
-    const int rgi_needed = (RGI_ADDR_DEFINED|RGI_NETMASK_DEFINED);
-    if ((rl->flags & RG_BLOCK_LOCAL)
-        && (rl->rgi.flags & rgi_needed) == rgi_needed
-        && (rl->spec.flags & RTSA_REMOTE_ENDPOINT)
-        && rl->spec.remote_host_local != TLA_LOCAL)
-    {
-        size_t i;
-
 #ifndef TARGET_ANDROID
-        /* add bypass for gateway addr */
-        add_bypass_address(&rl->spec.bypass, rl->rgi.gateway.addr);
+    /* add bypass for gateway addr */
+    add_bypass_address(&rl->spec.bypass, rl->rgi.gateway.addr);
 #endif
 
-        /* block access to local subnet */
-        add_block_local_item(rl, &rl->rgi.gateway, rl->spec.remote_endpoint);
+    /* block access to local subnet */
+    add_block_local_item(rl, &rl->rgi.gateway, rl->spec.remote_endpoint);
 
-        /* process additional subnets on gateway interface */
-        for (i = 0; i < rl->rgi.n_addrs; ++i)
+    /* process additional subnets on gateway interface */
+    for (size_t i = 0; i < rl->rgi.n_addrs; ++i)
+    {
+        const struct route_gateway_address *gwa = &rl->rgi.addrs[i];
+        /* omit the add/subnet in &rl->rgi which we processed above */
+        if (!((rl->rgi.gateway.addr & rl->rgi.gateway.netmask) == (gwa->addr & gwa->netmask)
+              && rl->rgi.gateway.netmask == gwa->netmask))
         {
-            const struct route_gateway_address *gwa = &rl->rgi.addrs[i];
-            /* omit the add/subnet in &rl->rgi which we processed above */
-            if (!((rl->rgi.gateway.addr & rl->rgi.gateway.netmask) == (gwa->addr & gwa->netmask)
-                  && rl->rgi.gateway.netmask == gwa->netmask))
-            {
-                add_block_local_item(rl, gwa, rl->spec.remote_endpoint);
-            }
+            add_block_local_item(rl, gwa, rl->spec.remote_endpoint);
         }
     }
 }
 
 bool
+block_local_needed(const struct route_list *rl)
+{
+    const int rgi_needed = (RGI_ADDR_DEFINED|RGI_NETMASK_DEFINED);
+    return (rl->flags & RG_BLOCK_LOCAL)
+           && (rl->rgi.flags & rgi_needed) == rgi_needed
+           && (rl->spec.flags & RTSA_REMOTE_ENDPOINT)
+           && rl->spec.remote_host_local != TLA_LOCAL;
+}
+
+bool
 init_route_list(struct route_list *rl,
                 const struct route_option_list *opt,
                 const char *remote_endpoint,
@@ -698,7 +700,10 @@
 
     if (rl->flags & RG_ENABLE)
     {
-        add_block_local(rl);
+        if (block_local_needed(rl))
+        {
+            add_block_local_routes(rl);
+        }
         get_bypass_addresses(&rl->spec.bypass, rl->flags);
 #ifdef ENABLE_DEBUG
         print_bypass_addresses(&rl->spec.bypass);
@@ -1241,6 +1246,7 @@
         }
         rl6->iflags |= RL_ROUTES_ADDED;
     }
+
     return ret;
 }
 
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index eb98c71..421e7d2 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -243,6 +243,18 @@
     struct iroute_ipv6 *next;
 };
 
+/**
+ * Get the decision whether to block traffic to local networks while the VPN
+ * is connected. This definitely returns false when not redirecting the gateway
+ * or when the 'block-local' flag is not set. Also checks for other
+ * prerequisites to redirect local networks into the tunnel.
+ *
+ * @param rl const pointer to the struct route_list to base the decision on.
+ *
+ * @return boolean indicating whether local traffic should be blocked.
+ */
+bool block_local_needed(const struct route_list *rl);
+
 struct route_option_list *new_route_option_list(struct gc_arena *a);
 
 struct route_ipv6_option_list *new_route_ipv6_option_list(struct gc_arena *a);
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index d01515d..ce3d882 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -44,7 +44,7 @@
 #include "manage.h"
 #include "route.h"
 #include "win32.h"
-#include "block_dns.h"
+#include "wfp_block.h"
 #include "networking.h"
 
 #include "memdbg.h"
diff --git a/src/openvpn/wfp_block.c b/src/openvpn/wfp_block.c
new file mode 100644
index 0000000..cf5b39c
--- /dev/null
+++ b/src/openvpn/wfp_block.c
@@ -0,0 +1,477 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
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
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
+#include "syshead.h"
+
+#ifdef _WIN32
+
+#include <fwpmu.h>
+#include <initguid.h>
+#include <fwpmtypes.h>
+#include <winsock2.h>
+#include <ws2ipdef.h>
+#include <iphlpapi.h>
+
+#include "wfp_block.h"
+
+/*
+ * WFP-related defines and GUIDs not in mingw32
+ */
+
+#ifndef FWPM_SESSION_FLAG_DYNAMIC
+#define FWPM_SESSION_FLAG_DYNAMIC 0x00000001
+#endif
+
+/* c38d57d1-05a7-4c33-904f-7fbceee60e82 */
+DEFINE_GUID(
+    FWPM_LAYER_ALE_AUTH_CONNECT_V4,
+    0xc38d57d1,
+    0x05a7,
+    0x4c33,
+    0x90, 0x4f, 0x7f, 0xbc, 0xee, 0xe6, 0x0e, 0x82
+    );
+
+/* 4a72393b-319f-44bc-84c3-ba54dcb3b6b4 */
+DEFINE_GUID(
+    FWPM_LAYER_ALE_AUTH_CONNECT_V6,
+    0x4a72393b,
+    0x319f,
+    0x44bc,
+    0x84, 0xc3, 0xba, 0x54, 0xdc, 0xb3, 0xb6, 0xb4
+    );
+
+/* d78e1e87-8644-4ea5-9437-d809ecefc971 */
+DEFINE_GUID(
+    FWPM_CONDITION_ALE_APP_ID,
+    0xd78e1e87,
+    0x8644,
+    0x4ea5,
+    0x94, 0x37, 0xd8, 0x09, 0xec, 0xef, 0xc9, 0x71
+    );
+
+/* c35a604d-d22b-4e1a-91b4-68f674ee674b */
+DEFINE_GUID(
+    FWPM_CONDITION_IP_REMOTE_PORT,
+    0xc35a604d,
+    0xd22b,
+    0x4e1a,
+    0x91, 0xb4, 0x68, 0xf6, 0x74, 0xee, 0x67, 0x4b
+    );
+
+/* 4cd62a49-59c3-4969-b7f3-bda5d32890a4 */
+DEFINE_GUID(
+    FWPM_CONDITION_IP_LOCAL_INTERFACE,
+    0x4cd62a49,
+    0x59c3,
+    0x4969,
+    0xb7, 0xf3, 0xbd, 0xa5, 0xd3, 0x28, 0x90, 0xa4
+    );
+
+/* 632ce23b-5167-435c-86d7-e903684aa80c */
+DEFINE_GUID(
+    FWPM_CONDITION_FLAGS,
+    0x632ce23b,
+    0x5167,
+    0x435c,
+    0x86, 0xd7, 0xe9, 0x03, 0x68, 0x4a, 0xa8, 0x0c
+    );
+
+/* UUID of WFP sublayer used by all instances of openvpn
+ * 2f660d7e-6a37-11e6-a181-001e8c6e04a2 */
+DEFINE_GUID(
+    OPENVPN_WFP_BLOCK_SUBLAYER,
+    0x2f660d7e,
+    0x6a37,
+    0x11e6,
+    0xa1, 0x81, 0x00, 0x1e, 0x8c, 0x6e, 0x04, 0xa2
+    );
+
+static WCHAR *FIREWALL_NAME = L"OpenVPN";
+
+/*
+ * Default msg handler does nothing
+ */
+static inline void
+default_msg_handler(DWORD err, const char *msg)
+{
+    return;
+}
+
+#define OUT_ON_ERROR(err, msg) \
+    if (err) { msg_handler(err, msg); goto out; }
+
+/*
+ * Add a persistent sublayer with specified uuid.
+ */
+static DWORD
+add_sublayer(GUID uuid)
+{
+    FWPM_SESSION0 session;
+    HANDLE engine = NULL;
+    DWORD err = 0;
+    FWPM_SUBLAYER0 sublayer;
+
+    memset(&session, 0, sizeof(session));
+    memset(&sublayer, 0, sizeof(sublayer));
+
+    err = FwpmEngineOpen0(NULL, RPC_C_AUTHN_WINNT, NULL, &session, &engine);
+    if (err != ERROR_SUCCESS)
+    {
+        goto out;
+    }
+
+    sublayer.subLayerKey = uuid;
+    sublayer.displayData.name = FIREWALL_NAME;
+    sublayer.displayData.description = FIREWALL_NAME;
+    sublayer.flags = 0;
+    sublayer.weight = 0x100;
+
+    /* Add sublayer to the session */
+    err = FwpmSubLayerAdd0(engine, &sublayer, NULL);
+
+out:
+    if (engine)
+    {
+        FwpmEngineClose0(engine);
+    }
+    return err;
+}
+
+/*
+ * Block outgoing local traffic, possibly DNS only, except for
+ * (i) adapter with the specified index (and loopback, if all is blocked)
+ * OR
+ * (ii) processes with the specified executable path
+ * The firewall filters added here are automatically removed when the process exits or
+ * on calling delete_wfp_block_filters().
+ * Arguments:
+ *   engine_handle : On successful return contains the handle for a newly opened fwp session
+ *                   in which the filters are added.
+ *                   May be closed by passing to delete_wfp_block_filters to remove the filters.
+ *   index         : The index of adapter for which traffic is permitted.
+ *   exe_path      : Path of executable for which traffic is permitted.
+ *   msg_handler   : An optional callback function for error reporting.
+ *   dns_only      : Whether the blocking filters should apply for DNS only.
+ * Returns 0 on success, a non-zero status code of the last failed action on failure.
+ */
+
+DWORD
+add_wfp_block_filters(HANDLE *engine_handle,
+                      int index,
+                      const WCHAR *exe_path,
+                      wfp_block_msg_handler_t msg_handler,
+                      BOOL dns_only)
+{
+    FWPM_SESSION0 session = {0};
+    FWPM_SUBLAYER0 *sublayer_ptr = NULL;
+    NET_LUID itf_luid;
+    UINT64 filterid;
+    FWP_BYTE_BLOB *openvpnblob = NULL;
+    FWPM_FILTER0 Filter = {0};
+    FWPM_FILTER_CONDITION0 Condition[2];
+    FWPM_FILTER_CONDITION0 match_openvpn = {0};
+    FWPM_FILTER_CONDITION0 match_port_53 = {0};
+    FWPM_FILTER_CONDITION0 match_interface = {0};
+    FWPM_FILTER_CONDITION0 match_loopback = {0};
+    FWPM_FILTER_CONDITION0 match_not_loopback = {0};
+    DWORD err = 0;
+
+    if (!msg_handler)
+    {
+        msg_handler = default_msg_handler;
+    }
+
+    /* Add temporary filters which don't survive reboots or crashes. */
+    session.flags = FWPM_SESSION_FLAG_DYNAMIC;
+
+    *engine_handle = NULL;
+
+    err = FwpmEngineOpen0(NULL, RPC_C_AUTHN_WINNT, NULL, &session, engine_handle);
+    OUT_ON_ERROR(err, "FwpEngineOpen: open fwp session failed");
+    msg_handler(0, "WFP Block: WFP engine opened");
+
+    /* Check sublayer exists and add one if it does not. */
+    if (FwpmSubLayerGetByKey0(*engine_handle, &OPENVPN_WFP_BLOCK_SUBLAYER, &sublayer_ptr)
+        == ERROR_SUCCESS)
+    {
+        msg_handler(0, "WFP Block: Using existing sublayer");
+        FwpmFreeMemory0((void **)&sublayer_ptr);
+    }
+    else
+    {  /* Add a new sublayer -- as another process may add it in the meantime,
+        * do not treat "already exists" as an error */
+        err = add_sublayer(OPENVPN_WFP_BLOCK_SUBLAYER);
+
+        if (err == FWP_E_ALREADY_EXISTS || err == ERROR_SUCCESS)
+        {
+            msg_handler(0, "WFP Block: Added a persistent sublayer with pre-defined UUID");
+        }
+        else
+        {
+            OUT_ON_ERROR(err, "add_sublayer: failed to add persistent sublayer");
+        }
+    }
+
+    err = ConvertInterfaceIndexToLuid(index, &itf_luid);
+    OUT_ON_ERROR(err, "Convert interface index to luid failed");
+
+    err = FwpmGetAppIdFromFileName0(exe_path, &openvpnblob);
+    OUT_ON_ERROR(err, "Get byte blob for openvpn executable name failed");
+
+    /* Prepare match conditions */
+    match_openvpn.fieldKey = FWPM_CONDITION_ALE_APP_ID;
+    match_openvpn.matchType = FWP_MATCH_EQUAL;
+    match_openvpn.conditionValue.type = FWP_BYTE_BLOB_TYPE;
+    match_openvpn.conditionValue.byteBlob = openvpnblob;
+
+    match_port_53.fieldKey = FWPM_CONDITION_IP_REMOTE_PORT;
+    match_port_53.matchType = FWP_MATCH_EQUAL;
+    match_port_53.conditionValue.type = FWP_UINT16;
+    match_port_53.conditionValue.uint16 = 53;
+
+    match_interface.fieldKey = FWPM_CONDITION_IP_LOCAL_INTERFACE;
+    match_interface.matchType = FWP_MATCH_EQUAL;
+    match_interface.conditionValue.type = FWP_UINT64;
+    match_interface.conditionValue.uint64 = &itf_luid.Value;
+
+    match_loopback.fieldKey = FWPM_CONDITION_FLAGS;
+    match_loopback.matchType = FWP_MATCH_FLAGS_ALL_SET;
+    match_loopback.conditionValue.type = FWP_UINT32;
+    match_loopback.conditionValue.uint32 = FWP_CONDITION_FLAG_IS_LOOPBACK;
+
+    match_not_loopback.fieldKey = FWPM_CONDITION_FLAGS;
+    match_not_loopback.matchType = FWP_MATCH_FLAGS_NONE_SET;
+    match_not_loopback.conditionValue.type = FWP_UINT32;
+    match_not_loopback.conditionValue.uint32 = FWP_CONDITION_FLAG_IS_LOOPBACK;
+
+    /* Prepare filter. */
+    Filter.subLayerKey = OPENVPN_WFP_BLOCK_SUBLAYER;
+    Filter.displayData.name = FIREWALL_NAME;
+    Filter.weight.type = FWP_UINT8;
+    Filter.weight.uint8 = 0xF;
+    Filter.filterCondition = Condition;
+    Filter.numFilterConditions = 1;
+
+    /* First filter. Permit IPv4 from OpenVPN itself. */
+    Filter.layerKey = FWPM_LAYER_ALE_AUTH_CONNECT_V4;
+    Filter.action.type = FWP_ACTION_PERMIT;
+    Condition[0] = match_openvpn;
+    if (dns_only)
+    {
+        Filter.numFilterConditions = 2;
+        Condition[1] = match_port_53;
+    }
+    err = FwpmFilterAdd0(*engine_handle, &Filter, NULL, &filterid);
+    OUT_ON_ERROR(err, "Add filter to permit IPv4 traffic from OpenVPN failed");
+
+    /* Second filter. Permit IPv6 from OpenVPN itself. */
+    Filter.layerKey = FWPM_LAYER_ALE_AUTH_CONNECT_V6;
+    err = FwpmFilterAdd0(*engine_handle, &Filter, NULL, &filterid);
+    OUT_ON_ERROR(err, "Add filter to permit IPv6 traffic from OpenVPN failed");
+
+    msg_handler(0, "WFP Block: Added permit filters for exe_path");
+
+    /* Third filter. Block IPv4 to port 53 or all except loopback. */
+    Filter.layerKey = FWPM_LAYER_ALE_AUTH_CONNECT_V4;
+    Filter.action.type = FWP_ACTION_BLOCK;
+    Filter.weight.type = FWP_EMPTY;
+    Filter.numFilterConditions = 1;
+    Condition[0] = match_not_loopback;
+    if (dns_only)
+    {
+        Filter.numFilterConditions = 2;
+        Condition[1] = match_port_53;
+    }
+    err = FwpmFilterAdd0(*engine_handle, &Filter, NULL, &filterid);
+    OUT_ON_ERROR(err, "Add filter to block IPv4 traffic failed");
+
+    /* Fourth filter. Block IPv6 to port 53 or all besides loopback */
+    Filter.layerKey = FWPM_LAYER_ALE_AUTH_CONNECT_V6;
+    err = FwpmFilterAdd0(*engine_handle, &Filter, NULL, &filterid);
+    OUT_ON_ERROR(err, "Add filter to block IPv6 traffic failed");
+
+    msg_handler(0, "WFP Block: Added block filters for all interfaces");
+
+    /* Fifth filter. Permit all IPv4 or just DNS traffic for the VPN interface.
+     * Use a non-zero weight so that the permit filters get higher priority
+     * over the block filter added with automatic weighting */
+    Filter.weight.type = FWP_UINT8;
+    Filter.weight.uint8 = 0xE;
+    Filter.layerKey = FWPM_LAYER_ALE_AUTH_CONNECT_V4;
+    Filter.action.type = FWP_ACTION_PERMIT;
+    Filter.numFilterConditions = 1;
+    Condition[0] = match_interface;
+    if (dns_only)
+    {
+        Filter.numFilterConditions = 2;
+        Condition[1] = match_port_53;
+    }
+    err = FwpmFilterAdd0(*engine_handle, &Filter, NULL, &filterid);
+    OUT_ON_ERROR(err, "Add filter to permit IPv4 traffic through VPN interface failed");
+
+    /* Sixth filter. Permit all IPv6 or just DNS traffic for the VPN interface.
+     * Use same weight as IPv4 filter */
+    Filter.layerKey = FWPM_LAYER_ALE_AUTH_CONNECT_V6;
+    err = FwpmFilterAdd0(*engine_handle, &Filter, NULL, &filterid);
+    OUT_ON_ERROR(err, "Add filter to permit IPv6 traffic through VPN interface failed");
+
+    msg_handler(0, "WFP Block: Added permit filters for VPN interface");
+
+    /* Seventh Filter. Block IPv4 DNS requests to loopback from other apps */
+    Filter.layerKey = FWPM_LAYER_ALE_AUTH_CONNECT_V4;
+    Filter.action.type = FWP_ACTION_BLOCK;
+    Filter.weight.type = FWP_EMPTY;
+    Filter.numFilterConditions = 2;
+    Condition[0] = match_loopback;
+    Condition[1] = match_port_53;
+    err = FwpmFilterAdd0(*engine_handle, &Filter, NULL, &filterid);
+    OUT_ON_ERROR(err, "Add filter to block IPv4 DNS traffic to loopback failed");
+
+    /* Eighth Filter. Block IPv6 DNS requests to loopback from other apps */
+    Filter.layerKey = FWPM_LAYER_ALE_AUTH_CONNECT_V6;
+    err = FwpmFilterAdd0(*engine_handle, &Filter, NULL, &filterid);
+    OUT_ON_ERROR(err, "Add filter to block IPv6 DNS traffic to loopback failed");
+
+    msg_handler(0, "WFP Block: Added block filters for DNS traffic to loopback");
+
+out:
+    if (openvpnblob)
+    {
+        FwpmFreeMemory0((void **)&openvpnblob);
+    }
+
+    if (err && *engine_handle)
+    {
+        FwpmEngineClose0(*engine_handle);
+        *engine_handle = NULL;
+    }
+
+    return err;
+}
+
+DWORD
+delete_wfp_block_filters(HANDLE engine_handle)
+{
+    DWORD err = 0;
+    /*
+     * For dynamic sessions closing the engine removes all filters added in the session
+     */
+    if (engine_handle)
+    {
+        err = FwpmEngineClose0(engine_handle);
+    }
+    return err;
+}
+
+/*
+ * Return interface metric value for the specified interface index.
+ *
+ * Arguments:
+ *   index         : The index of TAP adapter.
+ *   family        : Address family (AF_INET for IPv4 and AF_INET6 for IPv6).
+ *   is_auto       : On return set to true if automatic metric is in use.
+ *                   Unused if NULL.
+ *
+ * Returns positive metric value or -1 on error.
+ */
+int
+get_interface_metric(const NET_IFINDEX index, const ADDRESS_FAMILY family, int *is_auto)
+{
+    DWORD err = 0;
+    MIB_IPINTERFACE_ROW ipiface;
+    InitializeIpInterfaceEntry(&ipiface);
+    ipiface.Family = family;
+    ipiface.InterfaceIndex = index;
+
+    if (is_auto)
+    {
+        *is_auto = 0;
+    }
+    err = GetIpInterfaceEntry(&ipiface);
+
+    /* On Windows metric is never > INT_MAX so return value of int is ok.
+     * But we check for overflow nevertheless.
+     */
+    if (err == NO_ERROR && ipiface.Metric <= INT_MAX)
+    {
+        if (is_auto)
+        {
+            *is_auto = ipiface.UseAutomaticMetric;
+        }
+        return (int)ipiface.Metric;
+    }
+    return -1;
+}
+
+/*
+ * Sets interface metric value for specified interface index.
+ *
+ * Arguments:
+ *   index         : The index of TAP adapter.
+ *   family        : Address family (AF_INET for IPv4 and AF_INET6 for IPv6).
+ *   metric        : Metric value. 0 for automatic metric.
+ * Returns 0 on success, a non-zero status code of the last failed action on failure.
+ */
+
+DWORD
+set_interface_metric(const NET_IFINDEX index, const ADDRESS_FAMILY family,
+                     const ULONG metric)
+{
+    DWORD err = 0;
+    MIB_IPINTERFACE_ROW ipiface;
+    InitializeIpInterfaceEntry(&ipiface);
+    ipiface.Family = family;
+    ipiface.InterfaceIndex = index;
+    err = GetIpInterfaceEntry(&ipiface);
+    if (err == NO_ERROR)
+    {
+        if (family == AF_INET)
+        {
+            /* required for IPv4 as per MSDN */
+            ipiface.SitePrefixLength = 0;
+        }
+        ipiface.Metric = metric;
+        if (metric == 0)
+        {
+            ipiface.UseAutomaticMetric = TRUE;
+        }
+        else
+        {
+            ipiface.UseAutomaticMetric = FALSE;
+        }
+        err = SetIpInterfaceEntry(&ipiface);
+        if (err == NO_ERROR)
+        {
+            return 0;
+        }
+    }
+    return err;
+}
+
+#endif /* ifdef _WIN32 */
diff --git a/src/openvpn/wfp_block.h b/src/openvpn/wfp_block.h
new file mode 100644
index 0000000..56dabf6
--- /dev/null
+++ b/src/openvpn/wfp_block.h
@@ -0,0 +1,73 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2016-2024 Selva Nair <selva.nair@...277...>
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
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifdef _WIN32
+
+#ifndef WFP_BLOCK_H
+#define WFP_BLOCK_H
+
+#include <windef.h>
+#include <iphlpapi.h>
+#include <ws2tcpip.h>
+
+/* Any value less than 5 should work fine. 3 is chosen without any real reason. */
+#define WFP_BLOCK_IFACE_METRIC 3
+
+typedef void (*wfp_block_msg_handler_t) (DWORD err, const char *msg);
+
+DWORD
+delete_wfp_block_filters(HANDLE engine);
+
+DWORD
+add_wfp_block_filters(HANDLE *engine, int iface_index, const WCHAR *exe_path,
+                      wfp_block_msg_handler_t msg_handler_callback, BOOL dns_only);
+
+/**
+ * Return interface metric value for the specified interface index.
+ *
+ * @param index         The index of TAP adapter.
+ * @param family        Address family (AF_INET for IPv4 and AF_INET6 for IPv6).
+ * @param is_auto       On return set to true if automatic metric is in use.
+ *                      Unused if NULL.
+ *
+ * @return positive interface metric on success or -1 on error
+ */
+int
+get_interface_metric(const NET_IFINDEX index, const ADDRESS_FAMILY family, int *is_auto);
+
+/**
+ * Sets interface metric value for specified interface index.
+ *
+ * @param index The index of TAP adapter
+ * @param family Address family (AF_INET for IPv4 and AF_INET6 for IPv6)
+ * @param metric Metric value. 0 for automatic metric
+ *
+ * @return 0 on success, a non-zero status code of the last failed action on failure.
+ */
+
+DWORD
+set_interface_metric(const NET_IFINDEX index, const ADDRESS_FAMILY family,
+                     const ULONG metric);
+
+#endif /* ifndef WFP_BLOCK_H */
+#endif /* ifdef _WIN32 */
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 98955ba..72496fa 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -34,6 +34,9 @@
 
 #ifdef _WIN32
 
+#include <minwindef.h>
+#include <winsock2.h>
+
 #include "buffer.h"
 #include "error.h"
 #include "mtu.h"
@@ -47,7 +50,7 @@
 
 #include <versionhelpers.h>
 
-#include "block_dns.h"
+#include "wfp_block.h"
 
 /*
  * WFP handle
@@ -1138,43 +1141,19 @@
 }
 
 static bool
-win_block_dns_service(bool add, int index, const HANDLE pipe)
+win_get_exe_path(PWCHAR path, DWORD size)
 {
-    bool ret = false;
-    ack_message_t ack;
-    struct gc_arena gc = gc_new();
-
-    block_dns_message_t data = {
-        .header = {
-            (add ? msg_add_block_dns : msg_del_block_dns),
-            sizeof(block_dns_message_t),
-            0
-        },
-        .iface = { .index = index, .name = "" }
-    };
-
-    if (!send_msg_iservice(pipe, &data, sizeof(data), &ack, "Block_DNS"))
+    DWORD status = GetModuleFileNameW(NULL, path, size);
+    if (status == 0 || status == size)
     {
-        goto out;
+        msg(M_WARN|M_ERRNO, "cannot get executable path");
+        return false;
     }
-
-    if (ack.error_number != NO_ERROR)
-    {
-        msg(M_WARN, "Block_DNS: %s block dns filters using service failed: %s [status=0x%x if_index=%d]",
-            (add ? "adding" : "deleting"), strerror_win32(ack.error_number, &gc),
-            ack.error_number, data.iface.index);
-        goto out;
-    }
-
-    ret = true;
-    msg(M_INFO, "%s outside dns using service succeeded.", (add ? "Blocking" : "Unblocking"));
-out:
-    gc_free(&gc);
-    return ret;
+    return true;
 }
 
 static void
-block_dns_msg_handler(DWORD err, const char *msg)
+win_wfp_msg_handler(DWORD err, const char *msg)
 {
     struct gc_arena gc = gc_new();
 
@@ -1184,15 +1163,52 @@
     }
     else
     {
-        msg(M_WARN, "Error in add_block_dns_filters(): %s : %s [status=0x%lx]",
+        msg(M_WARN, "Error in WFP: %s : %s [status=0x%lx]",
             msg, strerror_win32(err, &gc), err);
     }
 
     gc_free(&gc);
 }
 
+static bool
+win_wfp_block_service(bool add, bool dns_only, int index, const HANDLE pipe)
+{
+    bool ret = false;
+    ack_message_t ack;
+    struct gc_arena gc = gc_new();
+
+    wfp_block_message_t data = {
+        .header = {
+            (add ? msg_add_wfp_block : msg_del_wfp_block),
+            sizeof(wfp_block_message_t),
+            0
+        },
+        .flags = dns_only ? wfp_block_dns : wfp_block_local,
+        .iface = { .index = index, .name = "" }
+    };
+
+    if (!send_msg_iservice(pipe, &data, sizeof(data), &ack, "WFP block"))
+    {
+        goto out;
+    }
+
+    if (ack.error_number != NO_ERROR)
+    {
+        msg(M_WARN, "WFP block: %s block filters using service failed: %s [status=0x%x if_index=%d]",
+            (add ? "adding" : "deleting"), strerror_win32(ack.error_number, &gc),
+            ack.error_number, data.iface.index);
+        goto out;
+    }
+
+    ret = true;
+    msg(M_INFO, "%s WFP block filters using service succeeded.", (add ? "Adding" : "Deleting"));
+out:
+    gc_free(&gc);
+    return ret;
+}
+
 bool
-win_wfp_block_dns(const NET_IFINDEX index, const HANDLE msg_channel)
+win_wfp_block(const NET_IFINDEX index, const HANDLE msg_channel, BOOL dns_only)
 {
     WCHAR openvpnpath[MAX_PATH];
     bool ret = false;
@@ -1200,20 +1216,19 @@
 
     if (msg_channel)
     {
-        dmsg(D_LOW, "Using service to add block dns filters");
-        ret = win_block_dns_service(true, index, msg_channel);
+        dmsg(D_LOW, "Using service to add WFP block filters");
+        ret = win_wfp_block_service(true, dns_only, index, msg_channel);
         goto out;
     }
 
-    status = GetModuleFileNameW(NULL, openvpnpath, _countof(openvpnpath));
-    if (status == 0 || status == _countof(openvpnpath))
+    ret = win_get_exe_path(openvpnpath, _countof(openvpnpath));
+    if (ret == false)
     {
-        msg(M_WARN|M_ERRNO, "block_dns: cannot get executable path");
         goto out;
     }
 
-    status = add_block_dns_filters(&m_hEngineHandle, index, openvpnpath,
-                                   block_dns_msg_handler);
+    status = add_wfp_block_filters(&m_hEngineHandle, index, openvpnpath,
+                                   win_wfp_msg_handler, dns_only);
     if (status == 0)
     {
         int is_auto = 0;
@@ -1227,10 +1242,10 @@
         {
             tap_metric_v6 = 0;
         }
-        status = set_interface_metric(index, AF_INET, BLOCK_DNS_IFACE_METRIC);
+        status = set_interface_metric(index, AF_INET, WFP_BLOCK_IFACE_METRIC);
         if (!status)
         {
-            set_interface_metric(index, AF_INET6, BLOCK_DNS_IFACE_METRIC);
+            set_interface_metric(index, AF_INET6, WFP_BLOCK_IFACE_METRIC);
         }
     }
 
@@ -1248,12 +1263,12 @@
 
     if (msg_channel)
     {
-        msg(D_LOW, "Using service to delete block dns filters");
-        win_block_dns_service(false, index, msg_channel);
+        msg(D_LOW, "Using service to delete WFP block filters");
+        win_wfp_block_service(false, false, index, msg_channel);
     }
     else
     {
-        delete_block_dns_filters(m_hEngineHandle);
+        delete_wfp_block_filters(m_hEngineHandle);
         m_hEngineHandle = NULL;
         if (tap_metric_v4 >= 0)
         {
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index fd75992..ffad6d9 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -25,8 +25,10 @@
 #ifndef OPENVPN_WIN32_H
 #define OPENVPN_WIN32_H
 
-#include <winioctl.h>
+#include <iphlpapi.h>
+#include <ws2tcpip.h>
 
+#include "syshead.h"
 #include "mtu.h"
 #include "openvpn-msg.h"
 #include "argv.h"
@@ -286,7 +288,7 @@
 /* call self in a subprocess */
 void fork_to_self(const char *cmdline);
 
-bool win_wfp_block_dns(const NET_IFINDEX index, const HANDLE msg_channel);
+bool win_wfp_block(const NET_IFINDEX index, const HANDLE msg_channel, BOOL dns_only);
 
 bool win_wfp_uninit(const NET_IFINDEX index, const HANDLE msg_channel);
 
diff --git a/src/openvpnserv/CMakeLists.txt b/src/openvpnserv/CMakeLists.txt
index 17cd90c..154e17c 100644
--- a/src/openvpnserv/CMakeLists.txt
+++ b/src/openvpnserv/CMakeLists.txt
@@ -17,7 +17,7 @@
     interactive.c
     service.c service.h
     validate.c validate.h
-    ../openvpn/block_dns.c ../openvpn/block_dns.h
+    ../openvpn/wfp_block.c ../openvpn/wfp_block.h
     openvpnserv_resources.rc
     ../openvpn/ring_buffer.h
     )
diff --git a/src/openvpnserv/Makefile.am b/src/openvpnserv/Makefile.am
index 33d2d01..621ce73 100644
--- a/src/openvpnserv/Makefile.am
+++ b/src/openvpnserv/Makefile.am
@@ -33,6 +33,6 @@
 	interactive.c \
 	service.c service.h \
 	validate.c validate.h \
-	$(top_srcdir)/src/openvpn/block_dns.c $(top_srcdir)/src/openvpn/block_dns.h \
+	$(top_srcdir)/src/openvpn/wfp_block.c $(top_srcdir)/src/openvpn/wfp_block.h \
 	openvpnserv_resources.rc \
 	$(top_srcdir)/src/openvpn/ring_buffer.h
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 294db00..b3c0015 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -39,7 +39,7 @@
 
 #include "openvpn-msg.h"
 #include "validate.h"
-#include "block_dns.h"
+#include "wfp_block.h"
 #include "ring_buffer.h"
 
 #define IO_TIMEOUT  2000 /*ms*/
@@ -85,7 +85,7 @@
 typedef enum {
     address,
     route,
-    block_dns,
+    wfp_block,
     undo_dns4,
     undo_dns6,
     undo_domain,
@@ -100,7 +100,7 @@
     int index;
     int metric_v4;
     int metric_v6;
-} block_dns_data_t;
+} wfp_block_data_t;
 
 typedef struct {
     struct tun_ring *send_ring;
@@ -112,7 +112,7 @@
     address_message_t address;
     route_message_t route;
     flush_neighbors_message_t flush_neighbors;
-    block_dns_message_t block_dns;
+    wfp_block_message_t wfp_block;
     dns_cfg_message_t dns;
     enable_dhcp_message_t dhcp;
     register_ring_buffers_message_t rrb;
@@ -787,74 +787,76 @@
 }
 
 static DWORD
-DeleteBlockDNS(const block_dns_message_t *msg, undo_lists_t *lists)
+DeleteWfpBlock(const wfp_block_message_t *msg, undo_lists_t *lists)
 {
     DWORD err = 0;
-    block_dns_data_t *interface_data = RemoveListItem(&(*lists)[block_dns], CmpAny, NULL);
+    wfp_block_data_t *block_data = RemoveListItem(&(*lists)[wfp_block], CmpAny, NULL);
 
-    if (interface_data)
+    if (block_data)
     {
-        err = delete_block_dns_filters(interface_data->engine);
-        if (interface_data->metric_v4 >= 0)
+        err = delete_wfp_block_filters(block_data->engine);
+        if (block_data->metric_v4 >= 0)
         {
             set_interface_metric(msg->iface.index, AF_INET,
-                                 interface_data->metric_v4);
+                                 block_data->metric_v4);
         }
-        if (interface_data->metric_v6 >= 0)
+        if (block_data->metric_v6 >= 0)
         {
             set_interface_metric(msg->iface.index, AF_INET6,
-                                 interface_data->metric_v6);
+                                 block_data->metric_v6);
         }
-        free(interface_data);
+        free(block_data);
     }
     else
     {
-        MsgToEventLog(M_ERR, TEXT("No previous block DNS filters to delete"));
+        MsgToEventLog(M_ERR, TEXT("No previous block filters to delete"));
     }
 
     return err;
 }
 
 static DWORD
-AddBlockDNS(const block_dns_message_t *msg, undo_lists_t *lists)
+AddWfpBlock(const wfp_block_message_t *msg, undo_lists_t *lists)
 {
     DWORD err = 0;
-    block_dns_data_t *interface_data = NULL;
+    wfp_block_data_t *block_data = NULL;
     HANDLE engine = NULL;
     LPCWSTR exe_path;
+    BOOL dns_only;
 
     exe_path = settings.exe_path;
+    dns_only = (msg->flags == wfp_block_dns);
 
-    err = add_block_dns_filters(&engine, msg->iface.index, exe_path, BlockDNSErrHandler);
+    err = add_wfp_block_filters(&engine, msg->iface.index, exe_path, BlockDNSErrHandler, dns_only);
     if (!err)
     {
-        interface_data = malloc(sizeof(block_dns_data_t));
-        if (!interface_data)
+        block_data = malloc(sizeof(wfp_block_data_t));
+        if (!block_data)
         {
             err = ERROR_OUTOFMEMORY;
             goto out;
         }
-        interface_data->engine = engine;
-        interface_data->index = msg->iface.index;
+        block_data->engine = engine;
+        block_data->index = msg->iface.index;
         int is_auto = 0;
-        interface_data->metric_v4 = get_interface_metric(msg->iface.index,
-                                                         AF_INET, &is_auto);
+        block_data->metric_v4 = get_interface_metric(msg->iface.index,
+                                                     AF_INET, &is_auto);
         if (is_auto)
         {
-            interface_data->metric_v4 = 0;
+            block_data->metric_v4 = 0;
         }
-        interface_data->metric_v6 = get_interface_metric(msg->iface.index,
-                                                         AF_INET6, &is_auto);
+        block_data->metric_v6 = get_interface_metric(msg->iface.index,
+                                                     AF_INET6, &is_auto);
         if (is_auto)
         {
-            interface_data->metric_v6 = 0;
+            block_data->metric_v6 = 0;
         }
 
-        err = AddListItem(&(*lists)[block_dns], interface_data);
+        err = AddListItem(&(*lists)[wfp_block], block_data);
         if (!err)
         {
             err = set_interface_metric(msg->iface.index, AF_INET,
-                                       BLOCK_DNS_IFACE_METRIC);
+                                       WFP_BLOCK_IFACE_METRIC);
             if (!err)
             {
                 /* for IPv6, we intentionally ignore errors, because
@@ -863,12 +865,12 @@
                  * (if OpenVPN wants IPv6 ifconfig, we'll fail there)
                  */
                 set_interface_metric(msg->iface.index, AF_INET6,
-                                     BLOCK_DNS_IFACE_METRIC);
+                                     WFP_BLOCK_IFACE_METRIC);
             }
             if (err)
             {
                 /* delete the filters, remove undo item and free interface data */
-                DeleteBlockDNS(msg, lists);
+                DeleteWfpBlock(msg, lists);
                 engine = NULL;
             }
         }
@@ -877,23 +879,23 @@
 out:
     if (err && engine)
     {
-        delete_block_dns_filters(engine);
-        free(interface_data);
+        delete_wfp_block_filters(engine);
+        free(block_data);
     }
 
     return err;
 }
 
 static DWORD
-HandleBlockDNSMessage(const block_dns_message_t *msg, undo_lists_t *lists)
+HandleWfpBlockMessage(const wfp_block_message_t *msg, undo_lists_t *lists)
 {
-    if (msg->header.type == msg_add_block_dns)
+    if (msg->header.type == msg_add_wfp_block)
     {
-        return AddBlockDNS(msg, lists);
+        return AddWfpBlock(msg, lists);
     }
     else
     {
-        return DeleteBlockDNS(msg, lists);
+        return DeleteWfpBlock(msg, lists);
     }
 }
 
@@ -1666,11 +1668,11 @@
             }
             break;
 
-        case msg_add_block_dns:
-        case msg_del_block_dns:
-            if (msg.header.size == sizeof(msg.block_dns))
+        case msg_add_wfp_block:
+        case msg_del_wfp_block:
+            if (msg.header.size == sizeof(msg.wfp_block))
             {
-                ack.error_number = HandleBlockDNSMessage(&msg.block_dns, lists);
+                ack.error_number = HandleWfpBlockMessage(&msg.wfp_block, lists);
             }
             break;
 
@@ -1724,7 +1726,7 @@
 Undo(undo_lists_t *lists)
 {
     undo_type_t type;
-    block_dns_data_t *interface_data;
+    wfp_block_data_t *interface_data;
     for (type = 0; type < _undo_type_max; type++)
     {
         list_item_t **pnext = &(*lists)[type];
@@ -1757,9 +1759,9 @@
                     SetDNSDomain(item->data, "", NULL);
                     break;
 
-                case block_dns:
-                    interface_data = (block_dns_data_t *)(item->data);
-                    delete_block_dns_filters(interface_data->engine);
+                case wfp_block:
+                    interface_data = (wfp_block_data_t *)(item->data);
+                    delete_wfp_block_filters(interface_data->engine);
                     if (interface_data->metric_v4 >= 0)
                     {
                         set_interface_metric(interface_data->index, AF_INET,

