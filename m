From: James Yonan <james@...515...>
Date: Thu,  8 May 2014 16:50:33 -0600
Message-Id: <1399589436-8730-4-git-send-email-james@...515...>
In-Reply-To: <1399589436-8730-1-git-send-email-james@...515...>
References: <1399589436-8730-1-git-send-email-james@...515...>
Subject: [Openvpn-devel] [PATCH 3/6] Explicitly cast the third parameter of
	setsockopt to const void * to avoid warning.
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
Cc: James Yonan <james@...515...>

Signed-off-by: James Yonan <james@...515...>
---
 src/openvpn/socket.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 4e7e7f8..793cd9f 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -1023,7 +1023,7 @@ static inline void
 link_socket_set_tos (struct link_socket *ls)
 {
   if (ls && ls->ptos_defined)
-    setsockopt (ls->sd, IPPROTO_IP, IP_TOS, &ls->ptos, sizeof (ls->ptos));
+    setsockopt (ls->sd, IPPROTO_IP, IP_TOS, (const void *)&ls->ptos, sizeof (ls->ptos));
 }
 
 #endif
-- 
1.8.5.5


