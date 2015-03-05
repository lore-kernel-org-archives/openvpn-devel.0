From: Lev Stipakov <lstipakov@...277...>
Date: Thu,  5 Mar 2015 22:33:56 +0200
Message-Id: <1425587636-23338-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] Fix mssfix default value
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

Due to this bug, mssfix hasn't been assigned to fragment value
and used default value (1450) instead. As a consequence, TCP packets
get fragmented, which causes performance penalty.

Since dual stack patch
https://github.com/OpenVPN/openvpn/commit/23d61c56b9fd218c39ad151b01b7e2d6690e6093
OpenVPN uses options->connection_list, even for single remote.

This fix assigns mssfix value to fragment value for connection_entry
inside connection_list instead of connection_entry inside options struct
(which does not work for connection_list case).
---
 src/openvpn/options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 4ea03d1..20b37db 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2352,7 +2352,7 @@ options_postprocess_mutate_ce (struct options *o, struct connection_entry *ce)
     {
 #ifdef ENABLE_FRAGMENT
       if (ce->fragment)
-	o->ce.mssfix = ce->fragment;
+	ce->mssfix = ce->fragment;
 #else
       msg (M_USAGE, "--mssfix must specify a parameter");
 #endif      
-- 
1.9.1


