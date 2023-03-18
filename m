From: selva.nair@...277...
Date: Sat, 18 Mar 2023 10:13:30 -0400
Message-Id: <20230318141330.1315235-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Improve error message on short read from
 socks proxy
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

From: Selva Nair <selva.nair@...277...>

Change-Id: Id00006bf8ea705d02eff2cbfba7d841e1cdb6ae1
Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/socks.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index 6a672c25..2cf0cc9f 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -357,11 +357,16 @@ recv_socks_reply(socket_descriptor_t sd,
         size = recv(sd, &c, 1, MSG_NOSIGNAL);
 
         /* error? */
-        if (size != 1)
+        if (size < 0)
         {
             msg(D_LINK_ERRORS | M_ERRNO, "recv_socks_reply: TCP port read failed on recv()");
             return false;
         }
+        else if (size == 0)
+        {
+            msg(D_LINK_ERRORS, "ERROR: recv_socks_reply: empty response from socks server");
+            return false;
+        }
 
         if (len == 3)
         {
-- 
2.34.1


