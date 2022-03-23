From: Heiko Hund <heiko@...2662...>
Date: Wed, 23 Mar 2022 15:34:52 +0100
Message-Id: <20220323143452.1100446-1-heiko@...2662...>
In-Reply-To: <20220308230621.1532809-1-heiko@...2662...>
References: <20220308230621.1532809-1-heiko@...2662...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] add support for --dns option
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

As a first step towards DNS configuration in openvpn and a unified way
to push DNS related settings to clients in v2 and v3, this commit adds
support for parsing the new --dns option. Later commits will add support
for setting up DNS on different platforms.

For now, --dns and DNS related --dhcp-option can be used together for
smoother transition. Settings from --dns will override ones --dhcp-option
where applicable.

For detailed information about the option consult the documentation in
this commit.

Signed-off-by: Heiko Hund <heiko@...2662...>
---
 doc/man-sections/client-options.rst |  59 ++++
 doc/man-sections/script-options.rst |  19 ++
 doc/man-sections/server-options.rst |   2 +-
 src/openvpn/Makefile.am             |   1 +
 src/openvpn/dns.c                   | 510 ++++++++++++++++++++++++++++
 src/openvpn/dns.h                   | 164 +++++++++
 src/openvpn/openvpn.vcxproj         |   4 +-
 src/openvpn/openvpn.vcxproj.filters |   8 +-
 src/openvpn/options.c               | 221 ++++++++++++
 src/openvpn/options.h               |   7 +
 src/openvpn/push.c                  |   4 +
 src/openvpn/socket.c                |  11 +
 src/openvpn/socket.h                |   2 +
 13 files changed, 1009 insertions(+), 3 deletions(-)
 create mode 100644 src/openvpn/dns.c
 create mode 100644 src/openvpn/dns.h

diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-options.rst
index e53b5262..8e0e4f18 100644
--- a/doc/man-sections/client-options.rst
+++ b/doc/man-sections/client-options.rst
@@ -154,6 +154,65 @@ configuration.
 --connect-timeout n
   See ``--server-poll-timeout``.
 
+--dns args
+  Client DNS configuration to be used with the connection.
+
+  Valid syntaxes:
+  ::
+
+     dns search-domains domain [domain ...]
+     dns server n address addr[:port] [addr[:port]]
+     dns server n resolve-domains|exclude-domains domain [domain ...]
+     dns server n dnssec yes|optional|no
+     dns server n transport DoH|DoT|plain
+     dns server n sni server-name
+
+  The ``--dns search-domains`` directive takes one or more domain names
+  to be added as DNS domain suffixes. If it is repeated multiple times within
+  a configuration the domains are appended, thus e.g. domain names pushed by
+  a server will amend locally defined ones.
+
+  The ``--dns server`` directive is used to configure DNS server ``n``.
+  The server id ``n`` must be a value between -128 and 127. For pushed
+  DNS server options it must be between 0 and 127. The server id is used
+  to group options and also for ordering the list of configured DNS servers;
+  lower numbers come first. DNS servers being pushed to a client replace
+  already configured DNS servers with the same server id.
+
+  The ``address`` option configures the IPv4 and / or IPv6 address of
+  the DNS server. Optionally a port can be appended after a colon. IPv6
+  addresses need to be enclosed in brackets if a port is appended.
+
+  The ``resolve-domains`` and ``exclude-domains`` options take one or
+  more DNS domains which are explicitly resolved or explicitly not resolved
+  by a server. Only one of the options can be configured for a server.
+  ``resolve-domains`` is used to define a split-dns setup, where only
+  given domains are resolved by a server. ``exclude-domains`` is used to
+  define domains which will never be resolved by a server (e.g. domains
+  which can only be resolved locally). Systems which do not support fine
+  grained DNS domain configuration, will ignore these settings.
+
+  The ``dnssec`` option is used to configure validation of DNSSEC records.
+  While the exact semantics may differ for resolvers on different systems,
+  ``yes`` likely makes validation mandatory, ``no`` disables it, and ``optional``
+  uses it opportunistically.
+
+  The ``transport`` option enables DNS-over-HTTPS (``DoH``) or DNS-over-TLS (``DoT``)
+  for a DNS server. The ``sni`` option can be used with them to specify the
+  ``server-name`` for TLS server name indication.
+
+  Each server has to have at least one address configured for a configuration
+  to be valid. All the other options can be omitted.
+
+  Note that not all options may be supported on all platforms. As soon support
+  for different systems is implemented, information will be added here how
+  unsupported options are treated.
+
+  The ``--dns`` option will eventually obsolete the ``--dhcp-option`` directive.
+  Until then it will replace configuration at the places ``--dhcp-option`` puts it,
+  so that ``--dns`` overrides ``--dhcp-option``. Thus, ``--dns`` can be used today
+  to migrate from ``--dhcp-option``.
+
 --explicit-exit-notify n
   In UDP client mode or point-to-point mode, send server/peer an exit
   notification if tunnel is restarted or OpenVPN process is exited. In
diff --git a/doc/man-sections/script-options.rst b/doc/man-sections/script-options.rst
index 77877a5d..6be0686d 100644
--- a/doc/man-sections/script-options.rst
+++ b/doc/man-sections/script-options.rst
@@ -588,6 +588,25 @@ instances.
     netsh.exe calls which sometimes just do not work right with interface
     names). Set prior to ``--up`` or ``--down`` script execution.
 
