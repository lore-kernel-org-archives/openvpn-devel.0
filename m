From: Steffan Karger <steffan@...1856...>
Date: Wed, 20 Aug 2014 23:00:26 +0200
Message-Id: <1408568426-19601-2-git-send-email-steffan@...1856...>
In-Reply-To: <1408568426-19601-1-git-send-email-steffan@...1856...>
References: <1408568426-19601-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 2/2] Fix clang warning in options.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

fixed warning: expression which evaluates to zero treated as a
null pointer constant of type 'struct addrinfo *'

Seems to be innocent, but clang is correct that this is strange.
init_tun() expects two pointers, but options_string() tried to
feed it two uint32_t values.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/options.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index f536daa..84eb6ed 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2934,8 +2934,8 @@ options_string (const struct options *o,
 		     o->ifconfig_ipv6_local,
 		     o->ifconfig_ipv6_netbits,
 		     o->ifconfig_ipv6_remote,
-		     (in_addr_t)0,
-		     (in_addr_t)0,
+		     NULL,
+		     NULL,
 		     false,
 		     NULL);
       if (tt)
-- 
1.9.1


