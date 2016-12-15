From: Christian Hesse <list@...1798...>
Date: Thu, 15 Dec 2016 15:06:14 +0100
Message-Id: <20161215140614.24291-1-list@...1798...>
In-Reply-To: <1481808689.98151.88.camel@...1866...>
References: <1481808689.98151.88.camel@...1866...>
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
Cc: Christian Hesse <mail@...1798...>, David Woodhouse <dwmw2@...1866...>

From: Christian Hesse <mail@...1798...>

The LZ4 function LZ4_compress_limitedOutput() is deprecated, compiler
gives warning:

warning: =E2=80=98LZ4_compress_limitedOutput=E2=80=99 is deprecated: use
LZ4_compress_default() instead

The new function LZ4_compress_default() appeared in r129 (1.7.0), so
replace the function there.

Signed-off-by: Christian Hesse <mail@...1798...>
---
 src/openvpn/comp-lz4.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/openvpn/comp-lz4.c b/src/openvpn/comp-lz4.c
index 6b7c49b..a6ce4f7 100644
--- a/src/openvpn/comp-lz4.c
+++ b/src/openvpn/comp-lz4.c
@@ -87,7 +87,11 @@ do_lz4_compress(struct buffer *buf,
             return false;
         }
=20
+#if defined LZ4_VERSION_NUMBER && LZ4_VERSION_NUMBER >=3D 10700
+        zlen =3D LZ4_compress_default((const char *)BPTR(buf), (char *)BPT=
R(work), BLEN(buf), zlen_max );
+#else
         zlen =3D LZ4_compress_limitedOutput((const char *)BPTR(buf), (char=
 *)BPTR(work), BLEN(buf), zlen_max );
+#endif
=20
         if (zlen <=3D 0)
         {
--=20
2.11.0


