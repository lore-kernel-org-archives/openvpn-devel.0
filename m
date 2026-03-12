From: Gert Doering <gert@...1296...>
Date: Thu, 12 Mar 2026 17:41:25 +0100
Message-ID: <20260312164131.11378-1-gert@...1296...>
In-Reply-To: <gerrit.1772798203000.Ibfcc350c772227cfc0f2244fa2b1625dcb7e6fb5@...2715...>
References: <gerrit.1772798203000.Ibfcc350c772227cfc0f2244fa2b1625dcb7e6fb5@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] dns: Change arguments to
 setenv_dns_option to avoid sign-compare warning
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

From: Frank Lichtenheld <frank@...2641...>

The change is a bit big to fix just one compare warning,
but that is due to the highly interdependent code.

Change-Id: Ibfcc350c772227cfc0f2244fa2b1625dcb7e6fb5
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1558
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1558
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index a42d032..c146d75 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -476,20 +476,15 @@
     send_msg_iservice(o->msg_channel, &nrpt, sizeof(nrpt), &ack, "DNS");
 }
 
-#else /* ifdef _WIN32 */
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
+#else  /* ifdef _WIN32 */
 
 static void
-setenv_dns_option(struct env_set *es, const char *format, int i, int j, const char *value)
+setenv_dns_option(struct env_set *es, const char *format, size_t i, size_t j, const char *value)
 {
     char name[64];
     bool name_ok = false;
 
-    if (j < 0)
+    if (j == 0)
     {
         name_ok = checked_snprintf(name, sizeof(name), format, i);
     }
@@ -512,11 +507,11 @@
     struct gc_arena gc = gc_new();
     const struct dns_server *s;
     const struct dns_domain *d;
-    int i, j;
+    size_t i, j;
 
     for (i = 1, d = o->search_domains; d != NULL; i++, d = d->next)
     {
-        setenv_dns_option(es, "dns_search_domain_%d", i, -1, d->name);
+        setenv_dns_option(es, "dns_search_domain_%zu", i, 0, d->name);
     }
 
     for (i = 1, s = o->servers; s != NULL; i++, s = s->next)
@@ -525,17 +520,17 @@
         {
             if (s->addr[j].family == AF_INET)
             {
-                setenv_dns_option(es, "dns_server_%d_address_%d", i, j + 1,
+                setenv_dns_option(es, "dns_server_%zu_address_%zu", i, j + 1,
                                   print_in_addr_t(s->addr[j].in.a4.s_addr, IA_NET_ORDER, &gc));
             }
             else
             {
-                setenv_dns_option(es, "dns_server_%d_address_%d", i, j + 1,
+                setenv_dns_option(es, "dns_server_%zu_address_%zu", i, j + 1,
                                   print_in6_addr(s->addr[j].in.a6, 0, &gc));
             }
             if (s->addr[j].port)
             {
-                setenv_dns_option(es, "dns_server_%d_port_%d", i, j + 1,
+                setenv_dns_option(es, "dns_server_%zu_port_%zu", i, j + 1,
                                   print_in_port_t(s->addr[j].port, &gc));
             }
         }
@@ -544,32 +539,28 @@
         {
             for (j = 1, d = s->domains; d != NULL; j++, d = d->next)
             {
-                setenv_dns_option(es, "dns_server_%d_resolve_domain_%d", i, j, d->name);
+                setenv_dns_option(es, "dns_server_%zu_resolve_domain_%d", i, j, d->name);
             }
         }
 
         if (s->dnssec)
         {
-            setenv_dns_option(es, "dns_server_%d_dnssec", i, -1, dnssec_value(s->dnssec));
+            setenv_dns_option(es, "dns_server_%zu_dnssec", i, 0, dnssec_value(s->dnssec));
         }
 
         if (s->transport)
         {
-            setenv_dns_option(es, "dns_server_%d_transport", i, -1, transport_value(s->transport));
+            setenv_dns_option(es, "dns_server_%zu_transport", i, 0, transport_value(s->transport));
         }
         if (s->sni)
         {
-            setenv_dns_option(es, "dns_server_%d_sni", i, -1, s->sni);
+            setenv_dns_option(es, "dns_server_%zu_sni", i, 0, s->sni);
         }
     }
 
     gc_free(&gc);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static void
 updown_env_set(bool up, const struct dns_options *o, const struct tuntap *tt, struct env_set *es)
 {

