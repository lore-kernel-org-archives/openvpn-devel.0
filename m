From: samuli@...515...
Date: Wed,  9 Nov 2011 11:49:36 +0200
Message-Id: <1320832176-11704-1-git-send-email-samuli@...515...>
In-Reply-To: <1320074961-3809-6-git-send-email-dejong@...1435...>
References: <1320074961-3809-6-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fixed a regression causing VS2008/Python
	build failure
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

From: Samuli Sepp=C3=A4nen <samuli@...515...>

Patch "Added options to switch between OpenSSL and PolarSSL and PKCS11" cau=
sed a
regression when building OpenVPN with Visual Studio 2008/Python build syste=
m.
The underlying cause was a wrong path to lzo2.lib.
---
 win/msvc.mak.in |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/win/msvc.mak.in b/win/msvc.mak.in
index d2babcf..26d7a33 100644
--- a/win/msvc.mak.in
+++ b/win/msvc.mak.in
@@ -33,7 +33,7 @@ INCLUDE_DIRS =3D -I$(OPENSSL)/include -I$(POLARSSL)/inclu=
de -I$(LZO)/include -I$(P
=20
 LIBS =3D $(OPENSSL_DYNAMIC) $(POLARSSL_DYNAMIC) $(PKCS11_HELPER_DYNAMIC) $=
(LZO_DYNAMIC) ws2_32.lib crypt32.lib iphlpapi.lib winmm.lib user32.lib gdi3=
2.lib advapi32.lib wininet.lib
=20
-LIB_DIRS =3D -LIBPATH:$(OPENSSL)\lib -LIBPATH:$(POLARSSL)\build\library -L=
IBPATH:$(PKCS11_HELPER)\lib -LIBPATH:$(LZO)
+LIB_DIRS =3D -LIBPATH:$(OPENSSL)\lib -LIBPATH:$(POLARSSL)\build\library -L=
IBPATH:$(PKCS11_HELPER)\lib -LIBPATH:$(LZO)\lib
=20
 EXE =3D openvpn.exe
=20
--=20
1.7.4.1


