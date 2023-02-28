From: Heiko Hund <heiko@...2662...>
Date: Tue, 28 Feb 2023 05:41:42 +0100
Message-Id: <20230228044142.39803-1-heiko@...2662...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] dns option: remove support for
 exclude-domains
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

No DNS resolver currently supports this and it is not possible to
emulate the behavior without the chance of errors. Finding the
effective default system DNS server(s) to specify the exclude
DNS routes is not trivial and cannot be verified to be correct
without resolver internal knowledge. So, it is better to not
support this instead of supporting it, but incorrectly.

Signed-off-by: Heiko Hund <heiko@...2662...>
---
 doc/man-sections/client-options.rst | 14 +++++---------
 src/openvpn/dns.c                   | 13 ++-----------
 src/openvpn/dns.h                   |  7 -------
 src/openvpn/options.c               | 16 ----------------
 4 files changed, 7 insertions(+), 43 deletions(-)

diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-options.rst
index 0b973adf..85d5610f 100644
--- a/doc/man-sections/client-options.rst
+++ b/doc/man-sections/client-options.rst
@@ -169,7 +169,7 @@ configuration.
 
      dns search-domains domain [domain ...]
      dns server n address addr[:port] [addr[:port]] [addr[:port]] [addr[:port]]
-     dns server n resolve-domains|exclude-domains domain [domain ...]
+     dns server n resolve-domains domain [domain ...]
      dns server n dnssec yes|optional|no
      dns server n transport DoH|DoT|plain
      dns server n sni server-name
@@ -191,14 +191,10 @@ configuration.
   Optionally a port can be appended after a colon. IPv6 addresses need to
   be enclosed in brackets if a port is appended.
 
-  The ``resolve-domains`` and ``exclude-domains`` options take one or
-  more DNS domains which are explicitly resolved or explicitly not resolved
-  by a server. Only one of the options can be configured for a server.
-  ``resolve-domains`` is used to define a split-dns setup, where only
-  given domains are resolved by a server. ``exclude-domains`` is used to
-  define domains which will never be resolved by a server (e.g. domains
-  which can only be resolved locally). Systems which do not support fine
-  grained DNS domain configuration, will ignore these settings.
+  The ``resolve-domains`` option takes one or more DNS domains used to define
+  a split-dns or dns-routing setup, where only the given domains are resolved
+  by the server. Systems which do not support fine grained DNS domain
+  configuration, will ignore this setting.
 
   The ``dnssec`` option is used to configure validation of DNSSEC records.
   While the exact semantics may differ for resolvers on different systems,
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 18f6e58b..b1486c86 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -408,11 +408,9 @@ setenv_dns_options(const struct dns_options *o, struct env_set *es)
 
         if (s->domains)
         {
-            const char *format = s->domain_type == DNS_RESOLVE_DOMAINS ?
-                                 "dns_server_%d_resolve_domain_%d" : "dns_server_%d_exclude_domain_%d";
             for (j = 1, d = s->domains; d != NULL; j++, d = d->next)
             {
-                setenv_dns_option(es, format, i, j, d->name);
+                setenv_dns_option(es, "dns_server_%d_resolve_domain_%d", i, j, d->name);
             }
         }
 
@@ -491,14 +489,7 @@ show_dns_options(const struct dns_options *o)
         struct dns_domain *domain = server->domains;
         if (domain)
         {
-            if (server->domain_type == DNS_RESOLVE_DOMAINS)
-            {
-                msg(D_SHOW_PARMS, "    resolve domains:");
-            }
-            else
-            {
-                msg(D_SHOW_PARMS, "    exclude domains:");
-            }
+            msg(D_SHOW_PARMS, "    resolve domains:");
             while (domain)
             {
                 msg(D_SHOW_PARMS, "      %s", domain->name);
diff --git a/src/openvpn/dns.h b/src/openvpn/dns.h
index 34f864dd..22cb333b 100644
--- a/src/openvpn/dns.h
+++ b/src/openvpn/dns.h
@@ -27,12 +27,6 @@
 #include "buffer.h"
 #include "env_set.h"
 
-enum dns_domain_type {
-    DNS_DOMAINS_UNSET,
-    DNS_RESOLVE_DOMAINS,
-    DNS_EXCLUDE_DOMAINS
-};
-
 enum dns_security {
     DNS_SECURITY_UNSET,
     DNS_SECURITY_NO,
@@ -69,7 +63,6 @@ struct dns_server {
     struct dns_server_addr addr4[2];
     struct dns_server_addr addr6[2];
     struct dns_domain *domains;
-    enum dns_domain_type domain_type;
     enum dns_security dnssec;
     enum dns_server_transport transport;
     const char *sni;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 7ea1994a..19731b53 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -8016,22 +8016,6 @@ add_option(struct options *options,
             }
             else if (streq(p[3], "resolve-domains"))
             {
-                if (server->domain_type == DNS_EXCLUDE_DOMAINS)
-                {
-                    msg(msglevel, "--dns server %ld: cannot use resolve-domains and exclude-domains", priority);
-                    goto err;
-                }
-                server->domain_type = DNS_RESOLVE_DOMAINS;
-                dns_domain_list_append(&server->domains, &p[4], &options->dns_options.gc);
-            }
-            else if (streq(p[3], "exclude-domains"))
-            {
-                if (server->domain_type == DNS_RESOLVE_DOMAINS)
-                {
-                    msg(msglevel, "--dns server %ld: cannot use exclude-domains and resolve-domains", priority);
-                    goto err;
-                }
-                server->domain_type = DNS_EXCLUDE_DOMAINS;
                 dns_domain_list_append(&server->domains, &p[4], &options->dns_options.gc);
             }
             else if (streq(p[3], "dnssec") && !p[5])
-- 
2.34.1


