From: samuli@...515...
Date: Mon,  9 May 2016 21:55:45 +0300
Message-Id: <1462820145-24669-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Improve LZO, PAM and OpenSSL documentation
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

Patch provided by Trac user dogbert2

Trac #590

Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
---
 INSTALL | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/INSTALL b/INSTALL
index 2401f7c..5be2ad5 100644
--- a/INSTALL
+++ b/INSTALL
@@ -16,6 +16,10 @@ QUICK START:
=20
     See INSTALL-win32.txt
=20
+  Compile OpenVPN with OpenSSL/LZO built from source tarballs
+
+    See INSTALL-nonstandard.txt
+
 *************************************************************************
=20
 To download OpenVPN, go to:
@@ -71,11 +75,26 @@ REQUIRES:
       a virtual point-to-point IP or Ethernet device.  See
       TUN/TAP Driver Configuration section below for more info.
=20
+  (2) PAM/PAM-Devel (Pluggable Authentication Modules).  In most
+      Linux distributions, these packages are usually listed as
+      the following (here is what they look like on Fedora):
+
+      pam-1.1.8-18.fc22.x86_64.rpm (64-bit package)
+      pam-devel-1.1.8-18.fc.22.x86_64.rpm (64-bit package)
+
 OPTIONAL (but recommended):
   (1) OpenSSL library, necessary for encryption, version 0.9.8 or higher
-      required, available from http://www.openssl.org/
+      required, available from http://www.openssl.org/.  If you build
+      OpenSSL from source tarball, you will need to let OpenVPN-2.3.x
+      know where the libraries and header files were installed to:
+
+      If you configured OpenSSL with stock options, it will install
+      the headers (i.e. - .h files) in /usr/local/ssl/include and
+      the libraries (i.e. - .a or .so files) in /usr/local/ssl/lib/openssl
+
   (2) PolarSSL library, an alternative for encryption, version 1.1 or high=
er
       required, available from https://polarssl.org/
+
   (3) LZO real-time compression library, required for link compression,
       available from http://www.oberhumer.com/opensource/lzo/
       OpenBSD users can use ports or packages to install lzo, but remember
--=20
2.5.5


