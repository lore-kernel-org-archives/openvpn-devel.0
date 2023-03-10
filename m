From: Heiko Hund <heiko@...2662...>
Date: Fri, 10 Mar 2023 06:08:12 +0100
Message-Id: <20230310050814.67246-1-heiko@...2662...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/3] dns option: allow up to eight addresses
 per server
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

This change allows configuration of more than one address per family
for a DNS server. This way you can specify backup addresses in case a
server is not reachable. During closer inspection of the various DNS
backend in supported operation systems it turned out that our previous
idea to have more than one DNS server applied in order of priority does
not work in most cases. Thus it became important to be able to specify
backup addresses. So instead of doing

  dns server 1 address 1.2.3.4 2001::1
  dns server 2 address 5.6.7.8 2001::2

to specify a backup addresses, this is now done like so:

  dns server 1 address 1.2.3.4 2001::1
  dns server 1 address 5.6.7.8 2001::2

or you can have all the addresses on one line if you like:

  dns server 1 address 1.2.3.4 2001::1 2001::2 5.6.7.8

This also saves some repeated options when (backup) servers share the
same settings like "resolve-domains" compared to the originally intended
way.

The order in which addresses are given is retained for backends that
support this sort of cross address family ordering.

Change-Id: I9bd3d6d05da4e61a5fa05c0e455fc770b1fe186a
Signed-off-by: Heiko Hund <heiko@...2662...>
---
 doc/man-sections/client-options.rst |  9 ++--
 doc/man-sections/script-options.rst |  6 +--
 src/openvpn/dns.c                   | 83 +++++++++++++++--------------
 src/openvpn/dns.h                   | 18 ++++---
 src/openvpn/options.c               | 76 ++++++++++++++------------
 5 files changed, 103 insertions(+), 89 deletions(-)

diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-options.rst
index 974cc992..fe9ffa6a 100644
--- a/doc/man-sections/client-options.rst
+++ b/doc/man-sections/client-options.rst
@@ -168,7 +168,7 @@ configuration.
   ::
 
      dns search-domains domain [domain ...]
-     dns server n address addr[:port] [addr[:port]]
+     dns server n address addr[:port] [addr[:port] ...]
      dns server n resolve-domains|exclude-domains domain [domain ...]
      dns server n dnssec yes|optional|no
      dns server n transport DoH|DoT|plain
@@ -186,9 +186,10 @@ configuration.
   lower numbers come first. DNS servers being pushed to a client replace
   already configured DNS servers with the same server id.
 
-  The ``address`` option configures the IPv4 and / or IPv6 address of
-  the DNS server. Optionally a port can be appended after a colon. IPv6
-  addresses need to be enclosed in brackets if a port is appended.
+  The ``address`` option configures the IPv4 and / or IPv6 address(es) of
+  the DNS server. Up to eight addresses can be specified per DNS server.
+  Optionally a port can be appended after a colon. IPv6 addresses need to
+  be enclosed in brackets if a port is appended.
 
   The ``resolve-domains`` and ``exclude-domains`` options take one or
   more DNS domains which are explicitly resolved or explicitly not resolved
diff --git a/doc/man-sections/script-options.rst b/doc/man-sections/script-options.rst
index 3d2c7445..d73231ed 100644
--- a/doc/man-sections/script-options.rst
+++ b/doc/man-sections/script-options.rst
@@ -660,10 +660,8 @@ instances.
     ::
 
        dns_search_domain_{n}
-       dns_server_{n}_address4
-       dns_server_{n}_port4
-       dns_server_{n}_address6
-       dns_server_{n}_port6
+       dns_server_{n}_address_{m}
+       dns_server_{n}_port_{m}
        dns_server_{n}_resolve_domain_{m}
        dns_server_{n}_exclude_domain_{m}
        dns_server_{n}_dnssec
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 9f2a7d5e..b7808db1 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -64,7 +64,7 @@ dns_server_addr_parse(struct dns_server *server, const char *addr)
     char addrcopy[INET6_ADDRSTRLEN] = {0};
     size_t copylen = 0;
     in_port_t port = 0;
-    int af;
+    sa_family_t af;
 
     char *first_colon = strchr(addr, ':');
     char *last_colon = strrchr(addr, ':');
@@ -115,21 +115,26 @@ dns_server_addr_parse(struct dns_server *server, const char *addr)
         return false;
     }
 
