From: Arne Schwabe <arne@...1227...>
Date: Tue, 15 Sep 2015 11:23:38 +0200
Message-Id: <1442309019-7586-8-git-send-email-arne@...1227...>
In-Reply-To: <1442309019-7586-1-git-send-email-arne@...1227...>
References: <1442309019-7586-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 7/8] Remove unused function h_errno_msg
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

---
 src/openvpn/socket.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 5248f44..57d5962 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -71,23 +71,6 @@ sf2gaf(const unsigned int getaddr_flags,
  * Functions related to the translation of DNS names to IP addresses.
  */
 
-static const char*
-h_errno_msg(int h_errno_err)
-{
-  switch (h_errno_err)
-    {
-    case HOST_NOT_FOUND:
-      return "[HOST_NOT_FOUND] The specified host is unknown.";
-    case NO_DATA:
-      return "[NO_DATA] The requested name is valid but does not have an IP address.";
-    case NO_RECOVERY:
-      return "[NO_RECOVERY] A non-recoverable name server error occurred.";
-    case TRY_AGAIN:
-      return "[TRY_AGAIN] A temporary error occurred on an authoritative name server.";
-    }
-  return "[unknown h_errno value]";
-}
-
 /*
  * Translate IP addr or hostname to in_addr_t.
  * If resolve error, try again for
-- 
2.3.2 (Apple Git-55)


