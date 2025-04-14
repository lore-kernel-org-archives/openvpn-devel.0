From: Gert Doering <gert@...1296...>
Date: Mon, 14 Apr 2025 20:06:26 +0200
Message-ID: <20250414180636.31936-1-gert@...1296...>
In-Reply-To: <gerrit.1733989644000.I576e74f3276362606e9cbd50bb5adbebaaf209cc@...2715...>
References: <gerrit.1733989644000.I576e74f3276362606e9cbd50bb5adbebaaf209cc@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v18] win: implement --dns option support
 with NRPT
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

Implement support for setting options from --dns. This is hugely
different than what we had so far with DNS related --dhcp-option.

The main difference it that we support split DNS and DNSSEC by making
use of NRPT (Name Resolution Policy Table). Also OpenVPN tries to keep
local DNS resolution working when DNS is redirected into the tunnel. To
prevent this from happening we have --block-outside-dns, in case you
wonder. Basically we collect domains and name server addresses from
network adapters and add so called exclude NRPT rules in addition to the
catch all rule that is pushed by the server.

All is done via the interactive service, since modifying all this
requires the elevated privileges that the openvpn process hopefully
doesn't have.

Change-Id: I576e74f3276362606e9cbd50bb5adbebaaf209cc
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Lev Stipakov <lstipakov@...277...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/837
This mail reflects revision 18 of this Change.

Acked-by according to Gerrit (reflected above):
Lev Stipakov <lstipakov@...277...>

        
diff --git a/include/openvpn-msg.h b/include/openvpn-msg.h
index 7a99335..8b48053 100644
--- a/include/openvpn-msg.h
+++ b/include/openvpn-msg.h
@@ -35,6 +35,8 @@
     msg_del_route,
     msg_add_dns_cfg,
     msg_del_dns_cfg,
+    msg_add_nrpt_cfg,
+    msg_del_nrpt_cfg,
     msg_add_nbt_cfg,
     msg_del_nbt_cfg,
     msg_flush_neighbors,
@@ -96,6 +98,23 @@
     inet_address_t addr[4]; /* support up to 4 dns addresses */
 } dns_cfg_message_t;
 
+
+typedef enum {
+    nrpt_dnssec
+} nrpt_flags_t;
+
+#define NRPT_ADDR_NUM 8   /* Max. number of addresses */
+#define NRPT_ADDR_SIZE 48 /* Max. address strlen + some */
+typedef char nrpt_address_t[NRPT_ADDR_SIZE];
+typedef struct {
+    message_header_t header;
+    interface_t iface;
+    nrpt_address_t addresses[NRPT_ADDR_NUM];
+    char resolve_domains[512]; /* double \0 terminated */
+    char search_domains[512];
+    nrpt_flags_t flags;
+} nrpt_dns_cfg_message_t;
+
 typedef struct {
     message_header_t header;
     interface_t iface;
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index cf48c22..b6e524f 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -29,6 +29,12 @@
 
 #include "dns.h"
 #include "socket.h"
+#include "options.h"
+
+#ifdef _WIN32
+#include "win32.h"
+#include "openvpn-msg.h"
+#endif
 
 /**
  * Parses a string as port and stores it
@@ -428,6 +434,122 @@
     gc_free(&gc);
 }
 
+#ifdef _WIN32
+
+static void
+make_domain_list(const char *what, const struct dns_domain *src,
+                 bool nrpt_domains, char *dst, size_t dst_size)
+{
+    /* NRPT domains need two \0 at the end for REG_MULTI_SZ
+     * and a leading '.' added in front of the domain name */
+    size_t term_size = nrpt_domains ? 2 : 1;
+    size_t leading_dot = nrpt_domains ? 1 : 0;
+    size_t offset = 0;
+
+    memset(dst, 0, dst_size);
+
+    while (src)
+    {
+        size_t len = strlen(src->name);
+        if (offset + leading_dot + len + term_size > dst_size)
+        {
+            msg(M_WARN, "WARNING: %s truncated", what);
+            if (offset)
+            {
+                /* Remove trailing comma */
+                *(dst + offset - 1) = '\0';
+            }
+            break;
+        }
+
+        if (leading_dot)
+        {
+            *(dst + offset++) = '.';
+        }
+        strncpy(dst + offset, src->name, len);
+        offset += len;
+
+        src = src->next;
+        if (src)
+        {
+            *(dst + offset++) = ',';
+        }
+    }
+}
+
+static void
+run_up_down_service(bool add, const struct options *o, const struct tuntap *tt)
+{
+    const struct dns_server *server = o->dns_options.servers;
+    const struct dns_domain *search_domains = o->dns_options.search_domains;
+
+    while (true)
+    {
+        if (!server)
+        {
+            if (add)
+            {
+                msg(M_WARN, "WARNING: setting DNS failed, no compatible server profile");
+            }
+            return;
+        }
+
+        bool only_standard_server_ports = true;
+        for (size_t i = 0; i < NRPT_ADDR_NUM; ++i)
+        {
+            if (server->addr[i].port && server->addr[i].port != 53)
+            {
+                only_standard_server_ports = false;
+                break;
+            }
+        }
+        if ((server->transport == DNS_TRANSPORT_UNSET || server->transport == DNS_TRANSPORT_PLAIN)
+            && only_standard_server_ports)
+        {
+            break; /* found compatible server */
+        }
+
+        server = server->next;
+    }
+
+    ack_message_t ack;
+    nrpt_dns_cfg_message_t nrpt = {
+        .header = {
+            (add ? msg_add_nrpt_cfg : msg_del_nrpt_cfg),
+            sizeof(nrpt_dns_cfg_message_t),
+            0
+        },
+        .iface = { .index = tt->adapter_index, .name = "" },
+        .flags = server->dnssec == DNS_SECURITY_NO ? 0 : nrpt_dnssec,
+    };
+    strncpynt(nrpt.iface.name, tt->actual_name, sizeof(nrpt.iface.name));
+
+    for (size_t i = 0; i < NRPT_ADDR_NUM; ++i)
+    {
+        if (server->addr[i].family == AF_UNSPEC)
+        {
+            /* No more addresses */
+            break;
+        }
+
+        if (inet_ntop(server->addr[i].family, &server->addr[i].in,
+                      nrpt.addresses[i], NRPT_ADDR_SIZE) == NULL)
+        {
+            msg(M_WARN, "WARNING: could not convert dns server address");
+        }
+    }
+
+    make_domain_list("dns server resolve domains", server->domains, true,
+                     nrpt.resolve_domains, sizeof(nrpt.resolve_domains));
+
+    make_domain_list("dns search domains", search_domains, false,
+                     nrpt.search_domains, sizeof(nrpt.search_domains));
+
+    send_msg_iservice(o->msg_channel, &nrpt, sizeof(nrpt), &ack, "DNS");
+}
+
+#endif /* _WIN32 */
+
 void
 show_dns_options(const struct dns_options *o)
 {
@@ -506,3 +628,43 @@
 
     gc_free(&gc);
 }