+:code:`dns_*`
+    The ``--dns`` configuration options will be made available to script
+    execution through this set of environment variables. Variables appear
+    only if the corresponding option has a value assigned. For the semantics
+    of each individual variable, please refer to the documentation for ``--dns``.
+
+    ::
+
+       dns_search_domain_{n}
+       dns_server_{n}_address4
+       dns_server_{n}_port4
+       dns_server_{n}_address6
+       dns_server_{n}_port6
+       dns_server_{n}_resolve_domain_{m}
+       dns_server_{n}_exclude_domain_{m}
+       dns_server_{n}_dnssec
+       dns_server_{n}_transport
+       dns_server_{n}_sni
+
 :code:`foreign_option_{n}`
     An option pushed via ``--push`` to a client which does not natively
     support it, such as ``--dhcp-option`` on a non-Windows system, will be
diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-options.rst
index 8a030294..08ee7bd3 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -412,7 +412,7 @@ fast hardware. SSL/TLS authentication must be used in this mode.
 
   This is a partial list of options which can currently be pushed:
   ``--route``, ``--route-gateway``, ``--route-delay``,
-  ``--redirect-gateway``, ``--ip-win32``, ``--dhcp-option``,
+  ``--redirect-gateway``, ``--ip-win32``, ``--dhcp-option``, ``--dns``,
   ``--inactive``, ``--ping``, ``--ping-exit``, ``--ping-restart``,
   ``--setenv``, ``--auth-token``, ``--persist-key``, ``--persist-tun``,
   ``--echo``, ``--comp-lzo``, ``--socket-flags``, ``--sndbuf``,
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 279ee94d..fc22feb9 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -54,6 +54,7 @@ openvpn_SOURCES = \
 	crypto_openssl.c crypto_openssl.h \
 	crypto_mbedtls.c crypto_mbedtls.h \
 	dhcp.c dhcp.h \
