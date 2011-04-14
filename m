From: =?utf-8?q?Samuli=20Sepp=C3=A4nen?= <samuli@...515...>
Date: Thu, 14 Apr 2011 17:43:40 +0300
Message-Id: <1302792220-9173-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fixed copying of tapinstall.exe to dist/bin
	when using prebuilt TAP-drivers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
---
 win/make_dist.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/win/make_dist.py b/win/make_dist.py
index 29eb2d2..edb0e6a 100644
--- a/win/make_dist.py
+++ b/win/make_dist.py
@@ -94,7 +94,7 @@ def main(config, tap=3DTrue):
     dest =3D {'amd64' : amd64, 'i386' : i386}
     for dirpath, dirnames, filenames in os.walk(home_fn(ti_dir)):
         for f in filenames:
-            if f =3D=3D 'devcon.exe':
+            if f in ( 'devcon.exe', 'tapinstall.exe' ):
                 dir_name =3D os.path.basename(dirpath)
                 src =3D os.path.join(dirpath, f)
                 dst =3D os.path.join(dest[dir_name],'tapinstall.exe')
--=20
1.6.3.3


