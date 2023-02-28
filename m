From: Heiko Hund <heiko@...2662...>
Date: Tue, 28 Feb 2023 05:26:45 +0100
Message-Id: <20230228042645.38863-1-heiko@...2662...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] dns option: allow up to two addresses per
 family
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

Signed-off-by: Heiko Hund <heiko@...2662...>
---
 doc/man-sections/client-options.rst |  7 +--
 src/openvpn/dns.c                   | 70 ++++++++++++++++-------------
 src/openvpn/dns.h                   | 19 +++++---
 src/openvpn/options.c               | 30 +++++++------
 4 files changed, 72 insertions(+), 54 deletions(-)

diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-options.rst
index 974cc992..0b973adf 100644
--- a/doc/man-sections/client-options.rst
+++ b/doc/man-sections/client-options.rst
@@ -168,7 +168,7 @@ configuration.
   ::
 
      dns search-domains domain [domain ...]
-     dns server n address addr[:port] [addr[:port]]
+     dns server n address addr[:port] [addr[:port]] [addr[:port]] [addr[:port]]
      dns server n resolve-domains|exclude-domains domain [domain ...]
      dns server n dnssec yes|optional|no
      dns server n transport DoH|DoT|plain
@@ -187,8 +187,9 @@ configuration.
   already configured DNS servers with the same server id.
 
   The ``address`` option configures the IPv4 and / or IPv6 address of
-  the DNS server. Optionally a port can be appended after a colon. IPv6
-  addresses need to be enclosed in brackets if a port is appended.
+  the DNS server. Up to two addresses per address family can be specified.
+  Optionally a port can be appended after a colon. IPv6 addresses need to
+  be enclosed in brackets if a port is appended.
 
   The ``resolve-domains`` and ``exclude-domains`` options take one or
   more DNS domains which are explicitly resolved or explicitly not resolved
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 9f2a7d5e..18f6e58b 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -117,17 +117,25 @@ dns_server_addr_parse(struct dns_server *server, const char *addr)
 
     if (ai->ai_family == AF_INET)
     {
+        if (server->addr4_count >= SIZE(server->addr4))
+        {
+            return false;
+        }
         struct sockaddr_in *sin = (struct sockaddr_in *)ai->ai_addr;
-        server->addr4_defined = true;
-        server->addr4.s_addr = ntohl(sin->sin_addr.s_addr);
-        server->port4 = port;
+        server->addr4[server->addr4_count].in.a4.s_addr = ntohl(sin->sin_addr.s_addr);
+        server->addr4[server->addr4_count].port = port;
+        server->addr4_count += 1;
     }
     else
     {
+        if (server->addr6_count >= SIZE(server->addr6))
+        {
+            return false;
+        }
         struct sockaddr_in6 *sin6 = (struct sockaddr_in6 *)ai->ai_addr;
-        server->addr6_defined = true;
-        server->addr6 = sin6->sin6_addr;
-        server->port6 = port;
+        server->addr6[server->addr6_count].in.a6 = sin6->sin6_addr;
+        server->addr6[server->addr6_count].port = port;
+        server->addr6_count += 1;
     }
 
     freeaddrinfo(ai);