+	dns.c dns.h \
 	env_set.c env_set.h \
 	errlevel.h \
 	error.c error.h \
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
new file mode 100644
index 00000000..3c31a14e
--- /dev/null
+++ b/src/openvpn/dns.c
@@ -0,0 +1,510 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2022 OpenVPN Inc <sales@...515...>
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
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
+#include "syshead.h"
+
+#include "dns.h"
+#include "socket.h"
+
+/**
+ * Parses a string as port and stores it
+ *
+ * @param   port        Pointer to in_port_t where the port value is stored
+ * @param   addr        Port number as string
+ * @return              True if parsing was successful
+ */
+static bool
+dns_server_port_parse(in_port_t *port, char *port_str)
+{
+    char *endptr;
+    errno = 0;
+    unsigned long tmp = strtoul(port_str, &endptr, 10);
+    if (errno || *endptr != '\0' || tmp == 0 || tmp > UINT16_MAX)
+    {
+        return false;
+    }
+    *port = (in_port_t)tmp;
+    return true;
+}
+
+bool
+dns_server_addr_parse(struct dns_server *server, const char *addr)
+{
+    if (!addr)
+    {
+        return false;
+    }
+
+    char addrcopy[INET6_ADDRSTRLEN] = {0};
+    size_t copylen = 0;
+    in_port_t port = 0;
+    int af;
+
+    char *first_colon = strchr(addr, ':');
+    char *last_colon = strrchr(addr, ':');
+
+    if (!first_colon || first_colon == last_colon)
+    {
+        /* IPv4 address with optional port, e.g. 1.2.3.4 or 1.2.3.4:853 */
+        if (last_colon)
+        {
+            if (last_colon == addr || !dns_server_port_parse(&port, last_colon + 1))
+            {
+                return false;
+            }
+            copylen = first_colon - addr;
+        }
+        af = AF_INET;
+    }
+    else
+    {
+        /* IPv6 address with optional port, e.g. ab::cd or [ab::cd]:853 */
+        if (addr[0] == '[')
+        {
+            addr += 1;
+            char *bracket = last_colon - 1;
+            if (*bracket != ']' || bracket == addr || !dns_server_port_parse(&port, last_colon + 1))
+            {
+                return false;
+            }
+            copylen = bracket - addr;
+        }
+        af = AF_INET6;
+    }
+
+    /* Copy the address part into a temporary buffer and use that */
+    if (copylen)
+    {
+        if (copylen >= sizeof(addrcopy))
+        {
+            return false;
+        }
+        strncpy(addrcopy, addr, copylen);
+        addr = addrcopy;
+    }
+
+    struct addrinfo *ai = NULL;
+    if (openvpn_getaddrinfo(0, addr, NULL, 0, NULL, af, &ai) != 0)
+    {
+        return false;
+    }
+
+    if (ai->ai_family == AF_INET)
+    {
+        struct sockaddr_in *sin = (struct sockaddr_in *)ai->ai_addr;
+        server->addr4_defined = true;
+        server->addr4.s_addr = ntohl(sin->sin_addr.s_addr);
+        server->port4 = port;
+    }
+    else
+    {
+        struct sockaddr_in6 *sin6 = (struct sockaddr_in6 *)ai->ai_addr;
+        server->addr6_defined = true;
+        server->addr6 = sin6->sin6_addr;
+        server->port6 = port;
+    }
+
+    freeaddrinfo(ai);
+    return true;
+}
+
+void
+dns_domain_list_append(struct dns_domain **entry, char **domains, struct gc_arena *gc)
+{
+    /* Fast forward to the end of the list */
+    while (*entry)
+    {
+        entry = &((*entry)->next);
+    }
+
+    /* Append all domains to the end of the list */
+    while (*domains)
+    {
+        ALLOC_OBJ_CLEAR_GC(*entry, struct dns_domain, gc);
+        struct dns_domain *new = *entry;
+        new->name = *domains++;
+        entry = &new->next;
+    }
+}
+
+bool
+dns_server_priority_parse(long *priority, const char *str, bool pulled)
+{
+    char *endptr;
+    const long min = pulled ? 0 : INT8_MIN;
+    const long max = INT8_MAX;
+    long prio = strtol(str, &endptr, 10);
+    if (*endptr != '\0' || prio < min || prio > max)
+    {
+        return false;
+    }
+    *priority = prio;
+    return true;
+}
+
+struct dns_server*
+dns_server_get(struct dns_server **entry, long priority, struct gc_arena *gc)
+{
+    struct dns_server *obj = *entry;
+    while (true)
+    {
+        if (!obj || obj->priority > priority)
+        {
+            ALLOC_OBJ_CLEAR_GC(*entry, struct dns_server, gc);
+            (*entry)->next = obj;
+            (*entry)->priority = priority;
+            return *entry;
+        }
+        else if (obj->priority == priority)
+        {
+            return obj;
+        }
+        entry = &obj->next;
+        obj = *entry;
+    }
+}
+
+bool
+dns_options_verify(int msglevel, const struct dns_options *o)
+{
+    const struct dns_server *server =
+        o->servers ? o->servers : o->servers_prepull;
+    while (server)
+    {
+        if (!server->addr4_defined && !server->addr6_defined)
+        {
+            msg(msglevel, "ERROR: dns server %ld does not have an address assigned", server->priority);
+            return false;
+        }
+        server = server->next;
+    }
+    return true;
+}
+
+static struct dns_domain*
+clone_dns_domains(const struct dns_domain *domain, struct gc_arena* gc)
+{
+    struct dns_domain *new_list = NULL;
+    struct dns_domain **new_entry = &new_list;
+
+    while (domain)
+    {
+        ALLOC_OBJ_CLEAR_GC(*new_entry, struct dns_domain, gc);
+        struct dns_domain *new_domain = *new_entry;
+        *new_domain = *domain;
+        new_entry = &new_domain->next;
+        domain = domain->next;
+    }
+
+    return new_list;
+}
+
+static struct dns_server*
+clone_dns_servers(const struct dns_server *server, struct gc_arena* gc)
+{
+    struct dns_server *new_list = NULL;
+    struct dns_server **new_entry = &new_list;
+
+    while (server)
+    {
+        ALLOC_OBJ_CLEAR_GC(*new_entry, struct dns_server, gc);
+        struct dns_server *new_server = *new_entry;
+        *new_server = *server;
+        new_server->domains = clone_dns_domains(server->domains, gc);
+        new_entry = &new_server->next;
+        server = server->next;
+    }
+
+    return new_list;
+}
+
+struct dns_options
+clone_dns_options(const struct dns_options o, struct gc_arena* gc)
+{
+    struct dns_options clone;
+    memset(&clone, 0, sizeof(clone));
+    clone.search_domains = clone_dns_domains(o.search_domains, gc);
+    clone.servers = clone_dns_servers(o.servers, gc);
+    clone.servers_prepull = clone_dns_servers(o.servers_prepull, gc);
+    return clone;
+}
+
+void
+dns_options_preprocess_pull(struct dns_options *o)
+{
+    o->servers_prepull = o->servers;
+    o->servers = NULL;
+}
+
+void
+dns_options_postprocess_pull(struct dns_options *o)
+{
+    struct dns_server **entry = &o->servers;
+    struct dns_server *server = *entry;
+    struct dns_server *server_pp = o->servers_prepull;
+
+    while (server && server_pp)
+    {
+        if (server->priority > server_pp->priority)
+        {
+            /* Merge static server in front of pulled one */
+            struct dns_server *next_pp = server_pp->next;
+            server_pp->next = server;
+            *entry = server_pp;
+            server = *entry;
+            server_pp = next_pp;
+        }
+        else if (server->priority == server_pp->priority)
+        {
+            /* Pulled server overrides static one */
+            server_pp = server_pp->next;
+        }
+        entry = &server->next;
+        server = *entry;
+    }
+
+    /* Append remaining local servers */
+    if (server_pp)
+    {
+        *entry = server_pp;
+    }
+
+    o->servers_prepull = NULL;
+}
+
+static const char *
+dnssec_value(const enum dns_security dnssec)
+{
+    switch (dnssec)
+    {
+    case DNS_SECURITY_YES:
+        return "yes";
+    case DNS_SECURITY_OPTIONAL:
+        return "optional";
+    case DNS_SECURITY_NO:
+        return "no";
+    default:
+        return "unset";
+    }
+}
+
+static const char *
+transport_value(const enum dns_server_transport transport)
+{
+    switch (transport)
+    {
+    case DNS_TRANSPORT_HTTPS:
+        return "DoH";
+    case DNS_TRANSPORT_TLS:
+        return "DoT";
+    case DNS_TRANSPORT_PLAIN:
+        return "plain";
+    default:
+        return "unset";
+    }
+}
+
+static void
+setenv_dns_option(struct env_set *es,
+                  const char *format, int i, int j,
+                  const char *value)
+{
+    char name[64];
+    bool name_ok = false;
+
+    if (j < 0)
+    {
+        name_ok = openvpn_snprintf(name, sizeof(name), format, i);
+    }
+    else
+    {
+        name_ok = openvpn_snprintf(name, sizeof(name), format, i, j);
+    }
+
+    if (!name_ok)
+    {
+        msg(M_WARN, "WARNING: dns option setenv name buffer overflow");
+    }
+
+    setenv_str(es, name, value);
+}
+
+void
+setenv_dns_options(const struct dns_options *o, struct env_set *es)
+{
+    struct gc_arena gc = gc_new();
+    const struct dns_server *s;
+    const struct dns_domain *d;
+    int i, j;
+
+    for (i = 1, d = o->search_domains; d != NULL; i++, d = d->next)
+    {
+        setenv_dns_option(es, "dns_search_domain_%d", i, -1, d->name);
+    }
+
+    for (i = 1, s = o->servers; s != NULL; i++, s = s->next)
+    {
+        if (s->addr4_defined)
+        {
+            setenv_dns_option(es, "dns_server_%d_address4", i, -1,
+                              print_in_addr_t(s->addr4.s_addr, 0, &gc));
+        }
+        if (s->port4)
+        {
+            setenv_dns_option(es, "dns_server_%d_port4", i, -1,
+                              print_in_port_t(s->port4, &gc));
+        }
+
+        if (s->addr6_defined)
+        {
+            setenv_dns_option(es, "dns_server_%d_address6", i, -1,
+                              print_in6_addr(s->addr6, 0, &gc));
+        }
+        if (s->port6)
+        {
+            setenv_dns_option(es, "dns_server_%d_port6", i, -1,
+                              print_in_port_t(s->port6, &gc));
+        }
+
+        if (s->domains)
+        {
+            const char* format = s->domain_type == DNS_RESOLVE_DOMAINS ?
+                "dns_server_%d_resolve_domain_%d" : "dns_server_%d_exclude_domain_%d";
+            for (j = 1, d = s->domains; d != NULL; j++, d = d->next)
+            {
+                setenv_dns_option(es, format, i, j, d->name);
+            }
+        }
+
+        if (s->dnssec)
+        {
+            setenv_dns_option(es, "dns_server_%d_dnssec", i, -1,
+                              dnssec_value(s->dnssec));
+        }
+
+        if (s->transport)
+        {
+            setenv_dns_option(es, "dns_server_%d_transport", i, -1,
+                              transport_value(s->transport));
+        }
+        if (s->sni)
+        {
+            setenv_dns_option(es, "dns_server_%d_sni", i, -1, s->sni);
+        }
+    }
+
+    gc_free(&gc);
+}
+
+void
+show_dns_options(const struct dns_options *o)
+{
+    struct gc_arena gc = gc_new();
+
+    int i = 1;
+    struct dns_server *server = o->servers_prepull ? o->servers_prepull : o->servers;
+    while (server)
+    {
+        msg(D_SHOW_PARMS, "  DNS server #%d:", i++);
+
+        if (server->addr4_defined)
+        {
+            const char *addr = print_in_addr_t(server->addr4.s_addr, 0, &gc);
+            if (server->port4)
+            {
+                const char *port = print_in_port_t(server->port4, &gc);
+                msg(D_SHOW_PARMS, "    address4 = %s:%s", addr, port);
+            }
+            else
+            {
+                msg(D_SHOW_PARMS, "    address4 = %s", addr);
+            }
+        }
+        if (server->addr6_defined)
+        {
+            const char *addr = print_in6_addr(server->addr6, 0, &gc);
+            if (server->port6)
+            {
+                const char *port = print_in_port_t(server->port6, &gc);
+                msg(D_SHOW_PARMS, "    address6 = [%s]:%s", addr, port);
+            }
+            else
+            {
+                msg(D_SHOW_PARMS, "    address6 = %s", addr);
+            }
+        }
+
+        if (server->dnssec)
+        {
+            msg(D_SHOW_PARMS, "    dnssec = %s", dnssec_value(server->dnssec));
+        }
+
+        if (server->transport)
+        {
+            msg(D_SHOW_PARMS, "    transport = %s", transport_value(server->transport));
+        }
+        if (server->sni)
+        {
+            msg(D_SHOW_PARMS, "    sni = %s", server->sni);
+        }
+
+        struct dns_domain *domain = server->domains;
+        if (domain)
+        {
+            if (server->domain_type == DNS_RESOLVE_DOMAINS)
+            {
+                msg(D_SHOW_PARMS, "    resolve domains:");
+            }
+            else
+            {
+                msg(D_SHOW_PARMS, "    exclude domains:");
+            }
+            while(domain)
+            {
+                msg(D_SHOW_PARMS, "      %s", domain->name);
+                domain = domain->next;
+            }
+        }
+
+        server = server->next;
+    }
+
+    struct dns_domain *search_domain = o->search_domains;
+    if (search_domain)
+    {
+        msg(D_SHOW_PARMS, "  DNS search domains:");
+        while(search_domain)
+        {
+            msg(D_SHOW_PARMS, "    %s", search_domain->name);
+            search_domain = search_domain->next;
+        }
+    }
+
+    gc_free(&gc);
+}
diff --git a/src/openvpn/dns.h b/src/openvpn/dns.h
new file mode 100644
index 00000000..1c6bfc6f
--- /dev/null
+++ b/src/openvpn/dns.h
@@ -0,0 +1,164 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2022 OpenVPN Inc <sales@...515...>
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
+#ifndef DNS_H
+#define DNS_H
+
+#include "buffer.h"
+#include "env_set.h"
+
+enum dns_domain_type {
+  DNS_DOMAINS_UNSET,
+  DNS_RESOLVE_DOMAINS,
+  DNS_EXCLUDE_DOMAINS
+};
+
+enum dns_security {
+  DNS_SECURITY_UNSET,
+  DNS_SECURITY_NO,
+  DNS_SECURITY_YES,
+  DNS_SECURITY_OPTIONAL
+};
+
+enum dns_server_transport {
+  DNS_TRANSPORT_UNSET,
+  DNS_TRANSPORT_PLAIN,
+  DNS_TRANSPORT_HTTPS,
+  DNS_TRANSPORT_TLS
+};
+
+struct dns_domain {
+  struct dns_domain *next;
+  const char *name;
+};
+
+struct dns_server {
+  struct dns_server *next;
+  long priority;
+  bool addr4_defined;
+  bool addr6_defined;
+  struct in_addr addr4;
+  struct in6_addr addr6;
+  in_port_t port4;
+  in_port_t port6;
+  struct dns_domain *domains;
+  enum dns_domain_type domain_type;
+  enum dns_security dnssec;
+  enum dns_server_transport transport;
+  const char *sni;
+};
+
+struct dns_options {
+  struct dns_domain *search_domains;
+  struct dns_server *servers_prepull;
+  struct dns_server *servers;
+  struct gc_arena gc;
+};
+
+/**
+ * Parses a string DNS server priority and validates it.
+ *
+ * @param   priority    Pointer to where the priority should be stored
+ * @param   str         Priority string to parse
+ * @param   pulled      Whether this was pulled from a server
+ * @return              True if priority in string is valid
+ */
+bool dns_server_priority_parse(long *priority, const char *str, bool pulled);
+
+/**
+ * Find or create DNS server with priority in a linked list.
+ * The list is ordered by priority.
+ *
+ * @param   entry       Address of the first list entry pointer
+ * @param   priority    Priority of the DNS server to find / create
+ * @param   gc          The gc new list items should be allocated in
+ */
+struct dns_server* dns_server_get(struct dns_server **entry, long priority, struct gc_arena *gc);
+
+/**
+ * Appends DNS domain parameters to a linked list.
+ *
+ * @param   entry       Address of the first list entry pointer
+ * @param   domains     Address of the first domain parameter
+ * @param   gc          The gc the new list items should be allocated in
+ */
+void dns_domain_list_append(struct dns_domain **entry, char **domains, struct gc_arena *gc);
+
+/**
+ * Parses a string IPv4 or IPv6 address and optional colon separated port,
+ * into a in_addr or in6_addr respectively plus a in_port_t port.
+ *
+ * @param   server      Pointer to DNS server the address is parsed for
+ * @param   addr        Address as string
+ * @return              True if parsing was successful
+ */
+bool dns_server_addr_parse(struct dns_server *server, const char *addr);
+
+/**
+ * Checks validity of DNS options
+ *
+ * @param   msglevel    The message level to log errors with
+ * @param   o           Pointer to the DNS options to validate
+ * @return              True if no error was found
+ */
+bool dns_options_verify(int msglevel, const struct dns_options *o);
+
+/**
+ * Makes a deep copy of the passed DNS options.
+ *
+ * @param   o           Pointer to the DNS options to clone
+ * @param   gc          Pointer to the gc_arena to use for the clone
+ * @return              The dns_options clone
+  */
+struct dns_options clone_dns_options(const struct dns_options o, struct gc_arena *gc);
+
+/**
+ * Saves and resets the server options, so that pulled ones don't mix in.
+ *
+ * @param   o           Pointer to the DNS options to modify
+ */
+void dns_options_preprocess_pull(struct dns_options *o);
+
+/**
+ * Merges pulled DNS servers with static ones into an ordered list.
+ *
+ * @param   o           Pointer to the DNS options to modify
+ */
+void dns_options_postprocess_pull(struct dns_options *o);
+
+/**
+ * Puts the DNS options into an environment set.
+ *
+ * @param   o           Pointer to the DNS options to set
+ * @param   es          Pointer to the env_set to set the options into
+ */
+void setenv_dns_options(const struct dns_options *o, struct env_set *es);
+
+/**
+ * Prints configured DNS options.
+ *
+ * @param   o           Pointer to the DNS options to print
+ */
+void show_dns_options(const struct dns_options *o);
+
+#endif
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
index 1d32c41f..a43cbd81 100644
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -269,6 +269,7 @@
     <ClCompile Include="cryptoapi.c" />
     <ClCompile Include="env_set.c" />
     <ClCompile Include="dhcp.c" />
