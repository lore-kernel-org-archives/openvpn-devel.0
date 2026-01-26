From: Gert Doering <gert@...1296...>
Date: Mon, 26 Jan 2026 15:54:26 +0100
Message-ID: <20260126145432.31249-1-gert@...1296...>
In-Reply-To: <gerrit.1769435786000.I87679949bdef6319d7490d561f0136633244c2b9@...2715...>
References: <gerrit.1769435786000.I87679949bdef6319d7490d561f0136633244c2b9@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] socket: Remove ifdef for SO_{RCV, SND}BUF
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

From: Frank Lichtenheld <frank@...2641...>

Seems all our platforms define it.

Reported-by: Marc Heuse <marc@...2953...>
Github: Fixes OpenVPN/openvpn#965
Change-Id: I87679949bdef6319d7490d561f0136633244c2b9
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1486
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1486
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 331249d..58ccda9 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -419,57 +419,45 @@
 static int
 socket_get_sndbuf(socket_descriptor_t sd)
 {
-#if defined(SOL_SOCKET) && defined(SO_SNDBUF)
     int val;
-    socklen_t len;
+    socklen_t len = sizeof(val);
 
-    len = sizeof(val);
     if (getsockopt(sd, SOL_SOCKET, SO_SNDBUF, (void *)&val, &len) == 0 && len == sizeof(val))
     {
         return val;
     }
-#endif
     return 0;
 }
 
 static void
 socket_set_sndbuf(socket_descriptor_t sd, int size)
 {
-#if defined(SOL_SOCKET) && defined(SO_SNDBUF)
     if (setsockopt(sd, SOL_SOCKET, SO_SNDBUF, (void *)&size, sizeof(size)) != 0)
     {
         msg(M_WARN, "NOTE: setsockopt SO_SNDBUF=%d failed", size);
     }
-#endif
 }
 
 static int
 socket_get_rcvbuf(socket_descriptor_t sd)
 {
-#if defined(SOL_SOCKET) && defined(SO_RCVBUF)
     int val;
-    socklen_t len;
+    socklen_t len = sizeof(val);
 
-    len = sizeof(val);
     if (getsockopt(sd, SOL_SOCKET, SO_RCVBUF, (void *)&val, &len) == 0 && len == sizeof(val))
     {
         return val;
     }
-#endif
     return 0;
 }
 
-static bool
+static void
 socket_set_rcvbuf(socket_descriptor_t sd, int size)
 {
-#if defined(SOL_SOCKET) && defined(SO_RCVBUF)
     if (setsockopt(sd, SOL_SOCKET, SO_RCVBUF, (void *)&size, sizeof(size)) != 0)
     {
         msg(M_WARN, "NOTE: setsockopt SO_RCVBUF=%d failed", size);
-        return false;
     }
-    return true;
-#endif
 }
 
 void

