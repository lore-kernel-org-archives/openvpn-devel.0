Date: Sat, 10 Apr 2010 17:45:47 +0200
From: Alberto Gonzalez Iniesta <agi@...64...>
Message-ID: <20100410154547.GJ2689@...1330...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="cW+P/jduATWpL925"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Subject: [Openvpn-devel] [PATCH] Fixed typo in manpage
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--cW+P/jduATWpL925
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Just a tiny fix.

--=20
Alberto Gonzalez Iniesta    | Formaci=F3n, consultor=EDa y soporte t=E9cnico
agi@(inittab.org|debian.org)| en GNU/Linux y software libre
Encrypted mail preferred    | http://inittab.com

Key fingerprint =3D 9782 04E7 2B75 405C F5E9  0C81 C514 AF8E 4BA4 01C3

--cW+P/jduATWpL925
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="route_default_nil.patch"

Index: openvpn-2.1.0/openvpn.8
===================================================================
--- openvpn-2.1.0.orig/openvpn.8	2010-04-10 17:07:57.256694284 +0200
+++ openvpn-2.1.0/openvpn.8	2010-04-10 17:08:06.036696780 +0200
@@ -916,7 +916,7 @@
 otherwise 0.
 
 The default can be specified by leaving an option blank or setting
-it to "default".
+it to "nil".
 
 The
 .B network

--cW+P/jduATWpL925--

