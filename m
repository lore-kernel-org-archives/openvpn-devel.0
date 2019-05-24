From: Arne Schwabe <arne@...1227...>
Date: Fri, 24 May 2019 11:02:36 +0200
Message-Id: <20190524090236.10760-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Fix poll.h logic in syshead.h
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

Commit 62063162 change the include from sys/poll.h to just poll.h but
forgot to also change all occurrences of HAVE_SYS_POLL_H to HAVE_POLL_H.
---
 src/openvpn/syshead.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 2b4c49ff..899aa59e 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -600,7 +600,7 @@ socket_defined(const socket_descriptor_t sd)
 /*
  * Is poll available on this platform?
  */
-#if defined(HAVE_POLL) && defined(HAVE_SYS_POLL_H)
+#if defined(HAVE_POLL) && defined(HAVE_POLL_H)
 #define POLL 1
 #else
 #define POLL 0
-- 
2.21.0