+    <ClCompile Include="dns.c" />
     <ClCompile Include="error.c" />
     <ClCompile Include="event.c" />
     <ClCompile Include="fdmisc.c" />
@@ -352,6 +353,7 @@
     <ClInclude Include="crypto_openssl.h" />
     <ClInclude Include="cryptoapi.h" />
     <ClInclude Include="dhcp.h" />
+    <ClInclude Include="dns.h" />
     <ClInclude Include="env_set.h" />
     <ClInclude Include="errlevel.h" />
     <ClInclude Include="error.h" />
@@ -444,4 +446,4 @@
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.targets" />
   <ImportGroup Label="ExtensionTargets">
   </ImportGroup>
-</Project>
\ No newline at end of file
+</Project>
diff --git a/src/openvpn/openvpn.vcxproj.filters b/src/openvpn/openvpn.vcxproj.filters
index 4cf0bb00..abc45225 100644
--- a/src/openvpn/openvpn.vcxproj.filters
+++ b/src/openvpn/openvpn.vcxproj.filters
@@ -39,6 +39,9 @@
     <ClCompile Include="dhcp.c">
       <Filter>Source Files</Filter>
     </ClCompile>
+    <ClCompile Include="dns.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
     <ClCompile Include="error.c">
       <Filter>Source Files</Filter>
     </ClCompile>
