From: Steffan Karger <steffan.karger@...1435...>
Date: Mon, 28 Nov 2016 15:53:20 +0100
Message-ID: <1480344801-27855-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2] tls_process: don't set variable that's
	never read
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

Found by the clang static analyzer: the state_change variable is set,
but never read afterwards.  This code has been like this since 2005,
makes sense without setting state_change to true, and has worked fine
for the past 11 years.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/ssl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index e0cf1c5..991515b 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2809,7 +2809,6 @@ tls_process (struct tls_multi *multi,
 			  RELIABLE_ACK_SIZE, false);
       *to_link = buf;
       active = true;
-      state_change = true;
       dmsg (D_TLS_DEBUG, "Dedicated ACK -> TCP/UDP");
     }
 #endif
-- 
2.7.4


