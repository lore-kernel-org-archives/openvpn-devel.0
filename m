From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 22 Sep 2023 12:43:34 +0200
Message-Id: <20230922104334.37619-1-frank@...2641...>
In-Reply-To: <gerrit.1677684971000.I7f422add22f3f01e9f47985065782dd67bca46eb@...2715...>
References: <gerrit.1677684971000.I7f422add22f3f01e9f47985065782dd67bca46eb@...2715...>
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

From: Heiko Hund <heiko@...2662...>

No DNS resolver currently supports this and it is not possible to
emulate the behavior without the chance of errors. Finding the
effective default system DNS server(s) to specify the exclude
DNS routes is not trivial and cannot be verified to be correct
without resolver internal knowledge. So, it is better to not
support this instead of supporting it, but incorrectly.

Change-Id: I7f422add22f3f01e9f47985065782dd67bca46eb
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Lev Stipakov <lstipakov@...277...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/39
This mail reflects revision 6 of this Change.
Acked-by according to Gerrit (reflected above):
lstipakov <lstipakov@...277...>

Submitter note:
Manually removed comma in documentation according to
https://gerrit.openvpn.net/c/openvpn/+/39/comment/c2458c42_e3d89d93/

        
diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-options.rst
index fe9ffa6..4555534 100644
--- a/doc/man-sections/client-options.rst
+++ b/doc/man-sections/client-options.rst
@@ -169,7 +169,7 @@
 
      dns search-domains domain [domain ...]
      dns server n address addr[:port] [addr[:port] ...]
-     dns server n resolve-domains|exclude-domains domain [domain ...]
+     dns server n resolve-domains domain [domain ...]
      dns server n dnssec yes|optional|no
      dns server n transport DoH|DoT|plain
      dns server n sni server-name
@@ -191,14 +191,10 @@
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
+  configuration will ignore this setting.
 
   The ``dnssec`` option is used to configure validation of DNSSEC records.
   While the exact semantics may differ for resolvers on different systems,
diff --git a/doc/man-sections/script-options.rst b/doc/man-sections/script-options.rst
index d73231e..8c0be0c 100644
--- a/doc/man-sections/script-options.rst
+++ b/doc/man-sections/script-options.rst
@@ -663,7 +663,6 @@
        dns_server_{n}_address_{m}
        dns_server_{n}_port_{m}
        dns_server_{n}_resolve_domain_{m}
-       dns_server_{n}_exclude_domain_{m}
        dns_server_{n}_dnssec
        dns_server_{n}_transport
        dns_server_{n}_sni
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index b7808db..51fca2f 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -402,11 +402,9 @@
 
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
 
@@ -484,14 +482,7 @@
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
index 162dec1..e497857 100644
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
@@ -68,7 +62,6 @@
     size_t addr_count;
     struct dns_server_addr addr[8];
     struct dns_domain *domains;
-    enum dns_domain_type domain_type;
     enum dns_security dnssec;
     enum dns_server_transport transport;
     const char *sni;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 17ce2b0..3e0cb62 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -514,7 +514,6 @@
     "                  Valid options are :\n"
     "                  address <addr[:port]> [addr[:port] ...] : server addresses 4/6\n"
     "                  resolve-domains <domain> [domain ...] : split domains\n"
-    "                  exclude-domains <domain> [domain ...] : domains not to resolve\n"
     "                  dnssec <yes|no|optional> : option to use DNSSEC\n"
     "                  type <DoH|DoT> : query server over HTTPS / TLS\n"
     "                  sni <domain> : DNS server name indication\n"
@@ -8022,22 +8021,6 @@
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

