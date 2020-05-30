From: Antonio Quartulli <a@...2181...>
Date: Sat, 30 May 2020 02:05:56 +0200
Message-Id: <20200530000600.1680-4-a@...2181...>
In-Reply-To: <20200530000600.1680-1-a@...2181...>
References: <20200530000600.1680-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4 3/7] allow usage of --server-ipv6 even
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
Changes from v4:
- fix typ0 in message

Changes from v3:
- patchset rebased on top of pre-ipv6-only patchset

Changes from v4:
- change commit subject/message
- move ifconfig-ipv6-pool check change into 4/8


 src/openvpn/helper.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
index 34cfa6bd..277e6972 100644
--- a/src/openvpn/helper.c
+++ b/src/openvpn/helper.c
@@ -174,10 +174,11 @@ helper_client_server(struct options *o)
      */
     if (o->server_ipv6_defined)
     {
-        if (!o->server_defined)
+        if (o->client)
         {
-            msg(M_USAGE, "--server-ipv6 must be used together with --server");
+            msg(M_USAGE, "--server-ipv6 and --client cannot be used together");
         }
+
         if (o->server_flags & SF_NOPOOL)
         {
             msg( M_USAGE, "--server-ipv6 is incompatible with 'nopool' option" );
@@ -187,6 +188,9 @@ helper_client_server(struct options *o)
             msg( M_USAGE, "--server-ipv6 already defines an ifconfig-ipv6-pool, so you can't also specify --ifconfig-pool explicitly");
         }
 
+        o->mode = MODE_SERVER;
+        o->tls_server = true;
+
         /* local ifconfig is "base address + 1" and "+2" */
         o->ifconfig_ipv6_local =
             print_in6_addr( add_in6_addr( o->server_network_ipv6, 1), 0, &o->gc );
-- 
2.26.2


