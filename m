From: Antonio Quartulli <a@...2181...>
Date: Sun, 24 Jun 2018 04:11:12 +0800
Message-Id: <20180623201112.29973-1-a@...2181...>
In-Reply-To: <20180608052017.6696-6-a@...2181...>
References: <20180608052017.6696-6-a@...2181...>
Subject: [Openvpn-devel] [PATCH v3 5/8] allow usage of --server-ipv6 even
 when no --server is specified
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
Cc: Antonio Quartulli <antonio@...515...>

From: Antonio Quartulli <antonio@...515...>

Until now OpenVPN has not allowed to specify --server-ipv6
if no --server was also set. This constraint comes from the
fact that most of the IPv6 logic (i.e. ifconfig-pool handling)
relied on IPv4 components to be activated and configured as
well.

Now that the IPv6 code path has been made independent from
IPv4, it is finally possible to to relax the constraint
mentioned above and make it possible for the user to have a
configurations with --server-ipv6 only.

Trac: #208
Signed-off-by: Antonio Quartulli <antonio@...515...>
---

Changes from v2:
- patchset rebased on top of pre-ipv6-only patchset
- change commit subject/message
- move ifconfig-ipv6-pool check change into 4/8


 src/openvpn/helper.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

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
-- 
2.17.1


