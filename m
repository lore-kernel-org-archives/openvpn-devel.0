Message-ID: <53F1DA95.7020701@...1085...>
Date: Mon, 18 Aug 2014 05:51:01 -0500
From: Josh Cepek <josh.cepek@...1085...>
MIME-Version: 1.0
References: <53F1D97B.8010801@...1085...>
In-Reply-To: <53F1D97B.8010801@...1085...>
Subject: [Openvpn-devel] [PATCH] Push an IPv6 CIDR mask used by the server,
 not the pool's size
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Correctly handle CIDR masks when pushing clients addressing from an IPv6
pool. This change ignores the incorrectly used `bits` argument to the
--ifconfig-ipv6-pool option.

The code to save any provided CIDR mask after the pool IP is left in;
this may someday become useful when we move to allow IPv6 pools without
relying on an IPv4 pool assignment.

Signed-off-by: Josh Cepek <josh.cepek@...1085...>
---
 doc/openvpn.8       | 5 +----
 src/openvpn/multi.c | 2 +-
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index f2911c0..e9d8700 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -5533,10 +5533,7 @@ Is only accepted if ``--mode server'' or ``--server'' is set.
 Specify an IPv6 address pool for dynamic assignment to clients.  The
 pool starts at
 .B ipv6addr
-and increments by +1 for every new client (linear mode).  The
-.B /bits
-setting controls the size of the pool.  Due to implementation details,
-the pool size must be between /64 and /112.
+and matches the offset determined from the start of the IPv4 pool.
 .TP
 .B --ifconfig-ipv6-push ipv6addr/bits ipv6remote
 for ccd/ per-client static IPv6 interface configuration, see
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 5910154..b725d1b 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1361,7 +1361,7 @@ multi_select_virtual_addr (struct multi_context *m, struct multi_instance *mi)
 	      mi->context.c2.push_ifconfig_ipv6_remote = 
 		    mi->context.c1.tuntap->local_ipv6;
 	      mi->context.c2.push_ifconfig_ipv6_netbits = 
-		    mi->context.options.ifconfig_ipv6_pool_netbits;
+		    mi->context.options.ifconfig_ipv6_netbits;
 	      mi->context.c2.push_ifconfig_ipv6_defined = true;
 	    }
 	}
-- 
1.9.1



