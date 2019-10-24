From: Richard Bonhomme <tincanteksup@...277...>
Date: Thu, 24 Oct 2019 22:48:32 +0100
Message-Id: <20191024214832.22737-1-tincanteksup@...277...>
In-Reply-To: <20191024174414.18821-1-tincanteksup@...277...>
References: <20191024174414.18821-1-tincanteksup@...277...>
Subject: [Openvpn-devel] [PATCH v2] Ignore --pull-filter for --mode server
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

OpenVPN-GUI (For Windows) currently always adds "--pull-filter"
which is a fatal error when also using "--mode server"

Using "--pull-filter" implicitly requires the use of "--pull".
Using "--mode server" and "--pull" is a fatal error which supercedes
"--pull-filter"

Safely ignore "--pull-filter" for "--mode server"

Trac: #1164

v2: Improve commit message, no functional changes.

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