+    if (server->addr_count >= SIZE(server->addr))
+    {
+        return false;
+    }
+
     if (ai->ai_family == AF_INET)
     {
         struct sockaddr_in *sin = (struct sockaddr_in *)ai->ai_addr;
-        server->addr4_defined = true;
-        server->addr4.s_addr = ntohl(sin->sin_addr.s_addr);
-        server->port4 = port;
+        server->addr[server->addr_count].in.a4.s_addr = ntohl(sin->sin_addr.s_addr);
     }
     else
     {
         struct sockaddr_in6 *sin6 = (struct sockaddr_in6 *)ai->ai_addr;
-        server->addr6_defined = true;
-        server->addr6 = sin6->sin6_addr;
-        server->port6 = port;
+        server->addr[server->addr_count].in.a6 = sin6->sin6_addr;
     }
 
+    server->addr[server->addr_count].family = af;
+    server->addr[server->addr_count].port = port;
+    server->addr_count += 1;
+
     freeaddrinfo(ai);
     return true;
 }
@@ -197,7 +202,7 @@ dns_options_verify(int msglevel, const struct dns_options *o)
         o->servers ? o->servers : o->servers_prepull;
     while (server)
     {
-        if (!server->addr4_defined && !server->addr6_defined)
+        if (server->addr_count == 0)
         {
             msg(msglevel, "ERROR: dns server %ld does not have an address assigned", server->priority);
             return false;
@@ -376,26 +381,23 @@ setenv_dns_options(const struct dns_options *o, struct env_set *es)
 
     for (i = 1, s = o->servers; s != NULL; i++, s = s->next)
     {
-        if (s->addr4_defined)
-        {
-            setenv_dns_option(es, "dns_server_%d_address4", i, -1,
-                              print_in_addr_t(s->addr4.s_addr, 0, &gc));
-        }
-        if (s->port4)
-        {
-            setenv_dns_option(es, "dns_server_%d_port4", i, -1,
-                              print_in_port_t(s->port4, &gc));
-        }
-
-        if (s->addr6_defined)
-        {
-            setenv_dns_option(es, "dns_server_%d_address6", i, -1,
-                              print_in6_addr(s->addr6, 0, &gc));
-        }
-        if (s->port6)
+        for (j = 0; j < s->addr_count; ++j)
         {
-            setenv_dns_option(es, "dns_server_%d_port6", i, -1,
-                              print_in_port_t(s->port6, &gc));
+            if (s->addr[j].family == AF_INET)
+            {
+                setenv_dns_option(es, "dns_server_%d_address_%d", i, j + 1,
+                                  print_in_addr_t(s->addr[j].in.a4.s_addr, 0, &gc));
+            }
+            else
+            {
+                setenv_dns_option(es, "dns_server_%d_address_%d", i, j + 1,
+                                  print_in6_addr(s->addr[j].in.a6, 0, &gc));
+            }
+            if (s->addr[j].port)
+            {
+                setenv_dns_option(es, "dns_server_%d_port_%d", i, j + 1,
+                                  print_in_port_t(s->addr[j].port, &gc));
+            }
         }
 
         if (s->domains)
@@ -439,30 +441,29 @@ show_dns_options(const struct dns_options *o)
     {
         msg(D_SHOW_PARMS, "  DNS server #%d:", i++);
 
-        if (server->addr4_defined)
+        for (int j = 0; j < server->addr_count; ++j)
         {
-            const char *addr = print_in_addr_t(server->addr4.s_addr, 0, &gc);
-            if (server->port4)
+            const char *addr;
+            const char *fmt_port;
+            if (server->addr[j].family == AF_INET)
             {
-                const char *port = print_in_port_t(server->port4, &gc);
-                msg(D_SHOW_PARMS, "    address4 = %s:%s", addr, port);
+                addr = print_in_addr_t(server->addr[j].in.a4.s_addr, 0, &gc);
+                fmt_port = "    address = %s:%s";
             }
             else
             {
-                msg(D_SHOW_PARMS, "    address4 = %s", addr);
+                addr = print_in6_addr(server->addr[j].in.a6, 0, &gc);
+                fmt_port = "    address = [%s]:%s";
             }
-        }
-        if (server->addr6_defined)
-        {
-            const char *addr = print_in6_addr(server->addr6, 0, &gc);
-            if (server->port6)
+
+            if (server->addr[j].port)
             {
-                const char *port = print_in_port_t(server->port6, &gc);
-                msg(D_SHOW_PARMS, "    address6 = [%s]:%s", addr, port);
+                const char *port = print_in_port_t(server->addr[j].port, &gc);
+                msg(D_SHOW_PARMS, fmt_port, addr, port);
             }
             else
             {
-                msg(D_SHOW_PARMS, "    address6 = %s", addr);
+                msg(D_SHOW_PARMS, "    address = %s", addr);
             }
         }
 
diff --git a/src/openvpn/dns.h b/src/openvpn/dns.h
index 03a894f2..162dec12 100644
--- a/src/openvpn/dns.h
+++ b/src/openvpn/dns.h
@@ -52,15 +52,21 @@ struct dns_domain {
     const char *name;
 };
 
+struct dns_server_addr
+{
+    union {
+        struct in_addr a4;
+        struct in6_addr a6;
+    } in;
+    sa_family_t family;
+    in_port_t port;
+};
+
 struct dns_server {
     struct dns_server *next;
     long priority;
-    bool addr4_defined;
-    bool addr6_defined;
-    struct in_addr addr4;
-    struct in6_addr addr6;
-    in_port_t port4;
-    in_port_t port6;
+    size_t addr_count;
+    struct dns_server_addr addr[8];
     struct dns_domain *domains;
     enum dns_domain_type domain_type;
     enum dns_security dnssec;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 9105449c..17ce2b05 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -512,7 +512,7 @@ static const char usage_message[] =
     "                  each filter is applied in the order of appearance.\n"
     "--dns server <n> <option> <value> [value ...] : Configure option for DNS server #n\n"
     "                  Valid options are :\n"
-    "                  address <addr[:port]> [addr[:port]] : server address 4/6\n"
+    "                  address <addr[:port]> [addr[:port] ...] : server addresses 4/6\n"
     "                  resolve-domains <domain> [domain ...] : split domains\n"
     "                  exclude-domains <domain> [domain ...] : domains not to resolve\n"
     "                  dnssec <yes|no|optional> : option to use DNSSEC\n"
@@ -1387,21 +1387,26 @@ tuntap_options_copy_dns(struct options *o)
         const struct dns_server *server = dns->servers;
         while (server)
         {
-            if (server->addr4_defined && tt->dns_len < N_DHCP_ADDR)
+            for (int i = 0; i < server->addr_count; ++i)
             {
-                tt->dns[tt->dns_len++] = server->addr4.s_addr;
-            }
-            else
-            {
-                overflow = true;
-            }
-            if (server->addr6_defined && tt->dns6_len < N_DHCP_ADDR)
-            {
-                tt->dns6[tt->dns6_len++] = server->addr6;
-            }
-            else
-            {
-                overflow = true;
+                if (server->addr[i].family == AF_INET)
+                {
+                    if (tt->dns_len >= N_DHCP_ADDR)
+                    {
+                        overflow = true;
+                        continue;
+                    }
+                    tt->dns[tt->dns_len++] = server->addr[i].in.a4.s_addr;
+                }
+                else
+                {
+                    if (tt->dns6_len >= N_DHCP_ADDR)
+                    {
+                        overflow = true;
+                        continue;
+                    }
+                    tt->dns6[tt->dns6_len++] = server->addr[i].in.a6;
+                }
             }
             server = server->next;
         }
@@ -1448,23 +1453,26 @@ foreign_options_copy_dns(struct options *o, struct env_set *es)
 
     while (server)
     {
-        if (server->addr4_defined)
-        {
-            const char *argv[] = {
-                "dhcp-option",
-                "DNS",
-                print_in_addr_t(server->addr4.s_addr, 0, &gc)
-            };
-            setenv_foreign_option(o, argv, 3, es);
-        }
-        if (server->addr6_defined)
+        for (int i = 0; i < server->addr_count; ++i)
         {
-            const char *argv[] = {
-                "dhcp-option",
-                "DNS6",
-                print_in6_addr(server->addr6, 0, &gc)
-            };
-            setenv_foreign_option(o, argv, 3, es);
+            if (server->addr[i].family == AF_INET)
+            {
+                const char *argv[] = {
+                    "dhcp-option",
+                    "DNS",
+                    print_in_addr_t(server->addr[i].in.a4.s_addr, 0, &gc)
+                };
+                setenv_foreign_option(o, argv, 3, es);
+            }
+            else
+            {
+                const char *argv[] = {
+                    "dhcp-option",
+                    "DNS6",
+                    print_in6_addr(server->addr[i].in.a6, 0, &gc)
+                };
+                setenv_foreign_option(o, argv, 3, es);
+            }
         }
         server = server->next;
     }
@@ -8001,13 +8009,13 @@ add_option(struct options *options,
 
             struct dns_server *server = dns_server_get(&options->dns_options.servers, priority, &options->dns_options.gc);
 
-            if (streq(p[3], "address") && !p[6])
+            if (streq(p[3], "address") && p[4])
             {
-                for (int i = 4; p[i]; i++)
+                for (int i = 4; p[i]; ++i)
                 {
                     if (!dns_server_addr_parse(server, p[i]))
                     {
-                        msg(msglevel, "--dns server %ld: malformed or duplicate address '%s'", priority, p[i]);
+                        msg(msglevel, "--dns server %ld: malformed address or maximum exceeded '%s'", priority, p[i]);
                         goto err;
                     }
                 }
-- 
2.37.2


