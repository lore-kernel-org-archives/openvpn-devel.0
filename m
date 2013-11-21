From: Arne Schwabe <arne@...1227...>
Date: Thu, 21 Nov 2013 21:08:05 +0100
Message-Id: <1385064495-25877-4-git-send-email-arne@...1227...>
In-Reply-To: <1385064495-25877-1-git-send-email-arne@...1227...>
References: <1385064495-25877-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 04/14] Fix assertion when SIGUSR1 is
	received while getaddrinfo is successful
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
 src/openvpn/socket.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index babbb90..54e52d6 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -227,18 +227,20 @@ openvpn_getaddrinfo (unsigned int flags,
               get_signal (signal_received);
               if (*signal_received) /* were we interrupted by a signal? */
                 {
-                  if (0 == status) {
-                    ASSERT(res);
-                    freeaddrinfo(*res);
-                    res = NULL;
-                  }
                   if (*signal_received == SIGUSR1) /* ignore SIGUSR1 */
                     {
                       msg (level, "RESOLVE: Ignored SIGUSR1 signal received during DNS resolution attempt");
                       *signal_received = 0;
                     }
                   else
-                    goto done;
+                    {
+                      if (0 == status) {
+                          ASSERT(res);
+                          freeaddrinfo(*res);
+                          res = NULL;
+                      }
+                      goto done;
+                    }
                 }
             }
 
-- 
1.7.9.5


