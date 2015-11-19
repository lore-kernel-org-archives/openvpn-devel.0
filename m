Sender: Trochalakis Christos <yatiohi@...277...>
Date: Thu, 19 Nov 2015 14:47:23 +0200
From: Christos Trochalakis <yatiohi@...2090...>
Message-ID: <20151119124723.GA10830@...2091...>
References: <20151118145347.GT24952@...1296...>
MIME-Version: 1.0
In-Reply-To: <20151118145347.GT24952@...1296...>
Subject: [Openvpn-devel] [PATCH] Adjust server-ipv6 documentation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

ifconfig-ipv6-pool starts at 0x1000 and not 0x10000 since v2.3
c55e9562: Implement IPv6 interface config with non-/64 prefix lengths

Signed-off-by: Christos Trochalakis <yatiohi@...2090...>
---

You were right about nopool, I assumed that it was about a server-ipv6
nopool option.

 src/openvpn/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
index 339e2ae..62f88ec 100644
--- a/src/openvpn/helper.c
+++ b/src/openvpn/helper.c
@@ -167,7 +167,7 @@ helper_client_server (struct options *o)
    * push "tun-ipv6"
    * ifconfig-ipv6 2001:db8::1 2001:db8::2
    * if !nopool: 
-   *   ifconfig-ipv6-pool 2001:db8::1:0/64
+   *   ifconfig-ipv6-pool 2001:db8::1000/64
    * 
    */
    if ( o->server_ipv6_defined )
-- 
2.6.2