@@ -296,6 +299,9 @@
     <ClInclude Include="dhcp.h">
       <Filter>Header Files</Filter>
     </ClInclude>
+    <ClInclude Include="dns.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
     <ClInclude Include="errlevel.h">
       <Filter>Header Files</Filter>
     </ClInclude>
@@ -535,4 +541,4 @@
       <Filter>Resource Files</Filter>
     </Manifest>
   </ItemGroup>
-</Project>
\ No newline at end of file
+</Project>
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 7d7b8dc1..d6d94f60 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -499,6 +499,16 @@ static const char usage_message[] =
     "                  ignore or reject causes the option to be allowed, removed or\n"
     "                  rejected with error. May be specified multiple times, and\n"
     "                  each filter is applied in the order of appearance.\n"
+    "--dns server <n> <option> <value> [value ...] : Configure option for DNS server #n\n"
+    "                  Valid options are :\n"
+    "                  address <addr[:port]> [addr[:port]] : server address 4/6\n"
+    "                  resolve-domains <domain> [domain ...] : split domains\n"
+    "                  exclude-domains <domain> [domain ...] : domains not to resolve\n"
+    "                  dnssec <yes|no|optional> : option to use DNSSEC\n"
+    "                  type <DoH|DoT> : query server over HTTPS / TLS\n"
+    "                  sni <domain> : DNS server name indication\n"
+    "--dns search-domains <domain> [domain ...]:\n"
+    "                  Add domains to DNS domain search list\n"
     "--auth-retry t  : How to handle auth failures.  Set t to\n"
     "                  none (default), interact, or nointeract.\n"
     "--static-challenge t e : Enable static challenge/response protocol using\n"
