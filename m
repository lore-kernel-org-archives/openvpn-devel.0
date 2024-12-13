From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 13 Dec 2024 17:46:30 +0100
Message-Id: <20241213164630.266045-1-frank@...2641...>
In-Reply-To: <gerrit.1733989644000.I12b8bb26c0cb70e50b2d42b1c69018894e9f080c@...2715...>
References: <gerrit.1733989644000.I12b8bb26c0cb70e50b2d42b1c69018894e9f080c@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] dns: clone options via pointer instead
 of copy
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

Change-Id: I12b8bb26c0cb70e50b2d42b1c69018894e9f080c
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/835
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 15e7322..e22ea00 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -248,13 +248,15 @@
 }
 
 struct dns_options
-clone_dns_options(const struct dns_options o, struct gc_arena *gc)
+clone_dns_options(const struct dns_options *o, struct gc_arena *gc)
 {
     struct dns_options clone;
+
     memset(&clone, 0, sizeof(clone));
-    clone.search_domains = clone_dns_domains(o.search_domains, gc);
-    clone.servers = clone_dns_servers(o.servers, gc);
-    clone.servers_prepull = clone_dns_servers(o.servers_prepull, gc);
+    clone.search_domains = clone_dns_domains(o->search_domains, gc);
+    clone.servers = clone_dns_servers(o->servers, gc);
+    clone.servers_prepull = clone_dns_servers(o->servers_prepull, gc);
+
     return clone;
 }
 
diff --git a/src/openvpn/dns.h b/src/openvpn/dns.h
index a4ccb95..838ebe1 100644
--- a/src/openvpn/dns.h
+++ b/src/openvpn/dns.h
@@ -129,7 +129,8 @@
  * @param   gc          Pointer to the gc_arena to use for the clone
  * @return              The dns_options clone
  */
-struct dns_options clone_dns_options(const struct dns_options o, struct gc_arena *gc);
+struct dns_options clone_dns_options(const struct dns_options *o,
+                                     struct gc_arena *gc);
 
 /**
  * Saves and resets the server options, so that pulled ones don't mix in.
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index fa22eca..cc723ca 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3311,7 +3311,7 @@
     o->pre_connect->route_default_gateway = o->route_default_gateway;
     o->pre_connect->route_ipv6_default_gateway = o->route_ipv6_default_gateway;
 
-    o->pre_connect->dns_options = clone_dns_options(o->dns_options, &o->gc);
+    o->pre_connect->dns_options = clone_dns_options(&o->dns_options, &o->gc);
 
     /* NCP related options that can be overwritten by a push */
     o->pre_connect->ciphername = o->ciphername;
@@ -3364,7 +3364,7 @@
         /* Free DNS options and reset them to pre-pull state */
         gc_free(&o->dns_options.gc);
         struct gc_arena dns_gc = gc_new();
-        o->dns_options = clone_dns_options(pp->dns_options, &dns_gc);
+        o->dns_options = clone_dns_options(&pp->dns_options, &dns_gc);
         o->dns_options.gc = dns_gc;
 
         if (pp->client_nat_defined)

