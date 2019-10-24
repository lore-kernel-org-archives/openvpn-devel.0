From: Richard Bonhomme <tincanteksup@...277...>
Date: Thu, 24 Oct 2019 18:44:14 +0100
Message-Id: <20191024174414.18821-1-tincanteksup@...277...>
Subject: [Openvpn-devel] [PATCH] Ignore --pull-filter for --mode server
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

Closes trac#1164

Signed-off-by: Richard Bonhomme <tincanteksup@...277...>
---
 src/openvpn/options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 752f5f2c..796e632e 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2233,7 +2233,7 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
         }
         if (options->pull_filter_list)
         {
-            msg(M_USAGE, "--pull-filter cannot be used with --mode server");
+            msg(M_WARN, "--pull-filter ignored for --mode server");
         }
         if (!(proto_is_udp(ce->proto) || ce->proto == PROTO_TCP_SERVER))
         {
-- 
2.17.1