+
+void
+run_dns_up_down(bool up, struct options *o, const struct tuntap *tt)
+{
+    if (!o->dns_options.servers)
+    {
+        return;
+    }
+
+    /* Warn about adding servers of unsupported AF */
+    const struct dns_server *s = o->dns_options.servers;
+    while (up && s)
+    {
+        size_t bad_count = 0;
+        for (size_t i = 0; i < s->addr_count; ++i)
+        {
+            if ((s->addr[i].family == AF_INET6 && !tt->did_ifconfig_ipv6_setup)
+                || (s->addr[i].family == AF_INET && !tt->did_ifconfig_setup))
+            {
+                ++bad_count;
+            }
+        }
+        if (bad_count == s->addr_count)
+        {
+            msg(M_WARN, "DNS server %ld only has address(es) from a family "
+                "the tunnel is not configured for - it will not be reachable",
+                s->priority);
+        }
+        else if (bad_count)
+        {
+            msg(M_WARN, "DNS server %ld has address(es) from a family "
+                "the tunnel is not configured for", s->priority);
+        }
+        s = s->next;
+    }
+
+#ifdef _WIN32
+    run_up_down_service(up, o, tt);
+#endif /* ifdef _WIN32 */
+}
diff --git a/src/openvpn/dns.h b/src/openvpn/dns.h
index 838ebe1..f24e30b 100644
--- a/src/openvpn/dns.h
+++ b/src/openvpn/dns.h
@@ -26,6 +26,7 @@
 
 #include "buffer.h"
 #include "env_set.h"