@@ -786,6 +796,7 @@ init_options(struct options *o, const bool init_gc)
     if (init_gc)
     {
         gc_init(&o->gc);
+        gc_init(&o->dns_options.gc);
         o->gc_owned = true;
     }
     o->mode = MODE_POINT_TO_POINT;
@@ -891,6 +902,7 @@ uninit_options(struct options *o)
     if (o->gc_owned)
     {
         gc_free(&o->gc);
+        gc_free(&o->dns_options.gc);
     }
 }
 
@@ -994,6 +1006,11 @@ setenv_settings(struct env_set *es, const struct options *o)
     {
         setenv_connection_entry(es, &o->ce, 1);
     }
+
+    if (!o->pull)
+    {
+        setenv_dns_options(&o->dns_options, es);
+    }
 }
 
 static in_addr_t
@@ -1268,6 +1285,64 @@ dhcp_option_address_parse(const char *name, const char *parm, in_addr_t *array,
     }
 }
 
+/*
+ * If DNS options are set use these for TUN/TAP options as well.
+ * Applies to DNS, DNS6 and DOMAIN-SEARCH.
+ * Existing options will be discarded.
+ */
+static void
+tuntap_options_copy_dns(struct options *o)
+{
+    struct tuntap_options *tt = &o->tuntap_options;
+    struct dns_options *dns = &o->dns_options;
+
+    if (dns->search_domains)
+    {
+        tt->domain_search_list_len = 0;
+        const struct dns_domain *domain = dns->search_domains;
+        while (domain && tt->domain_search_list_len < N_SEARCH_LIST_LEN)
+        {
+            tt->domain_search_list[tt->domain_search_list_len++] = domain->name;
+            domain = domain->next;
+        }
+        if (domain)
+        {
+            msg(M_WARN, "WARNING: couldn't copy all --dns search-domains to --dhcp-option");
+        }
+    }
+
+    if (dns->servers)
+    {
+        tt->dns_len = 0;
+        tt->dns6_len = 0;
+        bool overflow = false;
+        const struct dns_server *server = dns->servers;
+        while (server)
+        {
+            if (server->addr4_defined && tt->dns_len < N_DHCP_ADDR)
+            {
+                tt->dns[tt->dns_len++] = server->addr4.s_addr;
+            }
+            else
+            {
+                overflow = true;
+            }
+            if (server->addr6_defined && tt->dns6_len < N_DHCP_ADDR)
+            {
+                tt->dns6[tt->dns6_len++] = server->addr6;
+            }
+            else
+            {
+                overflow = true;
+            }
+            server = server->next;
+        }
+        if (overflow)
+        {
+            msg(M_WARN, "WARNING: couldn't copy all --dns server addresses to --dhcp-option");
+        }
+    }
+}
 #endif /* if defined(_WIN32) || defined(TARGET_ANDROID) */
 
 #ifndef ENABLE_SMALL
