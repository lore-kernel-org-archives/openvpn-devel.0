From: Eric Thorpe <eric@...1918...>
Date: Wed, 19 Aug 2020 18:42:58 -0700
Message-Id: <20200820014258.38377-1-eric@...1918...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fixes a bug in
 management_callback_send_cc_message, should be strlen instead of sizeof
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Signed-off-by: Eric Thorpe <eric@...1918...>
---
 src/openvpn/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index dfa045b0..a785934a 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -312,7 +312,7 @@ management_callback_send_cc_message(void *arg,
                                     const char *parameters)
 {
     struct context *c =3D (struct context *) arg;
-    size_t len =3D strlen(command) + 1 + sizeof(parameters) + 1;
+    size_t len =3D strlen(command) + 1 + strlen(parameters) + 1;
     if (len > PUSH_BUNDLE_SIZE)
     {
         return false;
--=20
2.25.1