@@ -197,7 +205,7 @@ dns_options_verify(int msglevel, const struct dns_options *o)
         o->servers ? o->servers : o->servers_prepull;
     while (server)
     {
-        if (!server->addr4_defined && !server->addr6_defined)
+        if (server->addr4_count == 0 && server->addr6_count == 0)
         {
             msg(msglevel, "ERROR: dns server %ld does not have an address assigned", server->priority);
             return false;
@@ -376,26 +384,26 @@ setenv_dns_options(const struct dns_options *o, struct env_set *es)
 
     for (i = 1, s = o->servers; s != NULL; i++, s = s->next)
     {
-        if (s->addr4_defined)
-        {
-            setenv_dns_option(es, "dns_server_%d_address4", i, -1,
-                              print_in_addr_t(s->addr4.s_addr, 0, &gc));
-        }
-        if (s->port4)
+        for (j = 0; j < s->addr4_count; ++j)
         {
-            setenv_dns_option(es, "dns_server_%d_port4", i, -1,
-                              print_in_port_t(s->port4, &gc));
+            setenv_dns_option(es, "dns_server_%d_address4_%d", i, j + 1,
+                              print_in_addr_t(s->addr4[j].in.a4.s_addr, 0, &gc));
+            if (s->addr4[j].port)
+            {
+                setenv_dns_option(es, "dns_server_%d_port4_%d", i, j + 1,
+                                  print_in_port_t(s->addr4[j].port, &gc));
+            }
         }
 
-        if (s->addr6_defined)
+        for (j = 0; j < s->addr6_count; ++j)
         {
-            setenv_dns_option(es, "dns_server_%d_address6", i, -1,
-                              print_in6_addr(s->addr6, 0, &gc));
-        }
-        if (s->port6)
-        {
-            setenv_dns_option(es, "dns_server_%d_port6", i, -1,
-                              print_in_port_t(s->port6, &gc));
+            setenv_dns_option(es, "dns_server_%d_address6_%d", i, j + 1,
+                              print_in6_addr(s->addr6[j].in.a6, 0, &gc));
+            if (s->addr6[j].port)
+            {
+                setenv_dns_option(es, "dns_server_%d_port6", i, -1,
+                                  print_in_port_t(s->addr6[j].port, &gc));
+            }
         }
 
         if (s->domains)
@@ -439,12 +447,12 @@ show_dns_options(const struct dns_options *o)
     {
         msg(D_SHOW_PARMS, "  DNS server #%d:", i++);
 
-        if (server->addr4_defined)
+        for (int j = 0; j < server->addr4_count; ++j)
         {
-            const char *addr = print_in_addr_t(server->addr4.s_addr, 0, &gc);
-            if (server->port4)
+            const char *addr = print_in_addr_t(server->addr4[j].in.a4.s_addr, 0, &gc);
+            if (server->addr4[j].port)
             {
-                const char *port = print_in_port_t(server->port4, &gc);
+                const char *port = print_in_port_t(server->addr4[j].port, &gc);
                 msg(D_SHOW_PARMS, "    address4 = %s:%s", addr, port);
             }
             else
@@ -452,12 +460,12 @@ show_dns_options(const struct dns_options *o)
                 msg(D_SHOW_PARMS, "    address4 = %s", addr);
             }
         }
-        if (server->addr6_defined)
+        for (int j = 0; j < server->addr6_count; ++j)
         {
-            const char *addr = print_in6_addr(server->addr6, 0, &gc);
-            if (server->port6)
+            const char *addr = print_in6_addr(server->addr6[j].in.a6, 0, &gc);
+            if (server->addr6[j].port)
             {
-                const char *port = print_in_port_t(server->port6, &gc);
+                const char *port = print_in_port_t(server->addr6[j].port, &gc);
                 msg(D_SHOW_PARMS, "    address6 = [%s]:%s", addr, port);
             }
             else
diff --git a/src/openvpn/dns.h b/src/openvpn/dns.h
index 03a894f2..34f864dd 100644
--- a/src/openvpn/dns.h
+++ b/src/openvpn/dns.h
@@ -52,15 +52,22 @@ struct dns_domain {
     const char *name;
 };
 
+struct dns_server_addr
+{
+    union {
+        struct in_addr a4;
+        struct in6_addr a6;
+    } in;
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
+    size_t addr4_count;
+    size_t addr6_count;
+    struct dns_server_addr addr4[2];
+    struct dns_server_addr addr6[2];
     struct dns_domain *domains;
     enum dns_domain_type domain_type;
     enum dns_security dnssec;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 9105449c..7ea1994a 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1387,21 +1387,23 @@ tuntap_options_copy_dns(struct options *o)
         const struct dns_server *server = dns->servers;
         while (server)
         {
-            if (server->addr4_defined && tt->dns_len < N_DHCP_ADDR)
+            for (int i = 0; i < server->addr4_count; ++i)
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
+                if (tt->dns_len >= N_DHCP_ADDR)
+                {
+                    overflow = true;
+                    break;
+                }
+                tt->dns[tt->dns_len++] = server->addr4[i].in.a4.s_addr;
             }
-            else
+            for (int i = 0; i < server->addr6_count; ++i)
             {
-                overflow = true;
+                if (tt->dns6_len >= N_DHCP_ADDR)
+                {
+                    overflow = true;
+                    break;
+                }
+                tt->dns6[tt->dns6_len++] = server->addr6[i].in.a6;
             }
             server = server->next;
         }
@@ -8001,13 +8003,13 @@ add_option(struct options *options,
 
             struct dns_server *server = dns_server_get(&options->dns_options.servers, priority, &options->dns_options.gc);
 
-            if (streq(p[3], "address") && !p[6])
+            if (streq(p[3], "address") && !p[8])
             {
                 for (int i = 4; p[i]; i++)
                 {
                     if (!dns_server_addr_parse(server, p[i]))
                     {
-                        msg(msglevel, "--dns server %ld: malformed or duplicate address '%s'", priority, p[i]);
+                        msg(msglevel, "--dns server %ld: malformed address or maximum exceeded '%s'", priority, p[i]);
                         goto err;
                     }
                 }
-- 
2.34.1