+#include "tun.h"
 
 enum dns_security {
     DNS_SECURITY_UNSET,
@@ -147,6 +148,14 @@
 void dns_options_postprocess_pull(struct dns_options *o);
 
 /**
+ * Invokes the action associated with bringing DNS up or down
+ * @param   up          Boolean to set this call to "up" when true
+ * @param   o           Pointer to the program options
+ * @param   tt          Pointer to the connection's tuntap struct
+ */
+void run_dns_up_down(bool up, struct options *o, const struct tuntap *tt);
+
+/**
  * Puts the DNS options into an environment set.
  *
  * @param   o           Pointer to the DNS options to set
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 1be205b..9eb8290 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2026,6 +2026,8 @@
                         c->c2.frame.tun_mtu, c->c2.es, &c->net_ctx);
         }
 
+        run_dns_up_down(true, &c->options, c->c1.tuntap);
+
         /* run the up script */
         run_up_down(c->options.up_script,
                     c->plugins,
@@ -2064,6 +2066,8 @@
         /* explicitly set the ifconfig_* env vars */
         do_ifconfig_setenv(c->c1.tuntap, c->c2.es);
 
+        run_dns_up_down(true, &c->options, c->c1.tuntap);
+
         /* run the up script if user specified --up-restart */
         if (c->options.up_restart)
         {
@@ -2152,6 +2156,8 @@
     adapter_index = c->c1.tuntap->adapter_index;
 #endif
 
+    run_dns_up_down(false, &c->options, c->c1.tuntap);
+
     if (force || !(c->sig->signal_received == SIGUSR1 && c->options.persist_tun))
     {
         static_context = NULL;
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index c6963b3..3cefcc7 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -88,6 +88,7 @@
     wfp_block,
     undo_dns4,
     undo_dns6,
+    undo_nrpt,
     undo_domains,
     undo_ring_buffer,
     undo_wins,
@@ -119,12 +120,20 @@
     flush_neighbors_message_t flush_neighbors;
     wfp_block_message_t wfp_block;
     dns_cfg_message_t dns;
+    nrpt_dns_cfg_message_t nrpt_dns;
     enable_dhcp_message_t dhcp;
     register_ring_buffers_message_t rrb;
     set_mtu_message_t mtu;
     wins_cfg_message_t wins;
 } pipe_message_t;
 
+typedef struct {
+    CHAR addresses[NRPT_ADDR_NUM * NRPT_ADDR_SIZE];
+    WCHAR domains[512]; /* MULTI_SZ string */
+    DWORD domains_size; /* bytes in domains */
+} nrpt_exclude_data_t;
+
+
 static DWORD
 AddListItem(list_item_t **pfirst, LPVOID data)
 {
@@ -1194,13 +1203,13 @@
 
     if (apply_gpol && ApplyGpolSettings() == FALSE)
     {
-        MsgToEventLog(M_ERR, L"%s: sending GPOL notification failed", __func__);
+        MsgToEventLog(M_ERR, L"%S: sending GPOL notification failed", __func__);
     }
 
     scm = OpenSCManager(NULL, NULL, SC_MANAGER_ALL_ACCESS);
     if (scm == NULL)
     {
-        MsgToEventLog(M_ERR, L"%s: OpenSCManager call failed (%lu)",
+        MsgToEventLog(M_ERR, L"%S: OpenSCManager call failed (%lu)",
                       __func__, GetLastError());
         goto out;
     }
@@ -1208,7 +1217,7 @@
     dnssvc = OpenServiceA(scm, "Dnscache", SERVICE_PAUSE_CONTINUE);
     if (dnssvc == NULL)
     {
-        MsgToEventLog(M_ERR, L"%s: OpenService call failed (%lu)",
+        MsgToEventLog(M_ERR, L"%S: OpenService call failed (%lu)",
                       __func__, GetLastError());
         goto out;
     }
@@ -1216,7 +1225,7 @@
     SERVICE_STATUS status;
     if (ControlService(dnssvc, SERVICE_CONTROL_PARAMCHANGE, &status) == 0)
     {
-        MsgToEventLog(M_ERR, L"%s: ControlService call failed (%lu)",
+        MsgToEventLog(M_ERR, L"%S: ControlService call failed (%lu)",
                       __func__, GetLastError());
         goto out;
     }
@@ -1255,19 +1264,19 @@
     err = InterfaceLuid(itf_name, &luid);
     if (err)
     {
-        MsgToEventLog(M_ERR, L"%s: failed to convert itf alias '%s'", __func__, itf_name);
+        MsgToEventLog(M_ERR, L"%S: failed to convert itf alias '%s'", __func__, itf_name);
         goto out;
     }
     err = ConvertInterfaceLuidToGuid(&luid, &guid);
     if (err)
     {
-        MsgToEventLog(M_ERR, L"%s: Failed to convert itf '%s' LUID", __func__, itf_name);
+        MsgToEventLog(M_ERR, L"%S: Failed to convert itf '%s' LUID", __func__, itf_name);
         goto out;
     }
 
     if (StringFromIID(&guid, &iid_str) != S_OK)
     {
-        MsgToEventLog(M_ERR, L"%s: Failed to convert itf '%s' IID", __func__, itf_name);
+        MsgToEventLog(M_ERR, L"%S: Failed to convert itf '%s' IID", __func__, itf_name);
         err = ERROR_OUTOFMEMORY;
         goto out;
     }
@@ -1417,7 +1426,7 @@
         {
             return FALSE;
         }
-        MsgToEventLog(M_ERR, L"%s: failed to get InitialSearchList (%lu)",
+        MsgToEventLog(M_ERR, L"%S: failed to get InitialSearchList (%lu)",
                       __func__, err);
     }
 
@@ -1439,7 +1448,7 @@
 {
     if (!list || wcslen(list) == 0)
     {
-        MsgToEventLog(M_ERR, L"StoreInitialDnsSearchList: empty search list");
+        MsgToEventLog(M_ERR, L"%S: empty search list", __func__);
         return FALSE;
     }
 
@@ -1453,7 +1462,7 @@
     LSTATUS err = RegSetValueExW(key, L"InitialSearchList", 0, REG_SZ, (PBYTE)list, size);
     if (err)
     {
-        MsgToEventLog(M_ERR, L"%s: failed to set InitialSearchList value (%lu)",
+        MsgToEventLog(M_ERR, L"%S: failed to set InitialSearchList value (%lu)",
                       __func__, err);
         return FALSE;
     }
@@ -1482,7 +1491,7 @@
         err = RegGetValueW(key, NULL, L"SearchList", RRF_RT_REG_SZ, NULL, list, &size);
         if (err)
         {
-            MsgToEventLog(M_SYSERR, L"%s: could not get SearchList from registry (%lu)",
+            MsgToEventLog(M_SYSERR, L"%S: could not get SearchList from registry (%lu)",
                           __func__, err);
             return FALSE;
         }
@@ -1496,7 +1505,7 @@
         size_t domlen = wcslen(domains);
         if (listlen + domlen + 2 > _countof(list))
         {
-            MsgToEventLog(M_SYSERR, L"%s: not enough space in list for search domains (len=%lu)",
+            MsgToEventLog(M_SYSERR, L"%S: not enough space in list for search domains (len=%lu)",
                           __func__, domlen);
             return FALSE;
         }
@@ -1515,7 +1524,7 @@
     err = RegSetValueExW(key, L"SearchList", 0, REG_SZ, (PBYTE)list, size);
     if (err)
     {
-        MsgToEventLog(M_SYSERR, L"%s: could not set SearchList to registry (%lu)",
+        MsgToEventLog(M_SYSERR, L"%S: could not set SearchList to registry (%lu)",
                       __func__, err);
         return FALSE;
     }
@@ -1547,7 +1556,7 @@
     {
         if (err != ERROR_FILE_NOT_FOUND)
         {
-            MsgToEventLog(M_SYSERR, L"%s: could not get InitialSearchList from registry (%lu)",
+            MsgToEventLog(M_SYSERR, L"%S: could not get InitialSearchList from registry (%lu)",
                           __func__, err);
         }
         goto out;
@@ -1557,7 +1566,7 @@
     err = RegSetValueExW(key, L"SearchList", 0, REG_SZ, (PBYTE)list, size);
     if (err)
     {
-        MsgToEventLog(M_SYSERR, L"%s: could not set SearchList in registry (%lu)",
+        MsgToEventLog(M_SYSERR, L"%S: could not set SearchList in registry (%lu)",
                       __func__, err);
         goto out;
     }
@@ -1585,7 +1594,7 @@
     err = RegGetValueW(key, NULL, L"SearchList", RRF_RT_REG_SZ, NULL, list, &size);
     if (err)
     {
-        MsgToEventLog(M_SYSERR, L"%s: could not get SearchList from registry (%lu)",
+        MsgToEventLog(M_SYSERR, L"%S: could not get SearchList from registry (%lu)",
                       __func__, err);
         return;
     }
@@ -1593,7 +1602,7 @@
     PWSTR dst = wcsstr(list, domains);
     if (!dst)
     {
-        MsgToEventLog(M_ERR, L"%s: could not find domains in search list", __func__);
+        MsgToEventLog(M_ERR, L"%S: could not find domains in search list", __func__);
         return;
     }
 
@@ -1613,7 +1622,7 @@
         err = RegGetValueW(key, NULL, L"InitialSearchList", RRF_RT_REG_SZ, NULL, initial, &size);
         if (err)
         {
-            MsgToEventLog(M_SYSERR, L"%s: could not get InitialSearchList from registry (%lu)",
+            MsgToEventLog(M_SYSERR, L"%S: could not get InitialSearchList from registry (%lu)",
                           __func__, err);
             return;
         }
@@ -1630,7 +1639,7 @@
     err = RegSetValueExW(key, L"SearchList", 0, REG_SZ, (PBYTE)list, size);
     if (err)
     {
-        MsgToEventLog(M_SYSERR, L"%s: could not set SearchList in registry (%lu)",
+        MsgToEventLog(M_SYSERR, L"%S: could not set SearchList in registry (%lu)",
                       __func__, err);
     }
 }
@@ -1687,7 +1696,7 @@
     BOOL have_list = GetDnsSearchListKey(itf_name, gpol, &list_key);
     if (list_key == INVALID_HANDLE_VALUE)
     {
-        MsgToEventLog(M_SYSERR, L"%s: could not get search list registry key", __func__);
+        MsgToEventLog(M_SYSERR, L"%S: could not get search list registry key", __func__);
         return ERROR_FILE_NOT_FOUND;
     }
 
@@ -1756,7 +1765,7 @@
     if (err)
     {
         *key = INVALID_HANDLE_VALUE;
-        MsgToEventLog(M_SYSERR, L"%s: could not open interfaces registry key for family %d (%lu)",
+        MsgToEventLog(M_SYSERR, L"%S: could not open interfaces registry key for family %d (%lu)",
                       __func__, family, err);
     }
 
@@ -1787,7 +1796,7 @@
     err = RegOpenKeyExW(itfs, itf_id, 0, KEY_ALL_ACCESS, &itf);
     if (err)
     {
-        MsgToEventLog(M_SYSERR, L"%s: could not open interface key for %s family %d (%lu)",
+        MsgToEventLog(M_SYSERR, L"%S: could not open interface key for %s family %d (%lu)",
                       __func__, itf_id, family, err);
         goto out;
     }
@@ -1795,7 +1804,7 @@
     err = RegSetValueExA(itf, "NameServer", 0, REG_SZ, (PBYTE)value, strlen(value) + 1);
     if (err)
     {
-        MsgToEventLog(M_SYSERR, L"%s: could not set name servers '%S' for %s family %d (%lu)",
+        MsgToEventLog(M_SYSERR, L"%S: could not set name servers '%S' for %s family %d (%lu)",
                       __func__, value, itf_id, family, err);
     }
 
@@ -1947,6 +1956,903 @@
     return err;
 }
 
+/**
+ * Checks if DHCP is enabled for an interface
+ *
+ * @param  key        HKEY of the interface to check for
+ *
+ * @return BOOL set to TRUE if DHCP is enabled, or FALSE if
+ *         disabled or an error occurred
+ */
+static BOOL
+IsDhcpEnabled(HKEY key)
+{
+    DWORD dhcp;
+    DWORD size = sizeof(dhcp);
+    LSTATUS err;
+
+    err = RegGetValueA(key, NULL, "EnableDHCP", RRF_RT_REG_DWORD, NULL, (PBYTE)&dhcp, &size);
+    if (err != NO_ERROR)
+    {
+        MsgToEventLog(M_SYSERR, L"%S: Could not read DHCP status (%lu)", __func__, err);
+        return FALSE;
+    }
+
+    return dhcp ? TRUE : FALSE;
+}
+
+/**
+ * Set name servers from a NRPT address list
+ *
+ * @param itf_id        the VPN interface ID to set the name servers for
+ * @param addresses     the list of NRPT addresses
+ *
+ * @return LSTATUS NO_ERROR in case of success, a Windows error code otherwise
+ */
+static LSTATUS
+SetNameServerAddresses(PWSTR itf_id, const nrpt_address_t *addresses)
+{
+    const short families[] = { AF_INET, AF_INET6 };
+    for (int i = 0; i < _countof(families); i++)
+    {
+        short family = families[i];
+
+        /* Create a comma sparated list of addresses of this family */
+        int offset = 0;
+        char addr_list[NRPT_ADDR_SIZE * NRPT_ADDR_NUM];
+        for (int j = 0; j < NRPT_ADDR_NUM && addresses[j][0]; j++)
+        {
+            if ((family == AF_INET6 && strchr(addresses[j], ':') == NULL)
+                || (family == AF_INET && strchr(addresses[j], ':') != NULL))
+            {
+                /* Address family doesn't match, skip this one */
+                continue;
+            }
+            if (offset)
+            {
+                addr_list[offset++] = ',';
+            }
+            strcpy(addr_list + offset, addresses[j]);
+            offset += strlen(addresses[j]);
+        }
+
+        if (offset == 0)
+        {
+            /* No address for this family to set */
+            continue;
+        }
+
+        /* Set name server addresses */
+        LSTATUS err = SetNameServers(itf_id, family, addr_list);
+        if (err)
+        {
+            return err;
+        }
+    }
+    return NO_ERROR;
+}
+
+/**
+ * Get DNS server IPv4 addresses of an interface
+ *
+ * @param  itf_key    registry key of the IPv4 interface data
+ * @param  addrs      pointer to the buffer addresses are returned in
+ * @param  size       pointer to the size of the buffer, contains the
+ *                    size of the addresses on return
+ *
+ * @return LSTATUS NO_ERROR on success, a Windows error code otherwise
+ */
+static LSTATUS
+GetItfDnsServersV4(HKEY itf_key, PSTR addrs, PDWORD size)
+{
+    addrs[*size - 1] = '\0';
+
+    LSTATUS err;
+    DWORD s = *size;
+    err = RegGetValueA(itf_key, NULL, "NameServer", RRF_RT_REG_SZ, NULL, (PBYTE)addrs, &s);
+    if (err && err != ERROR_FILE_NOT_FOUND)
+    {
+        *size = 0;
+        return err;
+    }
+
+    /* Try DHCP addresses if we don't have some already */
+    if (!strchr(addrs, '.') && IsDhcpEnabled(itf_key))
+    {
+        s = *size;
+        RegGetValueA(itf_key, NULL, "DhcpNameServer", RRF_RT_REG_SZ, NULL, (PBYTE)addrs, &s);
+        if (err)
+        {
+            *size = 0;
+            return err;
+        }
+    }
+
+    if (strchr(addrs, '.'))
+    {
+        *size = s;
+        return NO_ERROR;
+    }
+
+    *size = 0;
+    return ERROR_FILE_NOT_FOUND;
+}
+
+/**
+ * Get DNS server IPv6 addresses of an interface
+ *
+ * @param  itf_key    registry key of the IPv6 interface data
+ * @param  addrs      pointer to the buffer addresses are returned in
+ * @param  size       pointer to the size of the buffer
+ *
+ * @return LSTATUS NO_ERROR on success, a Windows error code otherwise
+ */
+static LSTATUS
+GetItfDnsServersV6(HKEY itf_key, PSTR addrs, PDWORD size)
+{
+    addrs[*size - 1] = '\0';
+
+    LSTATUS err;
+    DWORD s = *size;
+    err = RegGetValueA(itf_key, NULL, "NameServer", RRF_RT_REG_SZ, NULL, (PBYTE)addrs, &s);
+    if (err && err != ERROR_FILE_NOT_FOUND)
+    {
+        *size = 0;
+        return err;
+    }
+
+    /* Try DHCP addresses if we don't have some already */
+    if (!strchr(addrs, ':') && IsDhcpEnabled(itf_key))
+    {
+        IN6_ADDR in_addrs[8];
+        DWORD in_addrs_size = sizeof(in_addrs);
+        err = RegGetValueA(itf_key, NULL, "Dhcpv6DNSServers", RRF_RT_REG_BINARY, NULL,
+                           (PBYTE)in_addrs, &in_addrs_size);
+        if (err)
+        {
+            *size = 0;
+            return err;
+        }
+
+        s = *size;
+        PSTR pos = addrs;
+        size_t in_addrs_read = in_addrs_size / sizeof(IN6_ADDR);
+        for (size_t i = 0; i < in_addrs_read; ++i)
+        {
+            if (i != 0)
+            {
+                /* Add separator */
+                *pos++ = ',';
+                s--;
+            }
+
+            if (inet_ntop(AF_INET6, &in_addrs[i],
+                          pos, s) != NULL)
+            {
+                *size = 0;
+                return ERROR_MORE_DATA;
+            }
+
+            size_t addr_len = strlen(pos);
+            pos += addr_len;
+            s -= addr_len;
+        }
+        s = strlen(addrs) + 1;
+    }
+
+    if (strchr(addrs, ':'))
+    {
+        *size = s;
+        return NO_ERROR;
+    }
+
+    *size = 0;
+    return ERROR_FILE_NOT_FOUND;
+}
+
+/**
+ * Return interface specific domain suffix(es)
+ *
+ * The \p domains paramter will be set to a MULTI_SZ domains string.
+ * In case of an error or if no domains are found for the interface
+ * \p size is set to 0 and the contents of \p domains are invalid.
+ * Note that the domains could have been set by DHCP or manually.
+ *
+ * @param  itf        HKEY of the interface to read from
+ * @param  domains    PWSTR buffer to return the domain(s) in
+ * @param  size       pointer to size of the domains buffer in bytes. Will be
+ *                    set to the size of the string returned, including
+ *                    the terminating zeros or 0.
+ *
+ * @return LSTATUS NO_ERROR if the domain suffix(es) were read successfully,
+ *         ERROR_FILE_NOT_FOUND if no domain was found for the interface,
+ *         ERROR_MORE_DATA if the list did not fit into the buffer,
+ *         any other error indicates an error while reading from the registry.
+ */
+static LSTATUS
+GetItfDnsDomains(HKEY itf, PWSTR domains, PDWORD size)
+{
+    if (domains == NULL || size == 0)
+    {
+        return ERROR_INVALID_PARAMETER;
+    }
+
+    LSTATUS err = ERROR_FILE_NOT_FOUND;
+    const DWORD buf_size = *size;
+    const size_t one_glyph = sizeof(*domains);
+    PWSTR values[] = { L"SearchList", L"Domain", L"DhcpDomainSearchList", L"DhcpDomain", NULL};
+
+    for (int i = 0; values[i]; i++)
+    {
+        *size = buf_size;
+        err = RegGetValueW(itf, NULL, values[i], RRF_RT_REG_SZ, NULL, (PBYTE)domains, size);
+        if (!err && *size > one_glyph && wcschr(domains, '.'))
+        {
+            /*
+             * Found domain(s), now convert them:
+             *   - prefix each domain with a dot
+             *   - convert comma separated list to MULTI_SZ
+             */
+            PWCHAR pos = domains;
+            const DWORD buf_len = buf_size / one_glyph;
+            while (TRUE)
+            {
+                /* Terminate the domain at the next comma */
+                PWCHAR comma = wcschr(pos, ',');
+                if (comma)
+                {
+                    *comma = '\0';
+                }
+
+                /* Check for enough space to convert this domain */
+                size_t converted_size = pos - domains;
+                size_t domain_len = wcslen(pos) + 1;
+                size_t domain_size = domain_len * one_glyph;
+                size_t extra_size = 2 * one_glyph;
+                if (converted_size + domain_size + extra_size > buf_size)
+                {
+                    /* Domain doesn't fit, bad luck if it's the first one */
+                    *pos = '\0';
+                    *size = converted_size == 0 ? 0 : *size + 1;
+                    return ERROR_MORE_DATA;
+                }
+
+                /* Prefix domain at pos with the dot */
+                memmove(pos + 1, pos, buf_size - converted_size - one_glyph);
+                domains[buf_len - 1] = '\0';
+                *pos = '.';
+                *size += 1;
+
+                if (!comma)
+                {
+                    /* Conversion is done */
+                    *(pos + domain_len) = '\0';
+                    *size += 1;
+                    return NO_ERROR;
+                }
+
+                pos = comma + 1;
+            }
+        }
+    }
+
+    *size = 0;
+    return err;
+}
+
+/**
+ * Check if an interface is connected and up
+ *
+ * @param  iid_str    the interface GUID as string
+ *
+ * @return TRUE if the interface is connected and up, FALSE otherwise or in
+ *         case an error happened
+ */
+static BOOL
+IsInterfaceConnected(PWSTR iid_str)
+{
+    GUID iid;
+    BOOL res = FALSE;
+    MIB_IF_ROW2 itf_row;
+
+    /* Get GUID from string */
+    if (IIDFromString(iid_str, &iid) != S_OK)
+    {
+        MsgToEventLog(M_SYSERR, L"%S: could not convert interface %s GUID string", __func__, iid_str);
+        goto out;
+    }
+
+    /* Get LUID from GUID */
+    if (ConvertInterfaceGuidToLuid(&iid, &itf_row.InterfaceLuid) != NO_ERROR)
+    {
+        goto out;
+    }
+
+    /* Look up interface status */
+    if (GetIfEntry2(&itf_row) != NO_ERROR)
+    {
+        MsgToEventLog(M_SYSERR, L"%S: could not get interface %s status", __func__, iid_str);
+        goto out;
+    }
+
+    if (itf_row.MediaConnectState == MediaConnectStateConnected
+        && itf_row.OperStatus == IfOperStatusUp)
+    {
+        res = TRUE;
+    }
+
+out:
+    return res;
+}
+
+/**
+ * Collect interface DNS settings to be used in excluding NRPT rules. This is
+ * needed so that local DNS keeps working even when a catch all NRPT rule is
+ * installed by a VPN connection.
+ *
+ * @param  data       pointer to the data structures the values are returned in
+ * @param  data_size  number of exclude data structures pointed to
+ */
+static void
+GetNrptExcludeData(nrpt_exclude_data_t *data, size_t data_size)
+{
+    HKEY v4_itfs = INVALID_HANDLE_VALUE;
+    HKEY v6_itfs = INVALID_HANDLE_VALUE;
+
+    if (!GetInterfacesKey(AF_INET, &v4_itfs)
+        || !GetInterfacesKey(AF_INET6, &v6_itfs))
+    {
+        goto out;
+    }
+
+    size_t i = 0;
+    DWORD enum_index = 0;
+    while (i < data_size)
+    {
+        WCHAR itf_guid[MAX_PATH];
+        DWORD itf_guid_len = _countof(itf_guid);
+        LSTATUS err = RegEnumKeyExW(v4_itfs, enum_index++, itf_guid, &itf_guid_len,
+                                    NULL, NULL, NULL, NULL);
+        if (err)
+        {
+            if (err != ERROR_NO_MORE_ITEMS)
+            {
+                MsgToEventLog(M_SYSERR, L"%S: could not enumerate interfaces (%lu)", __func__, err);
+            }
+            goto out;
+        }
+
+        /* Ignore interfaces that are not connected or disabled */
+        if (!IsInterfaceConnected(itf_guid))
+        {
+            continue;
+        }
+
+        HKEY v4_itf;
+        if (RegOpenKeyExW(v4_itfs, itf_guid, 0, KEY_READ, &v4_itf) != NO_ERROR)
+        {
+            MsgToEventLog(M_SYSERR, L"%S: could not open interface %s v4 registry key", __func__, itf_guid);
+            goto out;
+        }
+
+        /* Get the DNS domain(s) for exclude routing */
+        data[i].domains_size = sizeof(data[0].domains);
+        memset(data[i].domains, 0, data[i].domains_size);
+        err = GetItfDnsDomains(v4_itf, data[i].domains, &data[i].domains_size);
+        if (err)
+        {
+            if (err != ERROR_FILE_NOT_FOUND)
+            {
+                MsgToEventLog(M_SYSERR, L"%S: could not read interface %s domain suffix", __func__, itf_guid);
+            }
+            goto next_itf;
+        }
+
+        /* Get the IPv4 DNS servers */
+        DWORD v4_addrs_size = sizeof(data[0].addresses);
+        err = GetItfDnsServersV4(v4_itf, data[i].addresses, &v4_addrs_size);
+        if (err && err != ERROR_FILE_NOT_FOUND)
+        {
+            MsgToEventLog(M_SYSERR, L"%S: could not read interface %s v4 name servers (%ld)",
+                          __func__, itf_guid, err);
+            goto next_itf;
+        }
+
+        /* Get the IPv6 DNS servers, if there's space left */
+        PSTR v6_addrs = data[i].addresses + v4_addrs_size;
+        DWORD v6_addrs_size = sizeof(data[0].addresses) - v4_addrs_size;
+        if (v6_addrs_size > NRPT_ADDR_SIZE)
+        {
+            HKEY v6_itf;
+            if (RegOpenKeyExW(v6_itfs, itf_guid, 0, KEY_READ, &v6_itf) != NO_ERROR)
+            {
+                MsgToEventLog(M_SYSERR, L"%S: could not open interface %s v6 registry key", __func__, itf_guid);
+                goto next_itf;
+            }
+            err = GetItfDnsServersV6(v6_itf, v6_addrs, &v6_addrs_size);
+            RegCloseKey(v6_itf);
+            if (err && err != ERROR_FILE_NOT_FOUND)
+            {
+                MsgToEventLog(M_SYSERR, L"%S: could not read interface %s v6 name servers (%ld)",
+                              __func__, itf_guid, err);
+                goto next_itf;
+            }
+        }
+
+        if (v4_addrs_size || v6_addrs_size)
+        {
+            /* Replace comma-delimters with semicolons, as required by NRPT */
+            for (int j = 0; j < sizeof(data[0].addresses) && data[i].addresses[j]; j++)
+            {
+                if (data[i].addresses[j] == ',')
+                {
+                    data[i].addresses[j] = ';';
+                }
+            }
+            ++i;
+        }
+
+next_itf:
+        RegCloseKey(v4_itf);
+    }
+
+out:
+    RegCloseKey(v6_itfs);
+    RegCloseKey(v4_itfs);
+}
+
+/**
+ * Set a NRPT rule (subkey) and its values in the registry
+ *
+ * @param  nrpt_key   NRPT registry key handle
+ * @param  subkey     subkey string to create
+ * @param  address    name server address string
+ * @param  domains    domains to resolve by this server as MULTI_SZ
+ * @param  dom_size   size of domains in bytes including the terminators
+ * @param  dnssec     boolean to determine if DNSSEC is to be enabled
+ *
+ * @return NO_ERROR on success, or Windows error code
+ */
+static DWORD
+SetNrptRule(HKEY nrpt_key, PCWSTR subkey, PCSTR address,
+            PCWSTR domains, DWORD dom_size, BOOL dnssec)
+{
+    /* Create rule subkey */
+    DWORD err = NO_ERROR;
+    HKEY rule_key;
+    err = RegCreateKeyExW(nrpt_key, subkey, 0, NULL, 0, KEY_ALL_ACCESS, NULL, &rule_key, NULL);
+    if (err)
+    {
+        return err;
+    }
+
+    /* Set name(s) for DNS routing */
+    err = RegSetValueExW(rule_key, L"Name", 0, REG_MULTI_SZ, (PBYTE)domains, dom_size);
+    if (err)
+    {
+        goto out;
+    }
+
+    /* Set DNS Server address */
+    err = RegSetValueExA(rule_key, "GenericDNSServers", 0, REG_SZ, (PBYTE)address, strlen(address) + 1);
+    if (err)
+    {
+        goto out;
+    }
+
+    DWORD reg_val;
+    /* Set DNSSEC if required */
+    if (dnssec)
+    {
+        reg_val = 1;
+        err = RegSetValueExA(rule_key, "DNSSECValidationRequired", 0, REG_DWORD, (PBYTE)&reg_val, sizeof(reg_val));
+        if (err)
+        {
+            goto out;
+        }
+
+        reg_val = 0;
+        err = RegSetValueExA(rule_key, "DNSSECQueryIPSECRequired", 0, REG_DWORD, (PBYTE)&reg_val, sizeof(reg_val));
+        if (err)
+        {
+            goto out;
+        }
+
+        reg_val = 0;
+        err = RegSetValueExA(rule_key, "DNSSECQueryIPSECEncryption", 0, REG_DWORD, (PBYTE)&reg_val, sizeof(reg_val));
+        if (err)
+        {
+            goto out;
+        }
+    }
+
+    /* Set NRPT config options */
+    reg_val = dnssec ? 0x0000000A : 0x00000008;
+    err = RegSetValueExA(rule_key, "ConfigOptions", 0, REG_DWORD, (const PBYTE)&reg_val, sizeof(reg_val));
+    if (err)
+    {
+        goto out;
+    }
+
+    /* Mandatory NRPT version */
+    reg_val = 2;
+    err = RegSetValueExA(rule_key, "Version", 0, REG_DWORD, (const PBYTE)&reg_val, sizeof(reg_val));
+    if (err)
+    {
+        goto out;
+    }
+
+out:
+    if (err)
+    {
+        RegDeleteKeyW(nrpt_key, subkey);
+    }
+    RegCloseKey(rule_key);
+    return err;
+}
+
+/**
+ * Set NRPT exclude rules to accompany a catch all rule. This is done so that
+ * local resolution of names is not interfered with in case the VPN resolves
+ * all names.
+ *
+ * @param  nrpt_key   the registry key to set the rules under
+ * @param  ovpn_pid   the PID of the openvpn process
+ */
+static void
+SetNrptExcludeRules(HKEY nrpt_key, DWORD ovpn_pid)
+{
+    nrpt_exclude_data_t data[8]; /* data from up to 8 interfaces */
+    memset(data, 0, sizeof(data));
+    GetNrptExcludeData(data, _countof(data));
+
+    unsigned n = 0;
+    for (int i = 0; i < _countof(data); ++i)
+    {
+        nrpt_exclude_data_t *d = &data[i];
+        if (d->domains_size == 0)
+        {
+            break;
+        }
+
+        DWORD err;
+        WCHAR subkey[48];
+        swprintf(subkey, _countof(subkey), L"OpenVPNDNSRoutingX-%02x-%lu", ++n, ovpn_pid);
+        err = SetNrptRule(nrpt_key, subkey, d->addresses, d->domains, d->domains_size, FALSE);
+        if (err)
+        {
+            MsgToEventLog(M_ERR, L"%S: failed to set rule %s (%lu)", __func__, subkey, err);
+        }
+    }
+}
+
+/**
+ * Set NRPT rules for a openvpn process
+ *
+ * @param  nrpt_key   the registry key to set the rules under
+ * @param  addresses  name server addresses
+ * @param  domains    optional list of split routing domains
+ * @param  dnssec     boolean whether DNSSEC is to be used
+ * @param  ovpn_pid   the PID of the openvpn process
+ *
+ * @return NO_ERROR on success, or a Windows error code
+ */
+static DWORD
+SetNrptRules(HKEY nrpt_key, const nrpt_address_t *addresses,
+             const char *domains, BOOL dnssec, DWORD ovpn_pid)
+{
+    DWORD err = NO_ERROR;
+    PWSTR wide_domains = L".\0"; /* DNS route everything by default */
+    DWORD dom_size = 6;
+
+    /* Prepare DNS routing domains / split DNS */
+    if (domains[0])
+    {
+        size_t domains_len = strlen(domains);
+        dom_size = domains_len + 2; /* len + the trailing NULs */
+
+        wide_domains = utf8to16_size(domains, dom_size);
+        dom_size *= sizeof(*wide_domains);
+        if (!wide_domains)
+        {
+            return ERROR_OUTOFMEMORY;
+        }
+        /* Make a MULTI_SZ from a comma separated list */
+        for (size_t i = 0; i < domains_len; ++i)
+        {
+            if (wide_domains[i] == ',')
+            {
+                wide_domains[i] = 0;
+            }
+        }
+    }
+    else
+    {
+        SetNrptExcludeRules(nrpt_key, ovpn_pid);
+    }
+
+    /* Create address string list */
+    CHAR addr_list[NRPT_ADDR_NUM * NRPT_ADDR_SIZE];
+    PSTR pos = addr_list;
+    for (int i = 0; i < NRPT_ADDR_NUM && addresses[i][0]; ++i)
+    {
+        if (i != 0)
+        {
+            *pos++ = ';';
+        }
+        strcpy(pos, addresses[i]);
+        pos += strlen(pos);
+    }
+
+    WCHAR subkey[MAX_PATH];
+    swprintf(subkey, _countof(subkey), L"OpenVPNDNSRouting-%lu", ovpn_pid);
+    err = SetNrptRule(nrpt_key, subkey, addr_list, wide_domains, dom_size, dnssec);
+    if (err)
+    {
+        MsgToEventLog(M_ERR, L"%S: failed to set rule %s (%lu)", __func__, subkey, err);
+    }
+
+    if (domains[0])
+    {
+        free(wide_domains);
+    }
+    return err;
+}
+
+/**
+ * Return the registry key where NRPT rules are stored
+ *
+ * @param  key        pointer to the HKEY it is returned in
+ * @param  gpol       pointer to BOOL the use of GPOL hive is returned in
+ *
+ * @return NO_ERROR on success, or a Windows error code
+ */
+static LSTATUS
+OpenNrptBaseKey(PHKEY key, PBOOL gpol)
+{
+    /*
+     * Registry keys Name Service Policy Table (NRPT) rules can be stored at.
+     * When the group policy key exists, NRPT rules must be placed there.
+     * It is created when NRPT rules are pushed via group policy and it
+     * remains in the registry even if the last GP-NRPT rule is deleted.
+     */
+    static PCSTR gpol_key = "SOFTWARE\\Policies\\Microsoft\\Windows NT\\DNSClient\\DnsPolicyConfig";
+    static PCSTR sys_key = "SYSTEM\\CurrentControlSet\\Services\\Dnscache\\Parameters\\DnsPolicyConfig";
+
+    HKEY nrpt;
+    *gpol = TRUE;
+    LSTATUS err = RegOpenKeyExA(HKEY_LOCAL_MACHINE, gpol_key, 0, KEY_ALL_ACCESS, &nrpt);
+    if (err == ERROR_FILE_NOT_FOUND)
+    {
+        *gpol = FALSE;
+        err = RegOpenKeyExA(HKEY_LOCAL_MACHINE, sys_key, 0, KEY_ALL_ACCESS, &nrpt);
+        if (err)
+        {
+            nrpt = INVALID_HANDLE_VALUE;
+        }
+    }
+    *key = nrpt;
+    return err;
+}
+
+/**
+ * Delete OpenVPN NRPT rules from the registry
+ *
+ * If the pid parameter is 0 all NRPT rules added by OpenVPN are deleted.
+ * In all other cases only rules matching the pid are deleted.
+ *
+ * @param  pid        PID of the process to delete the rules for or 0
+ * @param  gpol
+ *
+ * @return BOOL to indicate if rules were deleted
+ */
+static BOOL
+DeleteNrptRules(DWORD pid, PBOOL gpol)
+{
+    HKEY key;
+    LSTATUS err = OpenNrptBaseKey(&key, gpol);
+    if (err)
+    {
+        MsgToEventLog(M_SYSERR, L"%S: could not open NRPT base key (%lu)", __func__, err);
+        return FALSE;
+    }
+
+    /* PID suffix string to compare against later */
+    WCHAR pid_str[16];
+    size_t pidlen = 0;
+    if (pid)
+    {
+        swprintf(pid_str, _countof(pid_str), L"-%lu", pid);
+        pidlen = wcslen(pid_str);
+    }
+
+    int deleted = 0;
+    DWORD enum_index = 0;
+    while (TRUE)
+    {
+        WCHAR name[MAX_PATH];
+        DWORD namelen = _countof(name);
+        err = RegEnumKeyExW(key, enum_index++, name, &namelen, NULL, NULL, NULL, NULL);
+        if (err)
+        {
+            if (err != ERROR_NO_MORE_ITEMS)
+            {
+                MsgToEventLog(M_SYSERR, L"%S: could not enumerate NRPT rules (%lu)", __func__, err);
+            }
+            break;
+        }
+
+        /* Keep rule if name doesn't match */
+        if (wcsncmp(name, L"OpenVPNDNSRouting", 17) != 0
+            || (pid && wcsncmp(name + namelen - pidlen, pid_str, pidlen) != 0))
+        {
+            continue;
+        }
+
+        if (RegDeleteKeyW(key, name) == NO_ERROR)
+        {
+            enum_index--;
+            deleted++;
+        }
+    }
+
+    RegCloseKey(key);
+    return deleted ? TRUE : FALSE;
+}
+
+/**
+ * Delete a process' NRPT rules and apply the reduced set of rules
+ *
+ * @param ovpn_pid  OpenVPN process id to delete rules for
+ */
+static void
+UndoNrptRules(DWORD ovpn_pid)
+{
+    BOOL gpol;
+    if (DeleteNrptRules(ovpn_pid, &gpol))
+    {
+        ApplyDnsSettings(gpol);
+    }
+}
+
+/**
+ * Add Name Resolution Policy Table (NRPT) rules as documented in
+ * https://msdn.microsoft.com/en-us/library/ff957356.aspx for DNS name
+ * resolution, as well as DNS search domain(s), if given.
+ *
+ * @param  msg        config messages sent by the openvpn process
+ * @param  ovpn_pid   process id of the sending openvpn process
+ * @param  lists      undo lists for this process
+ *
+ * @return NO_ERROR on success, or a Windows error code
+ */
+static DWORD
+HandleDNSConfigNrptMessage(const nrpt_dns_cfg_message_t *msg,
+                           DWORD ovpn_pid, undo_lists_t *lists)
+{
+    /*
+     * Use a non-const reference with limited scope to
+     * enforce null-termination of strings from client
+     */
+    {
+        nrpt_dns_cfg_message_t *msgptr = (nrpt_dns_cfg_message_t *) msg;
+        msgptr->iface.name[_countof(msg->iface.name) - 1] = '\0';
+        msgptr->search_domains[_countof(msg->search_domains) - 1] = '\0';
+        msgptr->resolve_domains[_countof(msg->resolve_domains) - 1] = '\0';
+        for (size_t i = 0; i < NRPT_ADDR_NUM; ++i)
+        {
+            msgptr->addresses[i][_countof(msg->addresses[0]) - 1] = '\0';
+        }
+    }
+
+    /* Make sure we have the VPN interface name */
+    if (msg->iface.name[0] == 0)
+    {
+        return ERROR_MESSAGE_DATA;
+    }
+
+    /* Some sanity checks on the add message data */
+    if (msg->header.type == msg_add_nrpt_cfg)
+    {
+        /* At least one name server address is set */
+        if (msg->addresses[0][0] == 0)
+        {
+            return ERROR_MESSAGE_DATA;
+        }
+        /* Resolve domains are double zero terminated (MULTI_SZ) */
+        const char *rdom = msg->resolve_domains;
+        size_t rdom_size = sizeof(msg->resolve_domains);
+        size_t rdom_len = strlen(rdom);
+        if (rdom_len && (rdom_len + 1 >= rdom_size || rdom[rdom_len + 2] != 0))
+        {
+            return ERROR_MESSAGE_DATA;
+        }
+    }
+
+    BOOL gpol_nrpt = FALSE;
+    BOOL gpol_list = FALSE;
+
+    WCHAR iid[64];
+    DWORD iid_err = InterfaceIdString(msg->iface.name, iid, _countof(iid));
+    if (iid_err)
+    {
+        return iid_err;
+    }
+
+    /* Delete previously set values for this instance first, if any */
+    PDWORD undo_pid = RemoveListItem(&(*lists)[undo_nrpt], CmpAny, NULL);
+    if (undo_pid)
+    {
+        if (*undo_pid != ovpn_pid)
+        {
+            MsgToEventLog(M_INFO,
+                          L"%S: PID stored for undo doesn't match: %lu vs %lu. "
+                          "This is likely an error. Cleaning up anyway.",
+                          __func__, *undo_pid, ovpn_pid);
+        }
+        DeleteNrptRules(*undo_pid, &gpol_nrpt);
+        free(undo_pid);
+
+        ResetNameServers(iid, AF_INET);
+        ResetNameServers(iid, AF_INET6);
+    }
+    SetDnsSearchDomains(msg->iface.name, NULL, &gpol_list, lists);
+
+    if (msg->header.type == msg_del_nrpt_cfg)
+    {
+        ApplyDnsSettings(gpol_nrpt || gpol_list);
+        return NO_ERROR; /* Done dealing with del message */
+    }
+
+    HKEY key;
+    LSTATUS err = OpenNrptBaseKey(&key, &gpol_nrpt);
+    if (err)
+    {
+        goto out;
+    }
+
+    /* Add undo information first in case there's no heap left */
+    PDWORD pid = malloc(sizeof(ovpn_pid));
+    if (!pid)
+    {
+        err = ERROR_OUTOFMEMORY;
+        goto out;
+    }
+    *pid = ovpn_pid;
+    if (AddListItem(&(*lists)[undo_nrpt], pid))
+    {
+        err = ERROR_OUTOFMEMORY;
+        free(pid);
+        goto out;
+    }
+
+    /* Set NRPT rules */
+    BOOL dnssec = (msg->flags & nrpt_dnssec) != 0;
+    err = SetNrptRules(key, msg->addresses, msg->resolve_domains, dnssec, ovpn_pid);
+    if (err)
+    {
+        goto out;
+    }
+
+    /* Set name servers */
+    err = SetNameServerAddresses(iid, msg->addresses);
+    if (err)
+    {
+        goto out;
+    }
+
+    /* Set search domains, if any */
+    if (msg->search_domains[0])
+    {
+        err = SetDnsSearchDomains(msg->iface.name, msg->search_domains, &gpol_list, lists);
+    }
+
+    ApplyDnsSettings(gpol_nrpt || gpol_list);
+
+out:
+    return err;
+}
+
 static DWORD
 HandleWINSConfigMessage(const wins_cfg_message_t *msg, undo_lists_t *lists)
 {
@@ -2202,7 +3108,7 @@
 }
 
 static VOID
-HandleMessage(HANDLE pipe, HANDLE ovpn_proc,
+HandleMessage(HANDLE pipe, PPROCESS_INFORMATION proc_info,
               DWORD bytes, DWORD count, LPHANDLE events, undo_lists_t *lists)
 {
     pipe_message_t msg;
@@ -2265,6 +3171,14 @@
             ack.error_number = HandleDNSConfigMessage(&msg.dns, lists);
             break;
 
+        case msg_add_nrpt_cfg:
+        case msg_del_nrpt_cfg:
+        {
+            DWORD ovpn_pid = proc_info->dwProcessId;
+            ack.error_number = HandleDNSConfigNrptMessage(&msg.nrpt_dns, ovpn_pid, lists);
+        }
+        break;
+
         case msg_add_wins_cfg:
         case msg_del_wins_cfg:
             ack.error_number = HandleWINSConfigMessage(&msg.wins, lists);
@@ -2280,7 +3194,8 @@
         case msg_register_ring_buffers:
             if (msg.header.size == sizeof(msg.rrb))
             {
-                ack.error_number = HandleRegisterRingBuffers(&msg.rrb, ovpn_proc, lists);
+                HANDLE ovpn_hnd = proc_info->hProcess;
+                ack.error_number = HandleRegisterRingBuffers(&msg.rrb, ovpn_hnd, lists);
             }
             break;
 
@@ -2331,6 +3246,10 @@
                     ResetNameServers(item->data, AF_INET6);
                     break;
 
+                case undo_nrpt:
+                    UndoNrptRules(*(PDWORD)item->data);
+                    break;
+
                 case undo_domains:
                     UndoDnsSearchDomains(item->data);
                     break;
@@ -2652,7 +3571,7 @@
             break;
         }
 
-        HandleMessage(ovpn_pipe, proc_info.hProcess, bytes, 1, &exit_event, &undo_lists);
+        HandleMessage(ovpn_pipe, &proc_info, bytes, 1, &exit_event, &undo_lists);
     }
 
     WaitForSingleObject(proc_info.hProcess, IO_TIMEOUT);
@@ -2848,24 +3767,28 @@
 static void
 CleanupRegistry(void)
 {
-    HKEY key;
-    DWORD changed = 0;
+    BOOL changed = FALSE;
+
+    /* Clean up leftover NRPT rules */
+    BOOL gpol_nrpt;
+    changed = DeleteNrptRules(0, &gpol_nrpt);
 
     /* Clean up leftover DNS search list fragments */
+    HKEY key;
     BOOL gpol_list;
     GetDnsSearchListKey(NULL, &gpol_list, &key);
     if (key != INVALID_HANDLE_VALUE)
     {
         if (ResetDnsSearchDomains(key))
         {
-            changed++;
+            changed = TRUE;
         }
         RegCloseKey(key);
     }
 
     if (changed)
     {
-        ApplyDnsSettings(gpol_list);
+        ApplyDnsSettings(gpol_nrpt || gpol_list);
     }
 }
 

