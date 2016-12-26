From: David Sommerseth <davids@...515...>
Date: Mon, 26 Dec 2016 13:26:43 +0100
Message-Id: <1482755203-23968-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH] man: Remove references to no longer present
	IV_RGI6 peer-info
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

Commit 554504c5e2692c3e6cfd3f removed the IV_RGI6 peer-info singaling
but forgot to update the man page.  Removing this reference as well.

Signed-off-by: David Sommerseth <davids@...515...>
---
 doc/openvpn.8 | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index eb85d23..7bd6d9d 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -2989,10 +2989,6 @@ IV_LZO_STUB=1 -- if client was built with LZO stub capability
 
 IV_LZ4=1 -- if the client supports LZ4 compressions.
 
-IV_RGI6=1 -- if the client supports
-.B \-\-redirect\-gateway
-for ipv6
-
 IV_PROTO=2 -- if the client supports peer-id floating mechansim
 
 IV_NCP=2 -- negotiable ciphers, client supports
-- 
1.8.3.1


