From: samuli@...515...
Date: Wed, 22 Jun 2016 20:06:03 +0300
Message-Id: <1466615164-15527-2-git-send-email-samuli@...515...>
In-Reply-To: <1466615164-15527-1-git-send-email-samuli@...515...>
References: <1466615164-15527-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/3] Use an up-to-date easy-rsa URL on the
	man-page
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
 doc/openvpn.8 | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 7e9f9a0..c2169cf 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -4435,14 +4435,9 @@ will succeed, both OpenVPN
 peers will exchange temporary session keys, and the tunnel will begin
 passing data.
=20
-The OpenVPN distribution contains a set of scripts for
-managing RSA certificates & keys,
-located in the
-.I easy-rsa
-subdirectory.
-
-The easy-rsa package is also rendered in web form here:
-.I http://openvpn.net/easyrsa.html
+The OpenVPN project provides a set of scripts for
+managing RSA certificates & keys:
+.I https://github.com/OpenVPN/easy-rsa
 .\"*********************************************************
 .TP
 .B \-\-tls\-server
--=20
2.1.4


