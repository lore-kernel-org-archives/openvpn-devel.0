From: samuli@...515...
Date: Wed, 29 Jun 2011 11:24:08 +0300
Message-Id: <1309335848-14414-3-git-send-email-samuli@...515...>
In-Reply-To: <1309335848-14414-1-git-send-email-samuli@...515...>
References: <1308302282-27985-1-git-send-email-samuli@...515...>
	<1309335848-14414-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/2] Made domake-win builds to use
	easy-rsa/2.0/openssl-1.0.0.cnf
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

Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
---
 install-win32/Makefile.am |    6 +++---
 install-win32/openvpn.nsi |    4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/install-win32/Makefile.am b/install-win32/Makefile.am
index 7211de2..75932fe 100644
--- a/install-win32/Makefile.am
+++ b/install-win32/Makefile.am
@@ -57,7 +57,7 @@ nodist_doc_DATA =3D tmp/license.txt
=20
 confdir =3D $(win32datadir)/config
 nodist_conf_DATA =3D \
-	tmp/openssl.cnf.sample \
+	tmp/openssl-1.0.0.cnf \
 	tmp/client.ovpn \
 	tmp/server.ovpn
 dist_conf_DATA =3D \
@@ -83,8 +83,8 @@ tmp/server.ovpn:	tmp $(top_srcdir)/sample-config-files/se=
rver.conf
 tmp/license.txt:	tmp $(top_srcdir)/COPYING $(top_srcdir)/COPYRIGHT.GPL
 	cat $(top_srcdir)/COPYING $(top_srcdir)/COPYRIGHT.GPL > tmp/license.txt
=20
-tmp/openssl.cnf.sample:	tmp $(top_srcdir)/easy-rsa/2.0/openssl.cnf
-	cp $(top_srcdir)/easy-rsa/2.0/openssl.cnf tmp/openssl.cnf.sample
+tmp/openssl-1.0.0.cnf:	tmp $(top_srcdir)/easy-rsa/2.0/openssl-1.0.0.cnf
+	cp $(top_srcdir)/easy-rsa/2.0/openssl-1.0.0.cnf tmp/openssl-1.0.0.cnf
=20
 clean-local:
 	-rm -fr tmp
diff --git a/install-win32/openvpn.nsi b/install-win32/openvpn.nsi
index b6e4a07..f06c5aa 100755
--- a/install-win32/openvpn.nsi
+++ b/install-win32/openvpn.nsi
@@ -333,7 +333,7 @@ Section "${PRODUCT_NAME} RSA Certificate Management Scr=
ipts" SecOpenVPNEasyRSA
   SetOverwrite on
   SetOutPath "$INSTDIR\easy-rsa"
=20
-  File "${GEN}\easy-rsa\openssl.cnf.sample"
+  File "${GEN}\easy-rsa\openssl-1.0.0.cnf"
   File "${GEN}\easy-rsa\vars.bat.sample"
=20
   File "${GEN}\easy-rsa\init-config.bat"
@@ -850,7 +850,7 @@ Section "Uninstall"
   Delete "$INSTDIR\license.txt"
   Delete "$INSTDIR\Uninstall.exe"
=20
-  Delete "$INSTDIR\easy-rsa\openssl.cnf.sample"
+  Delete "$INSTDIR\easy-rsa\openssl-1.0.0.cnf"
   Delete "$INSTDIR\easy-rsa\vars.bat.sample"
   Delete "$INSTDIR\easy-rsa\init-config.bat"
   Delete "$INSTDIR\easy-rsa\README.txt"
--=20
1.7.4.1


