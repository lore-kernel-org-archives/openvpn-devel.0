From: Antonio Quartulli <a@...2181...>
Date: Fri,  8 Jun 2018 13:20:14 +0800
Message-Id: <20180608052017.6696-6-a@...2181...>
In-Reply-To: <20180608052017.6696-1-a@...2181...>
References: <20180608052017.6696-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH v2 5/8] make server capable of starting with
 an IPv6-only tunnel
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
Cc: Antonio Quartulli <antonio@...515...>, Gert Doering <gert@...1296...>

From: Antonio Quartulli <antonio@...515...>

Due to the current logic it is not possible for a server
to create an IPv6-only tunnel, because OpenVPN mandates
the existance of an IPv4 configuration (even if fake).

This change relaxes this constraint and allows servers to
bring up tunnels without any IPv4 setting at all.

For the user this means that a server can be configured
with just the "--server-ipv6" directive and no "--server"
at all.

Trac: #208
Cc: Gert Doering <gert@...1296...>
Signed-off-by: Antonio Quartulli <antonio@...515...>
---
 src/openvpn/helper.c | 8 ++++++--
 src/openvpn/multi.c  | 3 ++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
index ff9df506..42ba5b2c 100644
--- a/src/openvpn/helper.c
+++ b/src/openvpn/helper.c
@@ -177,10 +177,11 @@ helper_client_server(struct options *o)
      */
     if (o->server_ipv6_defined)
     {
-        if (!o->server_defined)
+        if (o->client)
         {
-            msg(M_USAGE, "--server-ipv6 must be used together with --server");
+            msg(M_USAGE, "--server and --client cannot be used together");
         }
+
         if (o->server_flags & SF_NOPOOL)
         {
             msg( M_USAGE, "--server-ipv6 is incompatible with 'nopool' option" );
@@ -190,6 +191,9 @@ helper_client_server(struct options *o)
             msg( M_USAGE, "--server-ipv6 already defines an ifconfig-ipv6-pool, so you can't also specify --ifconfig-pool explicitly");
         }
 
+        o->mode = MODE_SERVER;
+        o->tls_server = true;
+
         /* local ifconfig is "base address + 1" and "+2" */
         o->ifconfig_ipv6_local =
             print_in6_addr( add_in6_addr( o->server_network_ipv6, 1), 0, &o->gc );
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 20f8611b..dbc8f370 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -388,7 +388,8 @@ multi_init(struct multi_context *m, struct context *t, bool tcp_mode, int thread
      * differently based on whether a tun or tap style
      * tunnel.
      */
-    if (t->options.ifconfig_pool_defined)
+    if (t->options.ifconfig_pool_defined
+        || t->options.ifconfig_ipv6_pool_defined)
     {
         int pool_type = IFCONFIG_POOL_INDIV;
 
-- 
2.17.1


