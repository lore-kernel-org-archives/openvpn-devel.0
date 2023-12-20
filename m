From: Frank Lichtenheld <frank@...2641...>
Date: Wed, 20 Dec 2023 14:36:37 +0100
Message-Id: <20231220133637.60996-1-frank@...2641...>
In-Reply-To: <gerrit.1702561084000.I21a36d24f8e213c780f55acbe3e4df555c93542a@...2715...>
References: <gerrit.1702561084000.I21a36d24f8e213c780f55acbe3e4df555c93542a@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] tun.c: don't attempt to delete DNS and
 WINS servers if they're not set
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

Commits

    1c4a47f7 ("wintun: set adapter properties via interactive service")
    18826de5 ("Set WINS servers via interactice service")

added functionality of add/remove DNS/WINS via interactive
service, which is used mostly by dco-win and wintun (tap-windows6
normally uses DHCP). There is a check in code - if DNS/WINS addresses
are not pushed, nothing is added.

However, due to bug we always attempted to remove DNS/WINS,
even if nothing was added. Removing WINS, for example, could take
up to 3 seconds.

This change fixes this by improving check "has DNS/WINS been pushed?".

While on it, convert do_XXX_service() functions to "void" from "bool",
since we never check their return values.

Change-Id: I21a36d24f8e213c780f55acbe3e4df555c93542a
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/482
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index f1b8699..8e96149 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -147,17 +147,16 @@
     return ret;
 }
 
-static bool
+static void
 do_dns_domain_service(bool add, const struct tuntap *tt)
 {
-    bool ret = false;
     ack_message_t ack;
     struct gc_arena gc = gc_new();
     HANDLE pipe = tt->options.msg_channel;
 
     if (!tt->options.domain) /* no  domain to add or delete */
     {
-        return true;
+        goto out;
     }
 
     /* Use dns_cfg_msg with addr_len = 0 for setting only the DOMAIN */
@@ -195,17 +194,14 @@
     }
 
     msg(M_INFO, "DNS domain %s using service", (add ? "set" : "deleted"));
-    ret = true;
 
 out:
     gc_free(&gc);
-    return ret;
 }
 
-static bool
+static void
 do_dns_service(bool add, const short family, const struct tuntap *tt)
 {
-    bool ret = false;
     ack_message_t ack;
     struct gc_arena gc = gc_new();
     HANDLE pipe = tt->options.msg_channel;
@@ -213,9 +209,10 @@
     int addr_len = add ? len : 0;
     const char *ip_proto_name = family == AF_INET6 ? "IPv6" : "IPv4";
 
-    if (addr_len == 0 && add) /* no addresses to add */
+    if (len == 0)
     {
-        return true;
+        /* nothing to do */
+        goto out;
     }
 
     /* Use dns_cfg_msg with domain = "" for setting only the DNS servers */
@@ -272,26 +269,23 @@
     }
 
     msg(M_INFO, "%s dns servers %s using service", ip_proto_name, (add ? "set" : "deleted"));
-    ret = true;
 
 out:
     gc_free(&gc);
-    return ret;
 }
 
-static bool
+static void
 do_wins_service(bool add, const struct tuntap *tt)
 {
-    bool ret = false;
     ack_message_t ack;
     struct gc_arena gc = gc_new();
     HANDLE pipe = tt->options.msg_channel;
-    int len = tt->options.wins_len;
-    int addr_len = add ? len : 0;
+    int addr_len = add ? tt->options.wins_len : 0;
 
-    if (addr_len == 0 && add) /* no addresses to add */
+    if (tt->options.wins_len == 0)
     {
-        return true;
+        /* nothing to do */
+        goto out;
     }
 
     wins_cfg_message_t wins = {
@@ -338,11 +332,9 @@
     }
 
     msg(M_INFO, "WINS servers %s using service", (add ? "set" : "deleted"));
-    ret = true;
 
 out:
     gc_free(&gc);
-    return ret;
 }
 
 static bool
@@ -7019,10 +7011,7 @@
             {
                 do_dns_domain_service(false, tt);
             }
-            if (tt->options.dns6_len > 0)
-            {
-                do_dns_service(false, AF_INET6, tt);
-            }
+            do_dns_service(false, AF_INET6, tt);
             delete_route_connected_v6_net(tt);
             do_address_service(false, AF_INET6, tt);
         }