@@ -1697,6 +1772,8 @@ show_settings(const struct options *o)
         print_client_nat_list(o->client_nat, D_SHOW_PARMS);
     }
 
+    show_dns_options(&o->dns_options);
+
 #ifdef ENABLE_MANAGEMENT
     SHOW_STR(management_addr);
     SHOW_STR(management_port);
@@ -3087,6 +3164,8 @@ options_postprocess_verify(const struct options *o)
     {
         options_postprocess_verify_ce(o, &o->ce);
     }
+
+    dns_options_verify(M_FATAL, &o->dns_options);
 }
 
 /**
@@ -3335,6 +3414,16 @@ options_postprocess_mutate(struct options *o)
      * Save certain parms before modifying options during connect, especially
      * when using --pull
      */
+    if (o->pull)
+    {
+        dns_options_preprocess_pull(&o->dns_options);
+    }
+#if defined(_WIN32) || defined(TARGET_ANDROID)
+    else
+    {
+        tuntap_options_copy_dns(o);
+    }
+#endif
     pre_connect_save(o);
 }
 
@@ -3679,6 +3768,25 @@ options_postprocess(struct options *options)
 #endif /* !ENABLE_SMALL */
 }
 
+/*
+ * Sanity check on options after more options were pulled from server.
+ * Also time to modify some options based on other options.
+ */
+bool
+options_postprocess_pull(struct options *o, struct env_set *es)
+{
+    bool success = dns_options_verify(D_PUSH_ERRORS, &o->dns_options);
+    if (success)
+    {
+        dns_options_postprocess_pull(&o->dns_options);
+        setenv_dns_options(&o->dns_options, es);
+#if defined(_WIN32) || defined(TARGET_ANDROID)
+        tuntap_options_copy_dns(o);
+#endif
+    }
+    return success;
+}
+
 /*
  * Save/Restore certain option defaults before --pull is applied.
  */
@@ -3710,6 +3818,8 @@ pre_connect_save(struct options *o)
     o->pre_connect->route_default_gateway = o->route_default_gateway;
     o->pre_connect->route_ipv6_default_gateway = o->route_ipv6_default_gateway;
 
+    o->pre_connect->dns_options = clone_dns_options(o->dns_options, &o->gc);
+
     /* NCP related options that can be overwritten by a push */
     o->pre_connect->ciphername = o->ciphername;
     o->pre_connect->authname = o->authname;
@@ -3760,6 +3870,12 @@ pre_connect_restore(struct options *o, struct gc_arena *gc)
         o->route_default_gateway = pp->route_default_gateway;
         o->route_ipv6_default_gateway = pp->route_ipv6_default_gateway;
 
