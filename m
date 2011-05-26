From: David Sommerseth <davids@...1347...>
Date: Thu, 26 May 2011 10:31:54 +0200
Message-Id: <1306398714-10124-1-git-send-email-davids@...1347...>
Subject: [Openvpn-devel] [PATCH] Don't define ENABLE_PUSH_PEER_INFO if SSL
	is not available
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
Cc: David Sommerseth <davids@...1347...>

The push_peer_info feature depends on the SSL infrastructure and openvpn
will fail to build if ./configure --disable-crypto --disable-ssl is
used.  The solution is to not define ENABLE_PUSH_PEER_INFO if we don't
have crypto/ssl.

Signed-off-by: David Sommerseth <davids@...1347...>
---
 syshead.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/syshead.h b/syshead.h
index 5b86cad..82b94eb 100644
--- a/syshead.h
+++ b/syshead.h
@@ -681,7 +681,9 @@ socket_defined (const socket_descriptor_t sd)
 /*
  * Do we support pushing peer info?
  */
+#if defined(USE_CRYPTO) && defined(USE_SSL)
 #define ENABLE_PUSH_PEER_INFO
+#endif
 
 /*
  * Do we support internal client-side NAT?
-- 
1.7.4.4


