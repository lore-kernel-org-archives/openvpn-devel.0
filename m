From: "d12fk (Code Review)" <gerrit@...515...>
Date: Thu, 12 Dec 2024 07:47:45 +0000
References: <gerrit.1733989644000.I576e74f3276362606e9cbd50bb5adbebaaf209cc@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <aa66ccf1713028bfa69a0d1563606dc34685a323-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Yg+GOeXS8Jg="; charset=UTF-8
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: win: implement
 --dns option support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Yg+GOeXS8Jg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/837?usp=3Demail

to review the following change.


Change subject: win: implement --dns option support
......................................................................

win: implement --dns option support

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
---
M include/openvpn-msg.h
M src/openvpn/dns.c
M src/openvpn/dns.h
M src/openvpn/init.c
M src/openvpnserv/interactive.c
5 files changed, 1,096 insertions(+), 7 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/37/837/1

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
index e22ea00..4528a9c 100644
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
@@ -428,6 +434,93 @@
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
+    size_t term_size =3D nrpt_domains ? 2 : 1;
+    size_t leading_dot =3D nrpt_domains ? 1 : 0;
+    size_t offset =3D 0;
+
+    memset(dst, 0, dst_size);
+
+    while (src)
+    {
+        size_t len =3D strlen(src->name);
+        if (offset + leading_dot + len + term_size > dst_size)
+        {
+            msg(M_WARN, "WARNING: %s truncated", what);
+            if (offset)
+            {
+                /* Remove trailing comma */
+                *(dst + offset - 1) =3D '\0';
+            }
+            break;
+        }
+
+        if (leading_dot)
+        {
+            *(dst + offset++) =3D '.';
+        }
+        strncpy(dst + offset, src->name, len);
+        offset +=3D len;
+
+        src =3D src->next;
+        if (src)
+        {
+            *(dst + offset++) =3D ',';
+        }
+    }
+}
+
+static void
+run_up_down_service(bool add, const struct options *o, const struct tuntap=
 *tt)