+        /* Free DNS options and reset them to pre-pull state */
+        gc_free(&o->dns_options.gc);
+        struct gc_arena dns_gc = gc_new();
+        o->dns_options = clone_dns_options(pp->dns_options, &dns_gc);
+        o->dns_options.gc = dns_gc;
+
         if (pp->client_nat_defined)
         {
             cnol_check_alloc(o);
@@ -7558,6 +7674,111 @@ add_option(struct options *options,
         to->ip_win32_defined = true;
     }
 #endif /* ifdef _WIN32 */
+    else if (streq(p[0], "dns") && p[1])
+    {
+        VERIFY_PERMISSION(OPT_P_DEFAULT);
+
+        if (streq(p[1], "search-domains") && p[2])
+        {
+            dns_domain_list_append(&options->dns_options.search_domains, &p[2], &options->dns_options.gc);
+        }
+        else if (streq(p[1], "server") && p[2] && p[3] && p[4])
+        {
+            long priority;
+            if (!dns_server_priority_parse(&priority, p[2], pull_mode)) {
+                msg(msglevel, "--dns server: invalid priority value '%s'", p[2]);
+                goto err;
+            }
+
+            struct dns_server *server = dns_server_get(&options->dns_options.servers, priority, &options->dns_options.gc);
+
+            if (streq(p[3], "address") && !p[6])
+            {
+                for (int i = 4; p[i]; i++)
+                {
+                    if(!dns_server_addr_parse(server, p[i]))
+                    {
+                        msg(msglevel, "--dns server %ld: malformed or duplicate address '%s'", priority, p[i]);
+                        goto err;
+                    }
+                }
+            }
+            else if (streq(p[3], "resolve-domains"))
+            {
+                if (server->domain_type == DNS_EXCLUDE_DOMAINS)
+                {
+                    msg(msglevel, "--dns server %ld: cannot use resolve-domains and exclude-domains", priority);
+                    goto err;
+                }
+                server->domain_type = DNS_RESOLVE_DOMAINS;
+                dns_domain_list_append(&server->domains, &p[4], &options->dns_options.gc);
+            }
+            else if (streq(p[3], "exclude-domains"))
+            {
+                if (server->domain_type == DNS_RESOLVE_DOMAINS)
+                {
+                    msg(msglevel, "--dns server %ld: cannot use exclude-domains and resolve-domains", priority);
+                    goto err;
+                }
+                server->domain_type = DNS_EXCLUDE_DOMAINS;
+                dns_domain_list_append(&server->domains, &p[4], &options->dns_options.gc);
+            }
+            else if (streq(p[3], "dnssec") && !p[5])
+            {
+                if (streq(p[4], "yes"))
+                {
+                    server->dnssec = DNS_SECURITY_YES;
+                }
+                else if (streq(p[4], "no"))
+                {
+                    server->dnssec = DNS_SECURITY_NO;
+                }
+                else if (streq(p[4], "optional"))
+                {
+                    server->dnssec = DNS_SECURITY_OPTIONAL;
+                }
+                else
+                {
+                    msg(msglevel, "--dns server %ld: malformed dnssec value '%s'", priority, p[4]);
+                    goto err;
+                }
+            }
+            else if (streq(p[3], "transport") && !p[5])
+            {
+                if (streq(p[4], "plain"))
+                {
+                    server->transport = DNS_TRANSPORT_PLAIN;
+                }
+                else if (streq(p[4], "DoH"))
+                {
+                    server->transport = DNS_TRANSPORT_HTTPS;
+                }
+                else if (streq(p[4], "DoT"))
+                {
+                    server->transport = DNS_TRANSPORT_TLS;
+                }
+                else
+                {
+                    msg(msglevel, "--dns server %ld: malformed transport value '%s'", priority, p[4]);
+                    goto err;
+                }
+            }
+            else if (streq(p[3], "sni") && !p[5])
+            {
+                server->sni = p[4];
+            }
+            else
+            {
+                msg(msglevel, "--dns server %ld: unknown option type '%s' or missing or unknown parameter", priority, p[3]);
+                goto err;
+            }
+        }
+        else
+        {
+            msg(msglevel, "--dns: unknown option type '%s' or missing or unknown parameter", p[1]);
+            goto err;
+        }
+    }
 #if defined(_WIN32) || defined(TARGET_ANDROID)
     else if (streq(p[0], "dhcp-option") && p[1])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 9c25fbaf..af13af16 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -42,6 +42,7 @@
 #include "pushlist.h"
 #include "clinat.h"
 #include "crypto_backend.h"
+#include "dns.h"
 
 
 /*
@@ -76,6 +77,8 @@ struct options_pre_connect
     bool client_nat_defined;
     struct client_nat_option_list *client_nat;
 
+    struct dns_options dns_options;
+
     const char* ciphername;
     const char* authname;
 
@@ -276,6 +279,8 @@ struct options
 
     struct remote_host_store *rh_store;
 
+    struct dns_options dns_options;
+
     bool remote_random;
     const char *ipchange;
     const char *dev;
@@ -806,6 +811,8 @@ char *options_string_extract_option(const char *options_string,
 
 void options_postprocess(struct options *options);
 
+bool options_postprocess_pull(struct options *o, struct env_set *es);
+
 void pre_connect_save(struct options *o);
 
 void pre_connect_restore(struct options *o, struct gc_arena *gc);
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index bcee19d3..9c4b52f6 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -459,6 +459,10 @@ incoming_push_message(struct context *c, const struct buffer *buffer)
         /* delay bringing tun/tap up until --push parms received from remote */
         if (status == PUSH_MSG_REPLY)
         {
+            if (!options_postprocess_pull(&c->options, c->c2.es))
+            {
+                goto error;
+            }
             if (!do_up(c, true, c->options.push_option_types_found))
             {
                 msg(D_PUSH_ERRORS, "Failed to open tun/tap interface");
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 0f34a5de..bec9308f 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2875,6 +2875,17 @@ print_in6_addr(struct in6_addr a6, unsigned int flags, struct gc_arena *gc)
     return BSTR(&out);
 }
 
+/*
+ * Convert an in_port_t in host byte order to a string
+ */
+const char *
+print_in_port_t(in_port_t port, struct gc_arena *gc)
+{
+    struct buffer buffer = alloc_buf_gc(8, gc);
+    buf_printf(&buffer, "%hu", port);
+    return BSTR(&buffer);
+}
+
 #ifndef UINT8_MAX
 #define UINT8_MAX 0xff
 #endif
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index e9f1524d..8fb58e14 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -389,6 +389,8 @@ const char *print_in_addr_t(in_addr_t addr, unsigned int flags, struct gc_arena
 
 const char *print_in6_addr(struct in6_addr addr6, unsigned int flags, struct gc_arena *gc);
 
+const char *print_in_port_t(in_port_t port, struct gc_arena *gc);
+
 struct in6_addr add_in6_addr( struct in6_addr base, uint32_t add );
 
 #define SA_IP_PORT        (1<<0)
-- 
2.32.0


