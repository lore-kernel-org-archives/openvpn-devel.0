From: samuli@...515...
Date: Wed, 22 Oct 2014 10:07:39 +0300
Message-Id: <1413961660-19251-2-git-send-email-samuli@...515...>
In-Reply-To: <1413961660-19251-1-git-send-email-samuli@...515...>
References: <1413961660-19251-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2] Modification to address bug where
	OpenVPN enters state where it is unresponsive and cannot be
	terminated. Log output is continuous spew of "code=995" errors.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net
Cc: TDivine <tdivine@...1939...>

From: TDivine <tdivine@...1939...>

Adding new tap adapters while connected:
=C2=A0
https://community.openvpn.net/openvpn/ticket/430
---
 src/openvpn/tun.h | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 631b53c..d84b777 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -380,15 +380,24 @@ int tun_finalize (HANDLE h, struct overlapped_io *io,=
 struct buffer *buf);
 static inline bool
 tuntap_stop (int status)
 {
-  /*
-   * This corresponds to the STATUS_NO_SUCH_DEVICE
-   * error in tapdrvr.c.
-   */
-  if (status < 0)
-    {
-      return openvpn_errno () =3D=3D ERROR_FILE_NOT_FOUND;
-    }
-  return false;
+   /*
+    * This corresponds to the STATUS_NO_SUCH_DEVICE
+    * error in tapdrvr.c.
+    */
+   if (status < 0)
+   {
+      status =3D openvpn_errno();
+      switch (status)
+      {
+      case ERROR_FILE_NOT_FOUND:
+      case ERROR_OPERATION_ABORTED:
+         return true;
+
+      default:
+         return false;
+      }
+   }
+   return false;
 }
=20
 static inline int
--=20
1.9.1


