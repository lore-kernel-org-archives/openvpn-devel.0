From: Christian Hesse <list@...1798...>
Date: Thu, 15 Dec 2016 14:26:36 +0100
Message-Id: <20161215132636.19843-1-list@...1798...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/1] replace deprecated LZ4 function
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
To: OpenVPN Development <openvpn-devel@lists.sourceforge.net>
Cc: Christian Hesse <mail@...1798...>

From: Christian Hesse <mail@...1798...>

The LZ4 function LZ4_compress_limitedOutput() is deprecated, compiler
gives warning:

warning: =E2=80=98LZ4_compress_limitedOutput=E2=80=99 is deprecated: use
LZ4_compress_default() instead

So replace the function.

Signed-off-by: Christian Hesse <mail@...1798...>
---
 src/openvpn/comp-lz4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/comp-lz4.c b/src/openvpn/comp-lz4.c
index 6b7c49b..90feaa5 100644
--- a/src/openvpn/comp-lz4.c
+++ b/src/openvpn/comp-lz4.c
@@ -87,7 +87,7 @@ do_lz4_compress(struct buffer *buf,
             return false;
         }
=20
-        zlen =3D LZ4_compress_limitedOutput((const char *)BPTR(buf), (char=
 *)BPTR(work), BLEN(buf), zlen_max );
+        zlen =3D LZ4_compress_default((const char *)BPTR(buf), (char *)BPT=
R(work), BLEN(buf), zlen_max );
=20
         if (zlen <=3D 0)
         {
--=20
2.11.0