+{
+    const struct dns_server *server =3D o->dns_options.servers;
+    const struct dns_domain *search_domains =3D o->dns_options.search_doma=
ins;
+
+    ack_message_t ack;
+    nrpt_dns_cfg_message_t nrpt =3D {
+        .header =3D {
+            (add ? msg_add_nrpt_cfg : msg_del_nrpt_cfg),
+            sizeof(nrpt_dns_cfg_message_t),
+            0
+        },
+        .iface =3D { .index =3D tt->adapter_index, .name =3D "" },
+        .flags =3D server->dnssec =3D=3D DNS_SECURITY_NO ? 0 : nrpt_dnssec,
+    };
+    strncpynt(nrpt.iface.name, tt->actual_name, sizeof(nrpt.iface.name));
+
+    for (size_t i =3D 0; i < NRPT_ADDR_NUM; ++i)
+    {
+        if (server->addr[i].family =3D=3D AF_UNSPEC)
+        {
+            /* No more addresses */
+            break;
+        }
+
+        if (inet_ntop(server->addr[i].family, &server->addr[i].in,
+                      nrpt.addresses[i], NRPT_ADDR_SIZE) =3D=3D NULL)
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
@@ -506,3 +599,43 @@

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
+    const struct dns_server *s =3D o->dns_options.servers;
+    while (up && s)
+    {
+        size_t bad_count =3D 0;
+        for (size_t i =3D 0; i < s->addr_count; ++i)
+        {
+            if ((s->addr[i].family =3D=3D AF_INET6 && !tt->did_ifconfig_ip=
v6_setup)
+                || (s->addr[i].family =3D=3D AF_INET && !tt->did_ifconfig_=
setup))
+            {
+                ++bad_count;
+            }
+        }
+        if (bad_count =3D=3D s->addr_count)
+        {
+            msg(M_WARN, "DNS server %ld only has address(es) from a family=
 "
+                "the tunnel is not configured for - it will not be reachab=
le",
+                s->priority);
+        }
+        else if (bad_count)
+        {
+            msg(M_WARN, "DNS server %ld has address(es) from a family "
+                "the tunnel is not configured for", s->priority);
+        }
+        s =3D s->next;
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
index 9371024..36a9bca 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2008,6 +2008,8 @@
                         c->c2.frame.tun_mtu, c->c2.es, &c->net_ctx);
         }

+        run_dns_up_down(true, &c->options, c->c1.tuntap);
+
         /* run the up script */
         run_up_down(c->options.up_script,
                     c->plugins,
@@ -2046,6 +2048,8 @@
         /* explicitly set the ifconfig_* env vars */
         do_ifconfig_setenv(c->c1.tuntap, c->c2.es);

+        run_dns_up_down(true, &c->options, c->c1.tuntap);
+
         /* run the up script if user specified --up-restart */
         if (c->options.up_restart)
         {
@@ -2134,6 +2138,8 @@
     adapter_index =3D c->c1.tuntap->adapter_index;
 #endif

+    run_dns_up_down(false, &c->options, c->c1.tuntap);
+
     if (force || !(c->sig->signal_received =3D=3D SIGUSR1 && c->options.pe=
rsist_tun))
     {
         static_context =3D NULL;
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 5042283..d5b7e5d 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -24,6 +24,7 @@

 #include "service.h"

+#include <winerror.h>
 #include <ws2tcpip.h>
 #include <iphlpapi.h>
 #include <userenv.h>
@@ -88,6 +89,7 @@
     wfp_block,
     undo_dns4,
     undo_dns6,
+    undo_nrpt,
     undo_domains,
     undo_ring_buffer,
     undo_wins,
@@ -119,12 +121,20 @@
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
@@ -1946,6 +1956,903 @@
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
+    DWORD size =3D sizeof(dhcp);
+    LSTATUS err;
+
+    err =3D RegGetValueA(key, NULL, "EnableDHCP", RRF_RT_REG_DWORD, NULL, =
(PBYTE)&dhcp, &size);
+    if (err !=3D NO_ERROR)
+    {
+        MsgToEventLog(M_SYSERR, TEXT("IsDhcpEnabled: "
+                                     "Could not read DHCP status (%lu)"), =
err);
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
+ * @return LSTATUS NO_ERROR in case of success, a Windows error code other=
wise
+ */
+static LSTATUS
+SetNameServerAddresses(PWSTR itf_id, const nrpt_address_t *addresses)
+{
+    const short families[] =3D { AF_INET, AF_INET6 };
+    for (int i =3D 0; i < _countof(families); i++)
+    {
+        short family =3D families[i];
+
+        /* Create a comma sparated list of addresses of this family */
+        int offset =3D 0;
+        char addr_list[NRPT_ADDR_SIZE * NRPT_ADDR_NUM];
+        for (int j =3D 0; j < NRPT_ADDR_NUM && addresses[j][0]; j++)
+        {
+            if ((family =3D=3D AF_INET6 && strchr(addresses[j], ':') =3D=
=3D NULL)
+                || (family =3D=3D AF_INET && strchr(addresses[j], ':') !=
=3D NULL))
+            {
+                /* Address family doesn't match, skip this one */
+                continue;
+            }
+            if (offset)
+            {
+                addr_list[offset++] =3D ',';
+            }
+            strcpy(addr_list + offset, addresses[j]);
+            offset +=3D strlen(addresses[j]);
+        }
+
+        if (offset =3D=3D 0)
+        {
+            /* No address for this family to set */
+            continue;
+        }
+
+        /* Set name server addresses */
+        LSTATUS err =3D SetNameServers(itf_id, family, addr_list);
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
+    addrs[*size - 1] =3D '\0';
+
+    LSTATUS err;
+    DWORD s =3D *size;
+    err =3D RegGetValueA(itf_key, NULL, "NameServer", RRF_RT_REG_SZ, NULL,=
 (PBYTE)addrs, &s);
+    if (err && err !=3D ERROR_FILE_NOT_FOUND)
+    {
+        *size =3D 0;
+        return err;
+    }
+
+    /* Try DHCP addresses if we don't have some already */
+    if (!strchr(addrs, '.') && IsDhcpEnabled(itf_key))
+    {
+        s =3D *size;
+        RegGetValueA(itf_key, NULL, "DhcpNameServer", RRF_RT_REG_SZ, NULL,=
 (PBYTE)addrs, &s);
+        if (err)
+        {
+            *size =3D 0;
+            return err;
+        }
+    }
+
+    if (strchr(addrs, '.'))
+    {
+        *size =3D s;
+        return NO_ERROR;
+    }
+
+    *size =3D 0;
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
+    addrs[*size - 1] =3D '\0';
+
+    LSTATUS err;
+    DWORD s =3D *size;
+    err =3D RegGetValueA(itf_key, NULL, "NameServer", RRF_RT_REG_SZ, NULL,=
 (PBYTE)addrs, &s);
+    if (err && err !=3D ERROR_FILE_NOT_FOUND)
+    {
+        *size =3D 0;
+        return err;
+    }
+
+    /* Try DHCP addresses if we don't have some already */
+    if (!strchr(addrs, ':') && IsDhcpEnabled(itf_key))
+    {
+        IN6_ADDR in_addrs[8];
+        DWORD in_addrs_size =3D sizeof(in_addrs);
+        err =3D RegGetValueA(itf_key, NULL, "Dhcpv6DNSServers", RRF_RT_REG=
_BINARY, NULL,
+                           (PBYTE)in_addrs, &in_addrs_size);
+        if (err)
+        {
+            *size =3D 0;
+            return err;
+        }
+
+        s =3D *size;
+        PSTR pos =3D addrs;
+        size_t in_addrs_read =3D in_addrs_size / sizeof(IN6_ADDR);
+        for (size_t i =3D 0; i < in_addrs_read; ++i)
+        {
+            if (i !=3D 0)
+            {
+                /* Add separator */
+                *pos++ =3D ',';
+                s--;
+            }
+
+            if (inet_ntop(AF_INET6, &in_addrs[i],
+                          pos, s) !=3D NULL)
+            {
+                *size =3D 0;
+                return ERROR_MORE_DATA;
+            }
+
+            size_t addr_len =3D strlen(pos);
+            pos +=3D addr_len;
+            s -=3D addr_len;
+        }
+        s =3D strlen(addrs) + 1;
+    }
+
+    if (strchr(addrs, ':'))
+    {
+        *size =3D s;
+        return NO_ERROR;
+    }
+
+    *size =3D 0;
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
+ * @param  size       pointer to size of the domains buffer in bytes. Will=
 be
+ *                    set to the size of the string returned, including
+ *                    the terminating zeros or 0.
+ *
+ * @return LSTATUS NO_ERROR if the domain suffix(es) were read successfull=
y,
+ *         ERROR_FILE_NOT_FOUND if no domain was found for the interface,
+ *         ERROR_MORE_DATA if the list did not fit into the buffer,
+ *         any other error indicates an error while reading from the regis=
try.
+ */
+static LSTATUS
+GetItfDnsDomains(HKEY itf, PWSTR domains, PDWORD size)
+{
+    if (domains =3D=3D NULL || size =3D=3D 0)
+    {
+        return ERROR_INVALID_PARAMETER;
+    }
+
+    LSTATUS err =3D ERROR_FILE_NOT_FOUND;
+    const DWORD buf_size =3D *size;
+    const size_t one_glyph =3D sizeof(*domains);
+    PWSTR values[] =3D { L"SearchList", L"Domain", L"DhcpDomainSearchList"=
, L"DhcpDomain", NULL};
+
+    for (int i =3D 0; values[i]; i++)
+    {
+        err =3D RegGetValueW(itf, NULL, values[i], RRF_RT_REG_SZ, NULL, (P=
BYTE)domains, size);
+        if (!err && *size > one_glyph && wcschr(domains, '.'))
+        {
+            /*
+             * Found domain(s), now convert them:
+             *   - prefix each domain with a dot
+             *   - convert comma separated list to MULTI_SZ
+             */
+            PWCHAR pos =3D domains;
+            const DWORD buf_len =3D buf_size / one_glyph;
+            while (TRUE)
+            {
+                /* Terminate the domain at the next comma */
+                PWCHAR comma =3D wcschr(pos, ',');
+                if (comma)
+                {
+                    *comma =3D '\0';
+                }
+
+                /* Check for enough space to convert this domain */
+                size_t converted_size =3D pos - domains;
+                size_t domain_len =3D wcslen(pos) + 1;
+                size_t domain_size =3D domain_len * one_glyph;
+                size_t extra_size =3D 2 * one_glyph;
+                if (converted_size + domain_size + extra_size > buf_size)
+                {
+                    /* Domain doesn't fit, bad luck if it's the first one =
*/
+                    *pos =3D '\0';
+                    *size =3D converted_size =3D=3D 0 ? 0 : *size + 1;
+                    return ERROR_MORE_DATA;
+                }
+
+                /* Prefix domain at pos with the dot */
+                memmove(pos + 1, pos, buf_size - converted_size - one_glyp=
h);
+                domains[buf_len - 1] =3D '\0';
+                *pos =3D '.';
+                *size +=3D 1;
+
+                if (!comma)
+                {
+                    /* Conversion is done */
+                    *(pos + domain_len) =3D '\0';
+                    *size +=3D 1;
+                    return NO_ERROR;
+                }
+
+                pos =3D comma + 1;
+            }
+        }
+    }
+
+    *size =3D 0;
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
+    BOOL res =3D FALSE;
+    MIB_IF_ROW2 itf_row;
+
+    /* Get LUID from GUID string */
+    if (IIDFromString(iid_str, &iid) !=3D S_OK
+        || ConvertInterfaceGuidToLuid(&iid, &itf_row.InterfaceLuid) !=3D N=
O_ERROR)
+    {
+        MsgToEventLog(M_SYSERR, TEXT("IsInterfaceConnected: "
+                                     "could not convert interface %s GUID =
to LUID"), iid_str);
+        goto out;
+    }
+
+    /* Look up interface status */
+    if (GetIfEntry2(&itf_row) !=3D NO_ERROR)
+    {
+        MsgToEventLog(M_SYSERR, TEXT("IsInterfaceConnected: "
+                                     "could not get interface %s status"),=
 iid_str);
+        goto out;
+    }
+
+    if (itf_row.MediaConnectState =3D=3D MediaConnectStateConnected
+        && itf_row.OperStatus =3D=3D IfOperStatusUp)
+    {
+        res =3D TRUE;
+    }
+
+out:
+    return res;
+}
+
+/**
+ * Collect interface DNS settings to be used in excluding NRPT rules. This=
 is
+ * needed so that local DNS keeps working even when a catch all NRPT rule =
is
+ * installed by a VPN connection.
+ *
+ * @param  data       pointer to the data structures the values are return=
ed in
+ * @param  data_size  number of exclude data structures pointed to
+ */
+static void
+GetNrptExcludeData(nrpt_exclude_data_t *data, size_t data_size)
+{
+    HKEY v4_itfs =3D INVALID_HANDLE_VALUE;
+    HKEY v6_itfs =3D INVALID_HANDLE_VALUE;
+
+    if (!GetInterfacesKey(AF_INET, &v4_itfs)
+        || !GetInterfacesKey(AF_INET6, &v6_itfs))
+    {
+        goto out;
+    }
+
+    size_t i =3D 0;
+    DWORD enum_index =3D 0;
+    while (i < data_size)
+    {
+        WCHAR itf_guid[MAX_PATH];
+        DWORD itf_guid_len =3D _countof(itf_guid);
+        LSTATUS err =3D RegEnumKeyExW(v4_itfs, enum_index++, itf_guid, &it=
f_guid_len,
+                                    NULL, NULL, NULL, NULL);
+        if (err)
+        {
+            if (err !=3D ERROR_NO_MORE_ITEMS)
+            {
+                MsgToEventLog(M_SYSERR, TEXT("GetNrptExcludeData: "
+                                             "could not enumerate interfac=
es (%lu)"), err);
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
+        if (RegOpenKeyExW(v4_itfs, itf_guid, 0, KEY_READ, &v4_itf) !=3D NO=
_ERROR)
+        {
+            MsgToEventLog(M_SYSERR, TEXT("GetNrptExcludeData: "
+                                         "could not open interface %s v4 r=
egistry key"), itf_guid);
+            goto out;
+        }
+
+        /* Get the DNS domain(s) for exclude routing */
+        data[i].domains_size =3D sizeof(data[0].domains);
+        memset(data[i].domains, 0, data[i].domains_size);
+        err =3D GetItfDnsDomains(v4_itf, data[i].domains, &data[i].domains=
_size);
+        if (err)
+        {
+            if (err !=3D ERROR_FILE_NOT_FOUND)
+            {
+                MsgToEventLog(M_SYSERR, TEXT("GetNrptExcludeData: "
+                                             "could not read interface %s =
domain suffix"), itf_guid);
+            }
+            goto next_itf;
+        }
+
+        /* Get the IPv4 DNS servers */
+        DWORD v4_addrs_size =3D sizeof(data[0].addresses);
+        err =3D GetItfDnsServersV4(v4_itf, data[i].addresses, &v4_addrs_si=
ze);
+        if (err && err !=3D ERROR_FILE_NOT_FOUND)
+        {
+            MsgToEventLog(M_SYSERR,
+                          TEXT("GetNrptExcludeData: could not read interfa=
ce %s v4 name servers (%ld)"),
+                          itf_guid, err);
+            goto next_itf;
+        }
+
+        /* Get the IPv6 DNS servers, if there's space left */
+        PSTR v6_addrs =3D data[i].addresses + v4_addrs_size;
+        DWORD v6_addrs_size =3D sizeof(data[0].addresses) - v4_addrs_size;
+        if (v6_addrs_size > NRPT_ADDR_SIZE)
+        {
+            HKEY v6_itf;
+            if (RegOpenKeyExW(v6_itfs, itf_guid, 0, KEY_READ, &v6_itf) !=
=3D NO_ERROR)
+            {
+                MsgToEventLog(M_SYSERR, TEXT("GetNrptExcludeData: "
+                                             "could not open interface %s =
v6 registry key"), itf_guid);
+                goto next_itf;
+            }
+            err =3D GetItfDnsServersV6(v6_itf, v6_addrs, &v6_addrs_size);
+            RegCloseKey(v6_itf);
+            if (err && err !=3D ERROR_FILE_NOT_FOUND)
+            {
+                MsgToEventLog(M_SYSERR,
+                              TEXT("GetNrptExcludeData: could not read int=
erface %s v6 name servers (%ld)"),
+                              itf_guid, err);
+                goto next_itf;
+            }
+        }
+
+        if (v4_addrs_size || v6_addrs_size)
+        {
+            /* Replace comma-delimters with semicolons, as required by NRP=
T */
+            for (int j =3D 0; j < sizeof(data[0].addresses) && data[i].add=
resses[j]; j++)
+            {
+                if (data[i].addresses[j] =3D=3D ',')
+                {
+                    data[i].addresses[j] =3D ';';
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
+    DWORD err =3D NO_ERROR;
+    HKEY rule_key;
+    err =3D RegCreateKeyExW(nrpt_key, subkey, 0, NULL, 0, KEY_ALL_ACCESS, =
NULL, &rule_key, NULL);
+    if (err)
+    {
+        return err;
+    }
+
+    /* Set name(s) for DNS routing */
+    err =3D RegSetValueExW(rule_key, L"Name", 0, REG_MULTI_SZ, (PBYTE)doma=
ins, dom_size);
+    if (err)
+    {
+        goto out;
+    }
+
+    /* Set DNS Server address */
+    err =3D RegSetValueExA(rule_key, "GenericDNSServers", 0, REG_SZ, (PBYT=
E)address, strlen(address) + 1);
+    if (err)
+    {
+        goto out;
+    }
+
+    DWORD reg_val;
+    /* Set DNSSEC if required */
+    if (dnssec)
+    {
+        reg_val =3D 1;
+        err =3D RegSetValueExA(rule_key, "DNSSECValidationRequired", 0, RE=
G_DWORD, (PBYTE)&reg_val, sizeof(reg_val));
+        if (err)
+        {
+            goto out;
+        }
+
+        reg_val =3D 0;
+        err =3D RegSetValueExA(rule_key, "DNSSECQueryIPSECRequired", 0, RE=
G_DWORD, (PBYTE)&reg_val, sizeof(reg_val));
+        if (err)
+        {
+            goto out;
+        }
+
+        reg_val =3D 0;
+        err =3D RegSetValueExA(rule_key, "DNSSECQueryIPSECEncryption", 0, =
REG_DWORD, (PBYTE)&reg_val, sizeof(reg_val));
+        if (err)
+        {
+            goto out;
+        }
+    }
+
+    /* Set NRPT config options */
+    reg_val =3D dnssec ? 0x0000000A : 0x00000008;
+    err =3D RegSetValueExA(rule_key, "ConfigOptions", 0, REG_DWORD, (const=
 PBYTE)&reg_val, sizeof(reg_val));
+    if (err)
+    {
+        goto out;
+    }
+
+    /* Mandatory NRPT version */
+    reg_val =3D 2;
+    err =3D RegSetValueExA(rule_key, "Version", 0, REG_DWORD, (const PBYTE=
)&reg_val, sizeof(reg_val));
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
+ * Set NRPT exclude rules to accompany a catch all rule. This is done so t=
hat
+ * local resolution of names is not interfered with in case the VPN resolv=
es
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
+    unsigned n =3D 0;
+    for (int i =3D 0; i < _countof(data); ++i)
+    {
+        DWORD err;
+        WCHAR subkey[48];
+        swprintf(subkey, _countof(subkey), L"OpenVPNDNSRoutingX-%02x-%lu",=
 ++n, ovpn_pid);
+
+        nrpt_exclude_data_t *d =3D &data[i];
+        err =3D SetNrptRule(nrpt_key, subkey, d->addresses, d->domains, d-=
>domains_size, FALSE);
+        if (err)
+        {
+            MsgToEventLog(M_ERR, TEXT("SetNrptExcludeRules: "
+                                      "failed to set rule %s (%lu)"), subk=
ey, err);
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
+    DWORD err =3D NO_ERROR;
+    PWSTR wide_domains =3D L".\0"; /* DNS route everything by default */
+    DWORD dom_size =3D 6;
+
+    /* Prepare DNS routing domains / split DNS */
+    if (domains[0])
+    {
+        size_t domains_len =3D strlen(domains);
+        dom_size =3D domains_len + 2; /* len + the trailing NULs */
+
+        wide_domains =3D utf8to16_size(domains, dom_size);
+        dom_size *=3D sizeof(*wide_domains);
+        if (!wide_domains)
+        {
+            return ERROR_OUTOFMEMORY;
+        }
+        /* Make a MULTI_SZ from a comma separated list */
+        for (size_t i =3D 0; i < domains_len; ++i)
+        {
+            if (wide_domains[i] =3D=3D ',')
+            {
+                wide_domains[i] =3D 0;
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
+    PSTR pos =3D addr_list;
+    for (int i =3D 0; i < NRPT_ADDR_NUM && addresses[i][0]; ++i)
+    {
+        if (i !=3D 0)
+        {
+            *pos++ =3D ';';
+        }
+        strcpy(pos, addresses[i]);
+        pos +=3D strlen(pos);
+    }
+
+    WCHAR subkey[MAX_PATH];
+    swprintf(subkey, _countof(subkey), L"OpenVPNDNSRouting-%lu", ovpn_pid);
+    err =3D SetNrptRule(nrpt_key, subkey, addr_list, wide_domains, dom_siz=
e, dnssec);
+    if (err)
+    {
+        MsgToEventLog(M_ERR, TEXT("SetNrptRules: "
+                                  "failed to set rule %s (%lu)"), subkey, =
err);
+    }
+
+    free(wide_domains);
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
+     * Registry keys Name Service Policy Table (NRPT) rules can be stored =
at.
+     * When the group policy key exists, NRPT rules must be placed there.
+     * It is created when NRPT rules are pushed via group policy and it
+     * remains in the registry even if the last GP-NRPT rule is deleted.
+     */
+    static PCSTR gpol_key =3D "SOFTWARE\\Policies\\Microsoft\\Windows NT\\=
DNSClient\\DnsPolicyConfig";
+    static PCSTR sys_key =3D "SYSTEM\\CurrentControlSet\\Services\\Dnscach=
e\\Parameters\\DnsPolicyConfig";
+
+    HKEY nrpt;
+    *gpol =3D TRUE;
+    LSTATUS err =3D RegOpenKeyExA(HKEY_LOCAL_MACHINE, gpol_key, 0, KEY_ALL=
_ACCESS, &nrpt);
+    if (err =3D=3D ERROR_FILE_NOT_FOUND)
+    {
+        *gpol =3D FALSE;
+        err =3D RegOpenKeyExA(HKEY_LOCAL_MACHINE, sys_key, 0, KEY_ALL_ACCE=
SS, &nrpt);
+        if (err)
+        {
+            nrpt =3D INVALID_HANDLE_VALUE;
+        }
+    }
+    *key =3D nrpt;
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
+    LSTATUS err =3D OpenNrptBaseKey(&key, gpol);
+    if (err)
+    {
+        MsgToEventLog(M_SYSERR, TEXT("DeleteNrptRules: "
+                                     "could not open NRPT base key (%lu)")=
, err);
+        return FALSE;
+    }
+
+    /* PID suffix string to compare against later */
+    WCHAR pid_str[16];
+    size_t pidlen =3D 0;
+    if (pid)
+    {
+        swprintf(pid_str, _countof(pid_str), L"-%lu", pid);
+        pidlen =3D wcslen(pid_str);
+    }
+
+    int deleted =3D 0;
+    DWORD enum_index =3D 0;
+    while (TRUE)
+    {
+        WCHAR name[MAX_PATH];
+        DWORD namelen =3D _countof(name);
+        err =3D RegEnumKeyExW(key, enum_index++, name, &namelen, NULL, NUL=
L, NULL, NULL);
+        if (err)
+        {
+            if (err !=3D ERROR_NO_MORE_ITEMS)
+            {
+                MsgToEventLog(M_SYSERR, TEXT("DeleteNrptRules: "
+                                             "could not enumerate NRPT rul=
es (%lu)"), err);
+            }
+            break;
+        }
+
+        /* Keep rule if name doesn't match */
+        if (wcsncmp(name, L"OpenVPNDNSRouting", 17) !=3D 0
+            || (pid && wcsncmp(name + namelen - pidlen, pid_str, pidlen) !=
=3D 0))
+        {
+            continue;
+        }
+
+        if (RegDeleteKeyW(key, name) =3D=3D NO_ERROR)
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
+        nrpt_dns_cfg_message_t *msgptr =3D (nrpt_dns_cfg_message_t *) msg;
+        msgptr->iface.name[_countof(msg->iface.name) - 1] =3D '\0';
+        msgptr->search_domains[_countof(msg->search_domains) - 1] =3D '\0';
+        msgptr->resolve_domains[_countof(msg->resolve_domains) - 1] =3D '\=
0';
+        for (size_t i =3D 0; i < NRPT_ADDR_NUM; ++i)
+        {
+            msgptr->addresses[i][_countof(msg->addresses[0]) - 1] =3D '\0';
+        }
+    }
+
+    /* Make sure we have the VPN interface name */
+    if (msg->iface.name[0] =3D=3D 0)
+    {
+        return ERROR_MESSAGE_DATA;
+    }
+
+    /* Some sanity checks on the add message data */
+    if (msg->header.type =3D=3D msg_add_nrpt_cfg)
+    {
+        /* At least one name server address is set */
+        if (msg->addresses[0][0] =3D=3D 0)
+        {
+            return ERROR_MESSAGE_DATA;
+        }
+        /* Resolve domains are double zero terminated (MULTI_SZ) */
+        const char *rdom =3D msg->resolve_domains;
+        size_t rdom_size =3D sizeof(msg->resolve_domains);
+        size_t rdom_len =3D strlen(rdom);
+        if (rdom_len && (rdom_len + 1 >=3D rdom_size || rdom[rdom_len + 2]=
 !=3D 0))
+        {
+            return ERROR_MESSAGE_DATA;
+        }
+    }
+
+    BOOL gpol_nrpt =3D FALSE;
+    BOOL gpol_list =3D FALSE;
+
+    WCHAR iid[64];
+    DWORD iid_err =3D InterfaceIdString(msg->iface.name, iid, sizeof(iid));
+    if (iid_err)
+    {
+        return iid_err;
+    }
+
+    /* Delete previously set values for this instance first, if any */
+    PDWORD undo_pid =3D RemoveListItem(&(*lists)[undo_nrpt], CmpAny, NULL);
+    if (undo_pid)
+    {
+        if (*undo_pid !=3D ovpn_pid)
+        {
+            MsgToEventLog(M_INFO, TEXT("HandleDNSConfigNrptMessage: "
+                                       "PID stored for undo doesn't match:=
 %lu vs %lu. "
+                                       "This is likely an error. Cleaning =
up anyway."),
+                          *undo_pid, ovpn_pid);
+        }
+        DeleteNrptRules(*undo_pid, &gpol_nrpt);
+        free(undo_pid);
+
+        ResetNameServers(iid, AF_INET);
+        ResetNameServers(iid, AF_INET6);
+    }
+    SetDnsSearchDomains(msg->iface.name, NULL, &gpol_list, lists);
+
+    if (msg->header.type =3D=3D msg_del_nrpt_cfg)
+    {
+        ApplyDnsSettings(gpol_nrpt || gpol_list);
+        return NO_ERROR; /* Done dealing with del message */
+    }
+
+    HKEY key;
+    LSTATUS err =3D OpenNrptBaseKey(&key, &gpol_nrpt);
+    if (err)
+    {
+        goto out;
+    }
+
+    /* Add undo information first in case there's no heap left */
+    PDWORD pid =3D malloc(sizeof(ovpn_pid));
+    if (!pid)
+    {
+        err =3D ERROR_OUTOFMEMORY;
+        goto out;
+    }
+    *pid =3D ovpn_pid;
+    if (AddListItem(&(*lists)[undo_nrpt], pid))
+    {
+        err =3D ERROR_OUTOFMEMORY;
+        free(pid);
+        goto out;
+    }
+
+    /* Set NRPT rules */
+    BOOL dnssec =3D (msg->flags & nrpt_dnssec) !=3D 0;
+    err =3D SetNrptRules(key, msg->addresses, msg->resolve_domains, dnssec=
, ovpn_pid);
+    if (err)
+    {
+        goto out;
+    }
+
+    /* Set name servers */
+    err =3D SetNameServerAddresses(iid, msg->addresses);
+    if (err)
+    {
+        goto out;
+    }
+
+    /* Set search domains, if any */
+    if (msg->search_domains[0])
+    {
+        err =3D SetDnsSearchDomains(msg->iface.name, msg->search_domains, =
&gpol_list, lists);
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
@@ -2201,7 +3108,7 @@
 }

 static VOID
-HandleMessage(HANDLE pipe, HANDLE ovpn_proc,
+HandleMessage(HANDLE pipe, PPROCESS_INFORMATION proc_info,
               DWORD bytes, DWORD count, LPHANDLE events, undo_lists_t *lis=
ts)
 {
     pipe_message_t msg;
@@ -2264,6 +3171,14 @@
             ack.error_number =3D HandleDNSConfigMessage(&msg.dns, lists);
             break;

+        case msg_add_nrpt_cfg:
+        case msg_del_nrpt_cfg:
+        {
+            DWORD ovpn_pid =3D proc_info->dwProcessId;
+            ack.error_number =3D HandleDNSConfigNrptMessage(&msg.nrpt_dns,=
 ovpn_pid, lists);
+        }
+        break;
+
         case msg_add_wins_cfg:
         case msg_del_wins_cfg:
             ack.error_number =3D HandleWINSConfigMessage(&msg.wins, lists);
@@ -2279,7 +3194,8 @@
         case msg_register_ring_buffers:
             if (msg.header.size =3D=3D sizeof(msg.rrb))
             {
-                ack.error_number =3D HandleRegisterRingBuffers(&msg.rrb, o=
vpn_proc, lists);
+                HANDLE ovpn_hnd =3D proc_info->hProcess;
+                ack.error_number =3D HandleRegisterRingBuffers(&msg.rrb, o=
vpn_hnd, lists);
             }
             break;

@@ -2330,6 +3246,8 @@
                     ResetNameServers(item->data, AF_INET6);
                     break;

+                case undo_nrpt:
+                    UndoNrptRules(*(PDWORD)item->data);
                     break;

                 case undo_domains:
@@ -2653,7 +3571,7 @@
             break;
         }

-        HandleMessage(ovpn_pipe, proc_info.hProcess, bytes, 1, &exit_event=
, &undo_lists);
+        HandleMessage(ovpn_pipe, &proc_info, bytes, 1, &exit_event, &undo_=
lists);
     }

     WaitForSingleObject(proc_info.hProcess, IO_TIMEOUT);
@@ -2849,24 +3767,28 @@
 static void
 CleanupRegistry()
 {
-    HKEY key;
-    DWORD changed =3D 0;
+    BOOL changed =3D FALSE;
+
+    /* Clean up leftover NRPT rules */
+    BOOL gpol_nrpt;
+    changed =3D DeleteNrptRules(0, &gpol_nrpt);

     /* Clean up leftover DNS search list fragments */
+    HKEY key;
     BOOL gpol_list;
     GetDnsSearchListKey(NULL, &gpol_list, &key);
     if (key !=3D INVALID_HANDLE_VALUE)
     {
         if (ResetDnsSearchDomains(key))
         {
-            changed++;
+            changed =3D TRUE;
         }
         RegCloseKey(key);
     }

     if (changed)
     {
-        ApplyDnsSettings(gpol_list);
+        ApplyDnsSettings(gpol_nrpt || gpol_list);
     }
 }


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/837?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I576e74f3276362606e9cbd50bb5adbebaaf209cc
Gerrit-Change-Number: 837
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--Yg+GOeXS8Jg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>d12fk would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/837?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">win: implement --dns option support<br><br>Implement support =
for setting options from --dns. This is hugely<br>different than what we ha=
d so far with DNS related --dhcp-option.<br><br>The main difference it that=
 we support split DNS and DNSSEC by making<br>use of NRPT (Name Resolution =
Policy Table). Also OpenVPN tries to keep<br>local DNS resolution working w=
hen DNS is redirected into the tunnel. To<br>prevent this from happening we=
 have --block-outside-dns, in case you<br>wonder. Basically we collect doma=
ins and name server addresses from<br>network adapters and add so called ex=
clude NRPT rules in addition to the<br>catch all rule that is pushed by the=
 server.<br><br>All is done via the interactive service, since modifying al=
l this<br>requires the elevated privileges that the openvpn process hopeful=
ly<br>doesn&#39;t have.<br><br>Change-Id: I576e74f3276362606e9cbd50bb5adbeb=
aaf209cc<br>Signed-off-by: Heiko Hund &lt;heiko@...2662...&gt;<br>---<br>M =
include/openvpn-msg.h<br>M src/openvpn/dns.c<br>M src/openvpn/dns.h<br>M sr=
c/openvpn/init.c<br>M src/openvpnserv/interactive.c<br>5 files changed, 1,0=
96 insertions(+), 7 deletions(-)<br><br></pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.ne=
t:29418/openvpn refs/changes/37/837/1</pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;"><span>diff --git a/include/openvpn-=
msg.h b/include/openvpn-msg.h</span><br><span>index 7a99335..8b48053 100644=
</span><br><span>--- a/include/openvpn-msg.h</span><br><span>+++ b/include/=
openvpn-msg.h</span><br><span>@@ -35,6 +35,8 @@</span><br><span>     msg_de=
l_route,</span><br><span>     msg_add_dns_cfg,</span><br><span>     msg_del=
_dns_cfg,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg_ad=
d_nrpt_cfg,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg_=
del_nrpt_cfg,</span><br><span>     msg_add_nbt_cfg,</span><br><span>     ms=
g_del_nbt_cfg,</span><br><span>     msg_flush_neighbors,</span><br><span>@@=
 -96,6 +98,23 @@</span><br><span>     inet_address_t addr[4]; /* support up=
 to 4 dns addresses */</span><br><span> } dns_cfg_message_t;</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+typedef enum {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    nrpt_dnssec</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+} nrpt_flags_t;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#define NRPT_ADDR_NUM 8   /* Max. number of addresses */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#define NRPT_ADDR_SIZE 48 /* M=
ax. address strlen + some */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+typedef char nrpt_address_t[NRPT_ADDR_SIZE];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+typedef struct {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    message_header_t header;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    interface_t iface;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    nrpt_address_t addresses[NRP=
T_ADDR_NUM];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cha=
r resolve_domains[512]; /* double \0 terminated */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    char search_domains[512];</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    nrpt_flags_t flags;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+} nrpt_dns_cfg_message_t;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> typede=
f struct {</span><br><span>     message_header_t header;</span><br><span>  =
   interface_t iface;</span><br><span>diff --git a/src/openvpn/dns.c b/src/=
openvpn/dns.c</span><br><span>index e22ea00..4528a9c 100644</span><br><span=
>--- a/src/openvpn/dns.c</span><br><span>+++ b/src/openvpn/dns.c</span><br>=
<span>@@ -29,6 +29,12 @@</span><br><span> </span><br><span> #include &quot;=
dns.h&quot;</span><br><span> #include &quot;socket.h&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#include &quot;options.h&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#ifdef _WIN32</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#include &quot;win32.h&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;openvpn-msg.h&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </=
span><br><span> /**</span><br><span>  * Parses a string as port and stores =
it</span><br><span>@@ -428,6 +434,93 @@</span><br><span>     gc_free(&amp;g=
c);</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#ifdef _WIN32</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stat=
ic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+make_domain_=
list(const char *what, const struct dns_domain *src,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                 bool nrpt_domains, char =
*dst, size_t dst_size)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* NRPT dom=
ains need two \0 at the end for REG_MULTI_SZ</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * and a leading &#39;.&#39; added in front of=
 the domain name */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    size_t term_size =3D nrpt_domains ? 2 : 1;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    size_t leading_dot =3D nrpt_domains ? 1 : 0;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t offset =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    memset(dst, 0, dst_size);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    while (src)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        size_t len =3D strlen(src-&gt;name);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if (offset + leading_dot +=
 len + term_size &gt; dst_size)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            msg(M_WARN, &quot;WARNING: %s truncated&quot;, what);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            if (offset)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                /* Remove tra=
iling comma */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           *(dst + offset - 1) =3D &#39;\0&#39;;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            break;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if (leading_dot)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
*(dst + offset++) =3D &#39;.&#39;;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        strncpy(dst + offset, src-&gt;name, len);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        offset +=3D len;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        src =3D src-&gt;next;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        if (src)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            *(dst + offset++) =3D &#39;,&#39;;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+run_up_down_service(bool=
 add, const struct options *o, const struct tuntap *tt)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    const struct dns_server *server =3D o-&gt;dns_options=
.servers;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const =
struct dns_domain *search_domains =3D o-&gt;dns_options.search_domains;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ack_message_t ack;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    nrpt_dns_cfg_message_t nrpt =3D {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        .header =3D =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            (add ?=
 msg_add_nrpt_cfg : msg_del_nrpt_cfg),</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            sizeof(nrpt_dns_cfg_message_t),</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            0</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        },</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        .iface =3D { .index =3D tt-&gt;adapter_=
index, .name =3D &quot;&quot; },</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        .flags =3D server-&gt;dnssec =3D=3D DNS_SECURITY_NO ? =
0 : nrpt_dnssec,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    strncpynt(nr=
pt.iface.name, tt-&gt;actual_name, sizeof(nrpt.iface.name));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; NRPT_ADDR_NUM; ++i)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (server-&gt;addr[i].fami=
ly =3D=3D AF_UNSPEC)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   /* No more addresses */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            break;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (inet_ntop(s=
erver-&gt;addr[i].family, &amp;server-&gt;addr[i].in,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                      nrpt.addresses[i], =
NRPT_ADDR_SIZE) =3D=3D NULL)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           msg(M_WARN, &quot;WARNING: could not convert dns server address&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    make_domain_list(&quot;dns server resolve domains&q=
uot;, server-&gt;domains, true,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                     nrpt.resolve_domains, sizeof(nrpt.resolve_=
domains));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    make_domain_list(&quot;d=
ns search domains&quot;, search_domains, false,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                     nrpt.search_domains, sizeo=
f(nrpt.search_domains));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    send_msg_i=
service(o-&gt;msg_channel, &amp;nrpt, sizeof(nrpt), &amp;ack, &quot;DNS&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#endif /* _WIN32 */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span> void</span><br><span> show_dns_opt=
ions(const struct dns_options *o)</span><br><span> {</span><br><span>@@ -50=
6,3 +599,43 @@</span><br><span> </span><br><span>     gc_free(&amp;gc);</sp=
an><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+run_dns_up_down(bool up, struct option=
s *o, const struct tuntap *tt)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(!o-&gt;dns_options.servers)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Warn about adding servers of unsup=
ported AF */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st struct dns_server *s =3D o-&gt;dns_options.servers;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    while (up &amp;&amp; s)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        size_t bad_count =3D 0;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        for (size_t i =3D 0; i &lt=
; s-&gt;addr_count; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       if ((s-&gt;addr[i].family =3D=3D AF_INET6 &amp;&amp; !tt-&gt;did_ifc=
onfig_ipv6_setup)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              || (s-&gt;addr[i].family =3D=3D AF_INET &amp;&amp; !tt-&gt;di=
d_ifconfig_setup))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         ++bad_count;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (ba=
d_count =3D=3D s-&gt;addr_count)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            msg(M_WARN, &quot;DNS server %ld only has address(es) from a=
 family &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           &quot;the tunnel is not configured for - it will not be reachabl=
e&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     s-&gt;priority);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
else if (bad_count)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  msg(M_WARN, &quot;DNS server %ld has address(es) from a family &quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                &quot;t=
he tunnel is not configured for&quot;, s-&gt;priority);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        s =3D s-&gt;next;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#ifdef _WIN32</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
un_up_down_service(up, o, tt);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#endif /* ifdef _WIN32 */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span>diff --git a/src/openvpn/dns.h b/src/ope=
nvpn/dns.h</span><br><span>index 838ebe1..f24e30b 100644</span><br><span>--=
- a/src/openvpn/dns.h</span><br><span>+++ b/src/openvpn/dns.h</span><br><sp=
an>@@ -26,6 +26,7 @@</span><br><span> </span><br><span> #include &quot;buff=
er.h&quot;</span><br><span> #include &quot;env_set.h&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#include &quot;tun.h&quot;</span><br=
><span> </span><br><span> enum dns_security {</span><br><span>     DNS_SECU=
RITY_UNSET,</span><br><span>@@ -147,6 +148,14 @@</span><br><span> void dns_=
options_postprocess_pull(struct dns_options *o);</span><br><span> </span><b=
r><span> /**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Invo=
kes the action associated with bringing DNS up or down</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @param   up          Boolean to set t=
his call to &quot;up&quot; when true</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param   o           Pointer to the program options</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param   tt         =
 Pointer to the connection&#39;s tuntap struct</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+void run_dns_up_down(bool up, struct options *o, const struct tu=
ntap *tt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span>  * Puts=
 the DNS options into an environment set.</span><br><span>  *</span><br><sp=
an>  * @param   o           Pointer to the DNS options to set</span><br><sp=
an>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>ind=
ex 9371024..36a9bca 100644</span><br><span>--- a/src/openvpn/init.c</span><=
br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -2008,6 +2008,8 @@</sp=
an><br><span>                         c-&gt;c2.frame.tun_mtu, c-&gt;c2.es, =
&amp;c-&gt;net_ctx);</span><br><span>         }</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        run_dns_up_down(true,=
 &amp;c-&gt;options, c-&gt;c1.tuntap);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span>         /* run the up script */</span>=
<br><span>         run_up_down(c-&gt;options.up_script,</span><br><span>   =
                  c-&gt;plugins,</span><br><span>@@ -2046,6 +2048,8 @@</spa=
n><br><span>         /* explicitly set the ifconfig_* env vars */</span><br=
><span>         do_ifconfig_setenv(c-&gt;c1.tuntap, c-&gt;c2.es);</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+        run=
_dns_up_down(true, &amp;c-&gt;options, c-&gt;c1.tuntap);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         /* run the u=
p script if user specified --up-restart */</span><br><span>         if (c-&=
gt;options.up_restart)</span><br><span>         {</span><br><span>@@ -2134,=
6 +2138,8 @@</span><br><span>     adapter_index =3D c-&gt;c1.tuntap-&gt;ada=
pter_index;</span><br><span> #endif</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    run_dns_up_down(false, &amp;c-&gt;opt=
ions, c-&gt;c1.tuntap);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span>     if (force || !(c-&gt;sig-&gt;signal_received =3D=
=3D SIGUSR1 &amp;&amp; c-&gt;options.persist_tun))</span><br><span>     {</=
span><br><span>         static_context =3D NULL;</span><br><span>diff --git=
 a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c</span><br>=
<span>index 5042283..d5b7e5d 100644</span><br><span>--- a/src/openvpnserv/i=
nteractive.c</span><br><span>+++ b/src/openvpnserv/interactive.c</span><br>=
<span>@@ -24,6 +24,7 @@</span><br><span> </span><br><span> #include &quot;s=
ervice.h&quot;</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#include &lt;winerror.h&gt;</span><br><span> #include &lt;ws2t=
cpip.h&gt;</span><br><span> #include &lt;iphlpapi.h&gt;</span><br><span> #i=
nclude &lt;userenv.h&gt;</span><br><span>@@ -88,6 +89,7 @@</span><br><span>=
     wfp_block,</span><br><span>     undo_dns4,</span><br><span>     undo_d=
ns6,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    undo_nrpt,<=
/span><br><span>     undo_domains,</span><br><span>     undo_ring_buffer,</=
span><br><span>     undo_wins,</span><br><span>@@ -119,12 +121,20 @@</span>=
<br><span>     flush_neighbors_message_t flush_neighbors;</span><br><span> =
    wfp_block_message_t wfp_block;</span><br><span>     dns_cfg_message_t d=
ns;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    nrpt_dns_cfg=
_message_t nrpt_dns;</span><br><span>     enable_dhcp_message_t dhcp;</span=
><br><span>     register_ring_buffers_message_t rrb;</span><br><span>     s=
et_mtu_message_t mtu;</span><br><span>     wins_cfg_message_t wins;</span><=
br><span> } pipe_message_t;</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+typedef struct {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    CHAR addresses[NRPT_ADDR_NUM * NRPT_ADDR_SIZE];<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    WCHAR domains[51=
2]; /* MULTI_SZ string */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    DWORD domains_size; /* bytes in domains */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+} nrpt_exclude_data_t;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span> static DWORD</span><br><span> AddListIt=
em(list_item_t **pfirst, LPVOID data)</span><br><span> {</span><br><span>@@=
 -1946,6 +1956,903 @@</span><br><span>     return err;</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Checks if DHCP i=
s enabled for an interface</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param =
 key        HKEY of the interface to check for</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @return BOOL set to TRUE if DHCP is enabled, or FALSE if</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         disabled or an=
 error occurred</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+static BOOL</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+IsDhcpEnabled(HKEY key)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    DWORD dhcp;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    DWORD size =3D sizeof(dhcp);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    LSTATUS err;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    err =3D RegGetValueA(key, NULL, &quot;EnableDHCP&q=
uot;, RRF_RT_REG_DWORD, NULL, (PBYTE)&amp;dhcp, &amp;size);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (err !=3D NO_ERROR)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        MsgToEventLog(M_SYSERR, TEXT(&quo=
t;IsDhcpEnabled: &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                                     &quot;Could not read DHCP status (=
%lu)&quot;), err);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       return FALSE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return dhcp ? TRUE : FALSE;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * Set name servers from a NRPT address list</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @param itf_id        the VPN interface ID to set the name serv=
ers for</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param ad=
dresses     the list of NRPT addresses</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @return LSTATUS NO_ERROR in case of success, a Windows error code othe=
rwise</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+static LSTATUS</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+SetNameServerAddresses(PWSTR itf_id=
, const nrpt_address_t *addresses)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 const short families[] =3D { AF_INET, AF_INET6 };</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; _countof(famili=
es); i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        short family =3D=
 families[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Create a comma=
 sparated list of addresses of this family */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        int offset =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        char addr_list[NRPT_ADDR_SIZE * N=
RPT_ADDR_NUM];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   for (int j =3D 0; j &lt; NRPT_ADDR_NUM &amp;&amp; addresses[j][0]; j++)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            if ((family =3D=3D=
 AF_INET6 &amp;&amp; strchr(addresses[j], &#39;:&#39;) =3D=3D NULL)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                || (family =
=3D=3D AF_INET &amp;&amp; strchr(addresses[j], &#39;:&#39;) !=3D NULL))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                /* Address fa=
mily doesn&#39;t match, skip this one */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                continue;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            if (offset)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                addr_list[offset++] =3D &#39;,&#39;;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            strcpy(addr_list =
+ offset, addresses[j]);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            offset +=3D strlen(addresses[j]);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        if (offset =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            /* No address for this family to set */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            continue;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        /* Set name server addresses */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        LSTATUS err =3D SetNameServers(itf_id, f=
amily, addr_list);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (err)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            re=
turn err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    return NO_ERROR;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Get DNS =
server IPv4 addresses of an interface</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * @param  itf_key    registry key of the IPv4 interface data</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @param  addrs      pointer to=
 the buffer addresses are returned in</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @param  size       pointer to the size of the buffer, =
contains the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *     =
               size of the addresses on return</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @return LSTATUS NO_ERROR on success, a Windows error code othe=
rwise</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+static LSTATUS</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+GetItfDnsServersV4(HKEY itf_key, PS=
TR addrs, PDWORD size)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    addrs[*size=
 - 1] =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    LSTATUS err=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD s =3D *s=
ize;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    err =3D Reg=
GetValueA(itf_key, NULL, &quot;NameServer&quot;, RRF_RT_REG_SZ, NULL, (PBYT=
E)addrs, &amp;s);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (err &amp;&amp; err !=3D ERROR_FILE_NOT_FOUND)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        *size =3D 0;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        return err;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Try D=
HCP addresses if we don&#39;t have some already */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (!strchr(addrs, &#39;.&#39;) &amp;&am=
p; IsDhcpEnabled(itf_key))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 s =3D *size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  RegGetValueA(itf_key, NULL, &quot;DhcpNameServer&quot;, RRF_RT_REG_SZ, NU=
LL, (PBYTE)addrs, &amp;s);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (err)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      *size =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           return err;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (strchr(addrs, &#39;.&#39;))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        *size =3D s;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        return NO_ERROR;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    *size =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    return ERROR_FILE_NOT_FOUND;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * Get DNS server IPv6 addresses =
of an interface</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  itf_key   =
 registry key of the IPv6 interface data</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param  addrs      pointer to the buffer addresses =
are returned in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
param  size       pointer to the size of the buffer</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @return LSTATUS NO_ERROR on success, a Windows error co=
de otherwise</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+static LSTATUS</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+GetItfDnsServersV6(HKEY itf_=
key, PSTR addrs, PDWORD size)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    addr=
s[*size - 1] =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    LSTA=
TUS err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD s=
 =3D *size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    err =
=3D RegGetValueA(itf_key, NULL, &quot;NameServer&quot;, RRF_RT_REG_SZ, NULL=
, (PBYTE)addrs, &amp;s);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (err &amp;&amp; err !=3D ERROR_FILE_NOT_FOUND)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        *size =3D 0;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        return err;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =
Try DHCP addresses if we don&#39;t have some already */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (!strchr(addrs, &#39;:&#39;) &am=
p;&amp; IsDhcpEnabled(itf_key))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      IN6_ADDR in_addrs[8];</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        DWORD in_addrs_size =3D sizeof(in_addrs);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        err =3D RegGetValueA(itf_key,=
 NULL, &quot;Dhcpv6DNSServers&quot;, RRF_RT_REG_BINARY, NULL,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                           (PBYTE=
)in_addrs, &amp;in_addrs_size);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        if (err)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           *size =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            return err;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        s =3D *size;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        PSTR pos =3D=
 addrs;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        size=
_t in_addrs_read =3D in_addrs_size / sizeof(IN6_ADDR);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        for (size_t i =3D 0; i &lt; in_a=
ddrs_read; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if=
 (i !=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  /* Add separator */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                *pos++ =3D &#39;,&#39;;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                s--;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          if (inet_ntop(AF_INET6, &amp;in_addrs[i],</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                          pos, s) !=3D NU=
LL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                *size =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   return ERROR_MORE_DATA;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            size_t=
 addr_len =3D strlen(pos);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            pos +=3D addr_len;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            s -=3D addr_len;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        s =3D strlen(addrs) + 1;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (strchr(addrs, &#39;:&#39;))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       *size =3D s;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        return NO_ERROR;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    *size =3D 0;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    return ERROR_FILE_NOT_FOUND=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * Return interface specific domain suffix(es)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * The \p domains paramter will be set to a MULTI_SZ domains =
string.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * In case o=
f an error or if no domains are found for the interface</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * \p size is set to 0 and the contents=
 of \p domains are invalid.</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * Note that the domains could have been set by DHCP or manually.</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @param  itf        HKEY of the inte=
rface to read from</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @param  domains    PWSTR buffer to return the domain(s) in</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @param  size       pointer to s=
ize of the domains buffer in bytes. Will be</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *                    set to the size of the string=
 returned, including</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *                    the terminating zeros or 0.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @return LSTATUS NO_ERROR if the domain suffix(es) were rea=
d successfully,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
       ERROR_FILE_NOT_FOUND if no domain was found for the interface,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         ERROR_MORE_DAT=
A if the list did not fit into the buffer,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *         any other error indicates an error while =
reading from the registry.</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static LS=
TATUS</span><br><span style=3D"color: hsl(120, 100%, 40%);">+GetItfDnsDomai=
ns(HKEY itf, PWSTR domains, PDWORD size)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (domains =3D=3D NULL || size =3D=3D 0)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        return ERROR_INVALID_PARAMETER;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    LSTATUS err =3D ERROR_FILE_NOT_FOUND;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    const DWORD buf_size =3D *size;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    const size_t one_glyph =3D size=
of(*domains);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    PW=
STR values[] =3D { L&quot;SearchList&quot;, L&quot;Domain&quot;, L&quot;Dhc=
pDomainSearchList&quot;, L&quot;DhcpDomain&quot;, NULL};</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    for (int i =3D 0; values[i]; i++)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        err =3D RegGetValueW(itf, NULL, values[i], RR=
F_RT_REG_SZ, NULL, (PBYTE)domains, size);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if (!err &amp;&amp; *size &gt; one_glyph &amp=
;&amp; wcschr(domains, &#39;.&#39;))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            /*</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+             * Found domain(s), now convert them:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+             *   - prefix each domain wit=
h a dot</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
 *   - convert comma separated list to MULTI_SZ</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+             */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            PWCHAR pos =3D domains;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            const DWORD buf_len =3D=
 buf_size / one_glyph;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            while (TRUE)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                /* Terminate the domain at the next comma */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                PWCHAR comma =3D=
 wcschr(pos, &#39;,&#39;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                if (comma)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                    *comma =3D &#39;\0&#39;;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                /* Check for enough space to convert this d=
omain */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     size_t converted_size =3D pos - domains;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                size_t domain_len =3D wcslen(pos)=
 + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  size_t domain_size =3D domain_len * one_glyph;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                size_t extra_size =3D 2 * one_=
glyph;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   if (converted_size + domain_size + extra_size &gt; buf_size)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                    /* Domain doe=
sn&#39;t fit, bad luck if it&#39;s the first one */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    *pos =3D &#39;\0&#39;=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
  *size =3D converted_size =3D=3D 0 ? 0 : *size + 1;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    return ERROR_MORE_DAT=
A;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                /* Prefix domain at po=
s with the dot */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              memmove(pos + 1, pos, buf_size - converted_size - one_glyph);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                dom=
ains[buf_len - 1] =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                *pos =3D &#39;.&#39;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                *size +=3D 1;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                if (!comma)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    /* Conversion is done=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
    *(pos + domain_len) =3D &#39;\0&#39;;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                    *size +=3D 1;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                    return NO_ERROR;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                pos =3D comma + 1;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    *size =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Check if an interface is connected and up</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @param  iid_str    the interface GUID as strin=
g</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * @return TRUE if the interface is=
 connected and up, FALSE otherwise or in</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *         case an error happened</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+static BOOL</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+IsInterfaceConnected(PWSTR iid_str)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    GUID iid;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    BOOL res =3D FALSE;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    MIB_IF_ROW2 itf_row;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =
Get LUID from GUID string */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (IIDFromString(iid_str, &amp;iid) !=3D S_OK</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        || ConvertInterfaceGuidToLu=
id(&amp;iid, &amp;itf_row.InterfaceLuid) !=3D NO_ERROR)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        MsgToEventLog(M_SYSERR, TEXT(&quot;IsInterfac=
eConnected: &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                                    &quot;could not convert interface %s GU=
ID to LUID&quot;), iid_str);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        goto out;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Look up interface s=
tatus */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (Get=
IfEntry2(&amp;itf_row) !=3D NO_ERROR)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        MsgToEventLog(M_SYSERR, TEXT(&quot;IsInterfaceConnected: &quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
                  &quot;could not get interface %s status&quot;), iid_str);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto out;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (itf_row.MediaConnectState =3D=3D MediaConnectS=
tateConnected</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  &amp;&amp; itf_row.OperStatus =3D=3D IfOperStatusUp)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        res =3D TRUE;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+out:</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return res;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Coll=
ect interface DNS settings to be used in excluding NRPT rules. This is</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * needed so that local =
DNS keeps working even when a catch all NRPT rule is</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * installed by a VPN connection.</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * @param  data       pointer to the data st=
ructures the values are returned in</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * @param  data_size  number of exclude data structures poi=
nted to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+GetNrptExcludeData(nrpt_exclude_data=
_t *data, size_t data_size)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    HKEY v=
4_itfs =3D INVALID_HANDLE_VALUE;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    HKEY v6_itfs =3D INVALID_HANDLE_VALUE;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (!GetInterfacesKey(AF_INET, &amp;v4_itfs)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        || !GetInterfacesKey(=
AF_INET6, &amp;v6_itfs))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        g=
oto out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    size_t i =3D 0;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    DWORD enum_index =3D 0;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    while (i &lt; data_size)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        WCHAR itf_guid[MAX_PATH];</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        DWORD itf_guid_len =
=3D _countof(itf_guid);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        LSTATUS err =3D RegEnumKeyExW(v4_itfs, enum_index++, itf_guid, =
&amp;itf_guid_len,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                                   NULL, NULL, NULL, NULL);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (err)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            if (err !=3D ERROR_NO_MORE_ITEMS)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                MsgToEventLo=
g(M_SYSERR, TEXT(&quot;GetNrptExcludeData: &quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                                             =
&quot;could not enumerate interfaces (%lu)&quot;), err);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            goto out;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        /* Ignore interfaces that are not connected or disabled */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!IsInterfac=
eConnected(itf_guid))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    continue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        HKEY v4_itf;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if (RegOpenKeyExW(v4_itfs,=
 itf_guid, 0, KEY_READ, &amp;v4_itf) !=3D NO_ERROR)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            MsgToEventLog(M_SYSERR, TEXT(&quot;GetN=
rptExcludeData: &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                                         &quot;could not open interface =
%s v4 registry key&quot;), itf_guid);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            goto out;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /=
* Get the DNS domain(s) for exclude routing */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        data[i].domains_size =3D sizeof(data[0].=
domains);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        me=
mset(data[i].domains, 0, data[i].domains_size);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        err =3D GetItfDnsDomains(v4_itf, data[i=
].domains, &amp;data[i].domains_size);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        if (err)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            if (err !=3D ERROR_FILE_NOT_FOUND)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                MsgToEventLog(M_SYSERR, TEXT(&q=
uot;GetNrptExcludeData: &quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                                             &quot;could not rea=
d interface %s domain suffix&quot;), itf_guid);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            goto next_itf;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        /* Get the IPv4 DNS servers */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        DWORD v4_addrs_size =3D sizeof(data[0].addresses=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        err =3D G=
etItfDnsServersV4(v4_itf, data[i].addresses, &amp;v4_addrs_size);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if (err &amp;&amp; er=
r !=3D ERROR_FILE_NOT_FOUND)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           MsgToEventLog(M_SYSERR,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                          TEXT(&quot;GetNrptExcludeData: cou=
ld not read interface %s v4 name servers (%ld)&quot;),</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                          itf_guid, err)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            goto n=
ext_itf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        /* Get the IPv6 DNS servers, if =
there&#39;s space left */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        PSTR v6_addrs =3D data[i].addresses + v4_addrs_size;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        DWORD v6_addrs_size =
=3D sizeof(data[0].addresses) - v4_addrs_size;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (v6_addrs_size &gt; NRPT_ADDR_SIZE)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            HKEY v6_itf;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            if (RegOpenKey=
ExW(v6_itfs, itf_guid, 0, KEY_READ, &amp;v6_itf) !=3D NO_ERROR)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                MsgToEventLog(M_SYSER=
R, TEXT(&quot;GetNrptExcludeData: &quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                                             &quot;cou=
ld not open interface %s v6 registry key&quot;), itf_guid);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                goto next_itf;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            err =3D GetItfDnsS=
erversV6(v6_itf, v6_addrs, &amp;v6_addrs_size);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            RegCloseKey(v6_itf);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            if (err &amp;&amp; err=
 !=3D ERROR_FILE_NOT_FOUND)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                MsgToEventLog(M_SYSERR,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                              TEXT(&quot;GetNrptExclu=
deData: could not read interface %s v6 name servers (%ld)&quot;),</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                             =
 itf_guid, err);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             goto next_itf;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if (v4_addrs_size |=
| v6_addrs_size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /=
* Replace comma-delimters with semicolons, as required by NRPT */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            for (int j =3D 0;=
 j &lt; sizeof(data[0].addresses) &amp;&amp; data[i].addresses[j]; j++)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                if (data[i].a=
ddresses[j] =3D=3D &#39;,&#39;)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                    data[i].addresses[j] =3D &#39;;&#39;;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            ++i;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+next_itf:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      RegCloseKey(v4_itf);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+out:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    RegCloseKey(v6_itfs);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    RegCloseKey(v4_itfs);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Set =
a NRPT rule (subkey) and its values in the registry</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param  nrpt_key   NRPT registry key handle</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @param  subkey     subkey st=
ring to create</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p=
aram  address    name server address string</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @param  domains    domains to resolve by this se=
rver as MULTI_SZ</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
@param  dom_size   size of domains in bytes including the terminators</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  dnssec     boo=
lean to determine if DNSSEC is to be enabled</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @return NO_ERROR on success, or Windows error code</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static DWORD</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+SetNrptRule(HKEY nrpt_key, PCWSTR subkey, PCSTR address,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            PCWSTR =
domains, DWORD dom_size, BOOL dnssec)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* Create rule subkey */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    DWORD err =3D NO_ERROR;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    HKEY rule_key;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    err =3D RegCreateKeyExW(nrpt_key, subkey, 0, NULL, 0, K=
EY_ALL_ACCESS, NULL, &amp;rule_key, NULL);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (err)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        return err;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /* Set name(s) for DNS rout=
ing */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    err =3D R=
egSetValueExW(rule_key, L&quot;Name&quot;, 0, REG_MULTI_SZ, (PBYTE)domains,=
 dom_size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
err)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        goto out;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* Set DNS Server address */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    err =3D RegSetValueExA(rule_key, &quot;GenericD=
NSServers&quot;, 0, REG_SZ, (PBYTE)address, strlen(address) + 1);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (err)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        goto out;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD =
reg_val;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Set =
DNSSEC if required */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (dnssec)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        reg_val =
=3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        err =
=3D RegSetValueExA(rule_key, &quot;DNSSECValidationRequired&quot;, 0, REG_D=
WORD, (PBYTE)&amp;reg_val, sizeof(reg_val));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if (err)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            goto out;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        reg_val=
 =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        err =
=3D RegSetValueExA(rule_key, &quot;DNSSECQueryIPSECRequired&quot;, 0, REG_D=
WORD, (PBYTE)&amp;reg_val, sizeof(reg_val));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if (err)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            goto out;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        reg_val=
 =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        err =
=3D RegSetValueExA(rule_key, &quot;DNSSECQueryIPSECEncryption&quot;, 0, REG=
_DWORD, (PBYTE)&amp;reg_val, sizeof(reg_val));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (err)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            goto out;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Set NRPT config opti=
ons */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    reg_val =
=3D dnssec ? 0x0000000A : 0x00000008;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    err =3D RegSetValueExA(rule_key, &quot;ConfigOptions&=
quot;, 0, REG_DWORD, (const PBYTE)&amp;reg_val, sizeof(reg_val));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (err)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        goto out;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Man=
datory NRPT version */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    reg_val =3D 2;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    err =3D RegSetValueExA(rule_key, &quot;Version&quot;, 0, REG_DWORD, (=
const PBYTE)&amp;reg_val, sizeof(reg_val));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (err)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        goto out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+out:</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (err)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        RegDeleteKeyW(nrpt_key, subkey);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    RegCloseKey(rule_key);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    return err;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * Set NRPT exclude rules to accompa=
ny a catch all rule. This is done so that</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * local resolution of names is not interfered with i=
n case the VPN resolves</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * all names.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  nrpt_key=
   the registry key to set the rules under</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param  ovpn_pid   the PID of the openvpn process=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+SetNrptExcludeRules(HKEY nrpt_key, DWORD =
ovpn_pid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    nrpt_exclude_data_t data=
[8]; /* data from up to 8 interfaces */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    memset(data, 0, sizeof(data));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    GetNrptExcludeData(data, _countof(da=
ta));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    unsigned n =3D 0;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; _c=
ountof(data); ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        DWORD e=
rr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        WCHAR su=
bkey[48];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sw=
printf(subkey, _countof(subkey), L&quot;OpenVPNDNSRoutingX-%02x-%lu&quot;, =
++n, ovpn_pid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        nrpt_exclude_da=
ta_t *d =3D &amp;data[i];</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        err =3D SetNrptRule(nrpt_key, subkey, d-&gt;addresses, d-&gt;=
domains, d-&gt;domains_size, FALSE);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (err)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            MsgToEventLog(M_ERR, TEXT(&quot;SetNrptExcludeRules: &quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
                   &quot;failed to set rule %s (%lu)&quot;), subkey, err);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Set NRPT rules for =
a openvpn process</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  nrpt_key=
   the registry key to set the rules under</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param  addresses  name server addresses</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  domains    option=
al list of split routing domains</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @param  dnssec     boolean whether DNSSEC is to be used</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  ovpn_pid   t=
he PID of the openvpn process</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @ret=
urn NO_ERROR on success, or a Windows error code</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+static DWORD</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+SetNrptRules(HKEY nrpt_key, const nrpt_address_t *addresses,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+             const char *dom=
ains, BOOL dnssec, DWORD ovpn_pid)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 DWORD err =3D NO_ERROR;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    PWSTR wide_domains =3D L&quot;.\0&quot;; /* DNS route everything b=
y default */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWO=
RD dom_size =3D 6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Prepare DNS r=
outing domains / split DNS */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (domains[0])</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    size_t domains_len =3D strlen(domains);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        dom_size =3D domains_len + 2; /* len + the =
trailing NULs */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        wide_domains =
=3D utf8to16_size(domains, dom_size);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        dom_size *=3D sizeof(*wide_domains);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if (!wide_domains)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            return ERROR_OUTOFMEMOR=
Y;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Make a MULTI_SZ =
from a comma separated list */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        for (size_t i =3D 0; i &lt; domains_len; ++i)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            if (wide_domains[i] =3D=3D &=
#39;,&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  wide_domains[i] =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        SetNrptExcludeRules(nrpt_key, ovpn_pid);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* Create address string list */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    CHAR addr_list[NRPT_ADDR_NUM * NR=
PT_ADDR_SIZE];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    P=
STR pos =3D addr_list;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    for (int i =3D 0; i &lt; NRPT_ADDR_NUM &amp;&amp; addresses[i][0]; +=
+i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if (i !=3D 0)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            *pos++ =3D &#39;;&#39;;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        strcpy(pos, addresses[i]=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        pos +=3D =
strlen(pos);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    WCHAR subkey[MAX_PATH];</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    swprintf(subkey, _countof(su=
bkey), L&quot;OpenVPNDNSRouting-%lu&quot;, ovpn_pid);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    err =3D SetNrptRule(nrpt_key, subkey,=
 addr_list, wide_domains, dom_size, dnssec);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (err)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        MsgToEventLog(M_ERR, TEXT(&quot;SetNrptRules: &quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                              =
    &quot;failed to set rule %s (%lu)&quot;), subkey, err);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    free(wide_domains);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    return err;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * Return the registry key where NRPT rules ar=
e stored</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  key        pointe=
r to the HKEY it is returned in</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param  gpol       pointer to BOOL the use of GPOL hive is r=
eturned in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return NO_ERROR on suc=
cess, or a Windows error code</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static=
 LSTATUS</span><br><span style=3D"color: hsl(120, 100%, 40%);">+OpenNrptBas=
eKey(PHKEY key, PBOOL gpol)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     * Registry keys Na=
me Service Policy Table (NRPT) rules can be stored at.</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * When the group policy key exists,=
 NRPT rules must be placed there.</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     * It is created when NRPT rules are pushed via group pol=
icy and it</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * re=
mains in the registry even if the last GP-NRPT rule is deleted.</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    static PCSTR gpol_key =3D &quot;SOFTW=
ARE\\Policies\\Microsoft\\Windows NT\\DNSClient\\DnsPolicyConfig&quot;;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    static PCSTR sys_ke=
y =3D &quot;SYSTEM\\CurrentControlSet\\Services\\Dnscache\\Parameters\\DnsP=
olicyConfig&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    HKEY nrpt;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    *gpol =3D TRUE;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    LSTATUS err =3D RegOp=
enKeyExA(HKEY_LOCAL_MACHINE, gpol_key, 0, KEY_ALL_ACCESS, &amp;nrpt);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (err =3D=3D ERROR_=
FILE_NOT_FOUND)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *gpol =3D =
FALSE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        err =
=3D RegOpenKeyExA(HKEY_LOCAL_MACHINE, sys_key, 0, KEY_ALL_ACCESS, &amp;nrpt=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (err)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            nrpt =3D INVALID_H=
ANDLE_VALUE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    *key =3D nrpt;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return err;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Delete Open=
VPN NRPT rules from the registry</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * I=
f the pid parameter is 0 all NRPT rules added by OpenVPN are deleted.</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * In all other cases onl=
y rules matching the pid are deleted.</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * @param  pid        PID of the process to delete the rules for or 0</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  gpol</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @return BOOL to indicate if rules were del=
eted</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+static BOOL</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+DeleteNrptRules(DWORD pid, PBOOL gpol)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    HKEY key;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    LSTATUS err =3D OpenNrptBaseKey(&amp;key=
, gpol);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (err=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        MsgToEventLog(M_SYSERR, =
TEXT(&quot;DeleteNrptRules: &quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                                     &quot;could not open NR=
PT base key (%lu)&quot;), err);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        return FALSE;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* PID suffix s=
tring to compare against later */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    WCHAR pid_str[16];</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    size_t pidlen =3D 0;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (pid)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        swprintf(pid_str, _countof(pid_str), L&quot;-%lu&quot;, pid);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        pidlen =3D wcsle=
n(pid_str);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int deleted =3D 0;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    DWORD enum_index =3D 0;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    while (TRUE)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        WCHAR name[MAX_PATH];</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        DWORD namelen =3D _countof(na=
me);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        err =3D=
 RegEnumKeyExW(key, enum_index++, name, &amp;namelen, NULL, NULL, NULL, NUL=
L);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (err)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            if (err !=3D ERRO=
R_NO_MORE_ITEMS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       MsgToEventLog(M_SYSERR, TEXT(&quot;DeleteNrptRules: &quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                             =
                &quot;could not enumerate NRPT rules (%lu)&quot;), err);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            break;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        /* Keep rule if name doesn&#39;t match */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if (wcsncmp(name, L&=
quot;OpenVPNDNSRouting&quot;, 17) !=3D 0</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            || (pid &amp;&amp; wcsncmp(name + namelen =
- pidlen, pid_str, pidlen) !=3D 0))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            continue;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (RegDelete=
KeyW(key, name) =3D=3D NO_ERROR)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            enum_index--;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            deleted++;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    RegCloseKey(key);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    return deleted ? TRUE : F=
ALSE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * Delete a process&#39; NRPT rules and apply the reduced set of ru=
les</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param ovpn_pid  OpenVPN proce=
ss id to delete rules for</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static voi=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+UndoNrptRules(DWOR=
D ovpn_pid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    BOOL gpol;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (DeleteNrptRules(ovpn_pi=
d, &amp;gpol))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ApplyDnsSet=
tings(gpol);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * Add Name Resolution Policy Table (NRPT) rules as documented in</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * https://msdn.microsoft.co=
m/en-us/library/ff957356.aspx for DNS name</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * resolution, as well as DNS search domain(s), if g=
iven.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @param  msg        config me=
ssages sent by the openvpn process</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * @param  ovpn_pid   process id of the sending openvpn proc=
ess</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  lists=
      undo lists for this process</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
@return NO_ERROR on success, or a Windows error code</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static DWORD</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+HandleDNSConfigNrptMessage(const nrpt_dns_cfg_message_t *msg,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
     DWORD ovpn_pid, undo_lists_t *lists)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * Us=
e a non-const reference with limited scope to</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     * enforce null-termination of strings from c=
lient</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        nrpt_dns_cfg_message_t *msgptr =
=3D (nrpt_dns_cfg_message_t *) msg;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        msgptr-&gt;iface.name[_countof(msg-&gt;iface.name) =
- 1] =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        msgptr-&gt;search_domains[_countof(msg-&gt;search_domains) - 1] =
=3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      msgptr-&gt;resolve_domains[_countof(msg-&gt;resolve_domains) - 1] =3D=
 &#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   for (size_t i =3D 0; i &lt; NRPT_ADDR_NUM; ++i)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            msgptr-&gt;addresses[i][_countof(msg-&gt;a=
ddresses[0]) - 1] =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Make sure we have th=
e VPN interface name */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (msg-&gt;iface.name[0] =3D=3D 0)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        return ERROR_MESSAGE_DATA;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* S=
ome sanity checks on the add message data */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (msg-&gt;header.type =3D=3D msg_add_nrpt_cf=
g)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        /* At least one name se=
rver address is set */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if (msg-&gt;addresses[0][0] =3D=3D 0)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            return ERROR_MESSAGE_DATA;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        /* Resolve domains are double zero term=
inated (MULTI_SZ) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        const char *rdom =3D msg-&gt;resolve_domains;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        size_t rdom_size =3D sizeof(msg-=
&gt;resolve_domains);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        size_t rdom_len =3D strlen(rdom);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if (rdom_len &amp;&amp; (rdom_len + 1 &gt;=
=3D rdom_size || rdom[rdom_len + 2] !=3D 0))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            return ERROR_MESSAGE_DATA;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    BOOL =
gpol_nrpt =3D FALSE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    BOOL gpol_list =3D FALSE;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    WCHA=
R iid[64];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD=
 iid_err =3D InterfaceIdString(msg-&gt;iface.name, iid, sizeof(iid));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (iid_err)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return iid_err;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /* Delete previously set values for this instance first, if any */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    PDWORD undo_pid=
 =3D RemoveListItem(&amp;(*lists)[undo_nrpt], CmpAny, NULL);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (undo_pid)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if (*undo_pid !=3D ovpn_pid)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            MsgToEventLog(M_INFO, TEXT(&q=
uot;HandleDNSConfigNrptMessage: &quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                                       &quot;PID stored =
for undo doesn&#39;t match: %lu vs %lu. &quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                                       &quot;Thi=
s is likely an error. Cleaning up anyway.&quot;),</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                          *undo_pid, ovpn_pid=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        DeleteNrptRules(*un=
do_pid, &amp;gpol_nrpt);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        free(undo_pid);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        Re=
setNameServers(iid, AF_INET);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        ResetNameServers(iid, AF_INET6);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    SetDnsSearchDomains(msg-&gt;iface.name, NULL, &amp;gpo=
l_list, lists);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (msg-&gt;header.=
type =3D=3D msg_del_nrpt_cfg)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    ApplyDnsSettings(gpol_nrpt || gpol_list);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        return NO_ERROR; /* Done dealing with del=
 message */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    HKEY key;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    LSTATUS err =3D OpenNrptBaseKey(&amp;key, &=
amp;gpol_nrpt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (err)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto out;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* Add undo information first in case there&#39;s no hea=
p left */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    PDWORD=
 pid =3D malloc(sizeof(ovpn_pid));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (!pid)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   err =3D ERROR_OUTOFMEMORY;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        goto out;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *p=
id =3D ovpn_pid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (AddListItem(&amp;(*lists)[undo_nrpt], pid))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        err =3D ERROR_OUTOFMEMORY;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        free(pid);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        goto out;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
 Set NRPT rules */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   BOOL dnssec =3D (msg-&gt;flags &amp; nrpt_dnssec) !=3D 0;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    err =3D SetNrptRules(key, msg-=
&gt;addresses, msg-&gt;resolve_domains, dnssec, ovpn_pid);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (err)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        goto out;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Set name=
 servers */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    err =
=3D SetNameServerAddresses(iid, msg-&gt;addresses);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (err)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        goto out;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Set search doma=
ins, if any */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (msg-&gt;search_domains[0])</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    err =3D SetDnsSearchDomains(msg-&gt;iface.name, msg-&gt;search_domains,=
 &amp;gpol_list, lists);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    ApplyDnsSettings(gpol_nr=
pt || gpol_list);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+out:</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    return err;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span> static DWORD</span><br><span> HandleWINS=
ConfigMessage(const wins_cfg_message_t *msg, undo_lists_t *lists)</span><br=
><span> {</span><br><span>@@ -2201,7 +3108,7 @@</span><br><span> }</span><b=
r><span> </span><br><span> static VOID</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-HandleMessage(HANDLE pipe, HANDLE ovpn_proc,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+HandleMessage(HANDLE pipe, PPROCE=
SS_INFORMATION proc_info,</span><br><span>               DWORD bytes, DWORD=
 count, LPHANDLE events, undo_lists_t *lists)</span><br><span> {</span><br>=
<span>     pipe_message_t msg;</span><br><span>@@ -2264,6 +3171,14 @@</span=
><br><span>             ack.error_number =3D HandleDNSConfigMessage(&amp;ms=
g.dns, lists);</span><br><span>             break;</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        case msg_add_nrpt_=
cfg:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case ms=
g_del_nrpt_cfg:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            DW=
ORD ovpn_pid =3D proc_info-&gt;dwProcessId;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            ack.error_number =3D HandleDNSConfigNrp=
tMessage(&amp;msg.nrpt_dns, ovpn_pid, lists);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        break;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span>         case msg_add_wins_cfg:</span><br><span=
>         case msg_del_wins_cfg:</span><br><span>             ack.error_num=
ber =3D HandleWINSConfigMessage(&amp;msg.wins, lists);</span><br><span>@@ -=
2279,7 +3194,8 @@</span><br><span>         case msg_register_ring_buffers:<=
/span><br><span>             if (msg.header.size =3D=3D sizeof(msg.rrb))</s=
pan><br><span>             {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                ack.error_number =3D HandleRegisterRingBuffers(&amp;=
msg.rrb, ovpn_proc, lists);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                HANDLE ovpn_hnd =3D proc_info-&gt;hProcess;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                ack.error_n=
umber =3D HandleRegisterRingBuffers(&amp;msg.rrb, ovpn_hnd, lists);</span><=
br><span>             }</span><br><span>             break;</span><br><span=
> </span><br><span>@@ -2330,6 +3246,8 @@</span><br><span>                  =
   ResetNameServers(item-&gt;data, AF_INET6);</span><br><span>             =
        break;</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                case undo_nrpt:</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                    UndoNrptRules(*(PDWORD)item-&g=
t;data);</span><br><span>                     break;</span><br><span> </spa=
n><br><span>                 case undo_domains:</span><br><span>@@ -2653,7 =
+3571,7 @@</span><br><span>             break;</span><br><span>         }</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   HandleMessage(ovpn_pipe, proc_info.hProcess, bytes, 1, &amp;exit_event, =
&amp;undo_lists);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      HandleMessage(ovpn_pipe, &amp;proc_info, bytes, 1, &amp;exit_event, &=
amp;undo_lists);</span><br><span>     }</span><br><span> </span><br><span> =
    WaitForSingleObject(proc_info.hProcess, IO_TIMEOUT);</span><br><span>@@=
 -2849,24 +3767,28 @@</span><br><span> static void</span><br><span> Cleanup=
Registry()</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    HKEY key;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    DWORD changed =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    BOOL changed =3D FALSE;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
 Clean up leftover NRPT rules */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    BOOL gpol_nrpt;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    changed =3D DeleteNrptRules(0, &amp;gpol_nrpt);</span><br>=
<span> </span><br><span>     /* Clean up leftover DNS search list fragments=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    HKEY key;</s=
pan><br><span>     BOOL gpol_list;</span><br><span>     GetDnsSearchListKey=
(NULL, &amp;gpol_list, &amp;key);</span><br><span>     if (key !=3D INVALID=
_HANDLE_VALUE)</span><br><span>     {</span><br><span>         if (ResetDns=
SearchDomains(key))</span><br><span>         {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            changed++;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            changed =3D TRUE;</span><br><span> =
        }</span><br><span>         RegCloseKey(key);</span><br><span>     }=
</span><br><span> </span><br><span>     if (changed)</span><br><span>     {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ApplyDnsSetti=
ngs(gpol_list);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    ApplyDnsSettings(gpol_nrpt || gpol_list);</span><br><span>     }</span>=
<br><span> }</span><br><span> </span><br><span></span><br></pre><p>To view,=
 visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/837?usp=3Demail">ch=
ange 837</a>. To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/837?usp=3Demail"/><meta itemprop=3D"=
name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I576e74f3276362606e9cbd50bb5=
adbebaaf209cc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 837 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--Yg+GOeXS8Jg=--

