From: Jon Kunkee <jkunkee@...2393...>
Date: Fri, 27 Apr 2018 20:26:40 +0000
Message-ID: <DM5PR21MB0185C678B00052EFCFF10283B08D0@...2394...>
Content-Language: en-US
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH: tap-windows6] Fix missing PRODUCT_PUBLISHER
 field in installer
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi all,

While working on ARM64 tap-windows6, I came up with this quick fix for a mi=
nor issue recently reported via IRC.

This is also a Github PR:
https://github.com/OpenVPN/tap-windows6/pull/51

(The ARM64 work is still underway; I'll start a separate thread about its c=
urrent state in a few hours.)

Thanks,
Jon


From 6eee7713363947083e76dbe5cf2ebf8eaf3936df Mon Sep 17 00:00:00 2001
From: Jon Kunkee <jkunkee@...2393...>
Date: Fri, 27 Apr 2018 12:01:07 -0700
Subject: [PATCH: tap-windows6] Fix missing PRODUCT_PUBLISHER field in
 installer

On Windows, the Product Publisher in Programs and Features is listed as
`${PRODUCT_PUBLISHER}` instead of "OpenVPN Technologies, Inc." as
reported on IRC.

This patch adds the `PRODUCT_PUBLISHER` variable to the buildtap.py
invocation of MakeNSIS. It also allows for `MakeNSIS` invocations with
spaces in them.
---
 buildtap.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/buildtap.py b/buildtap.py
index 6f506cd..9154ea7 100644
--- a/buildtap.py
+++ b/buildtap.py
@@ -328,13 +328,14 @@ class BuildTAPWindows(object):
             installer_type =3D "-oas"
         installer_file=3Dos.path.join(self.top, 'tap-windows'+installer_ty=
pe+'-'+kv['PRODUCT_VERSION']+'-I'+kv['PRODUCT_TAP_WIN_BUILD']+'.exe')
=20
-        installer_cmd =3D "\"%s\" -DDEVCON32=3D%s -DDEVCON64=3D%s -DDEVCON=
_BASENAME=3D%s -DPRODUCT_TAP_WIN_COMPONENT_ID=3D%s -DPRODUCT_NAME=3D%s -DPR=
ODUCT_VERSION=3D%s -DPRODUCT_TAP_WIN_BUILD=3D%s -DOUTPUT=3D%s -DIMAGE=3D%s =
%s" % \
+        installer_cmd =3D "\"\"%s\" -DDEVCON32=3D%s -DDEVCON64=3D%s -DDEVC=
ON_BASENAME=3D%s -DPRODUCT_TAP_WIN_COMPONENT_ID=3D%s -DPRODUCT_NAME=3D%s -D=
PRODUCT_PUBLISHER=3D\"%s\" -DPRODUCT_VERSION=3D%s -DPRODUCT_TAP_WIN_BUILD=
=3D%s -DOUTPUT=3D%s -DIMAGE=3D%s %s\"" % \
                         (self.makensis,
                          self.tifile(x64=3DFalse),
                          self.tifile(x64=3DTrue),
                          'tapinstall.exe',
                          kv['PRODUCT_TAP_WIN_COMPONENT_ID'],
                          kv['PRODUCT_NAME'],
+                         kv['PRODUCT_PUBLISHER'],
                          kv['PRODUCT_VERSION'],
                          kv['PRODUCT_TAP_WIN_BUILD'],
                          installer_file,
--=20
2.16.1.windows.4


