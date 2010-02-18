From: David Sommerseth <openvpn.list@...1114...>
Date: Thu, 18 Feb 2010 21:23:48 +0100
Message-Id: <1266524628-9222-1-git-send-email-openvpn.list@...1114...>
Subject: [Openvpn-devel] [PATCH] Do not randomize resolving of IP addresses
	in getaddr()
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
Cc: David Sommerseth <dazo@...384...>

From: David Sommerseth <dazo@...384...>

Based on a discussion on the mailing list and in the IRC meeting Feb 18,
it was decided to remove get_random() from the getaddr() function as that
can conflict with round-robin/randomization done by DNS servers.

This change must be documented in the release notes.

Signed-off-by: David Sommerseth <dazo@...384...>
---
 socket.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/socket.c b/socket.c
index fecc398..e42ccb9 100644
--- a/socket.c
+++ b/socket.c
@@ -212,12 +212,11 @@ getaddr (unsigned int flags,
 		++n;
 	      ASSERT (n >= 2);
 
-	      msg (D_RESOLVE_ERRORS, "RESOLVE: NOTE: %s resolves to %d addresses, choosing one by random",
+	      msg (D_RESOLVE_ERRORS, "RESOLVE: NOTE: %s resolves to %d addresses, choosing the first resolved IP address",
 		   hostname,
 		   n);
 
-	      /* choose address randomly, for basic load-balancing capability */
-	      ia.s_addr = *(in_addr_t *) (h->h_addr_list[get_random () % n]);
+	      ia.s_addr = *(in_addr_t *) (h->h_addr_list[0]);
 	    }
 	}
 
-- 
1.6.6


