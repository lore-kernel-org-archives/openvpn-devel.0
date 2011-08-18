From: samuli@...515...
Date: Thu, 18 Aug 2011 10:25:34 +0300
Message-Id: <1313652334-15914-1-git-send-email-samuli@...515...>
In-Reply-To: <4E4B873F.6080009@...515...>
References: <4E4B873F.6080009@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Added whitespace handling for $KEY_CONFIG
	variable in easy-rsa/2.0/vars
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

Original $KEY_CONFIG variable generation in broke if $EASY_RSA had whitespa=
ce in
it. This patch fixes the issue in a POSIX-compliant way.

Signed-off-by: Tanel Rebane <tanel@...1495...>
Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
Tested-by: Samuli Sepp=C3=A4nen <samuli@...515...>
---
 easy-rsa/2.0/vars |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/easy-rsa/2.0/vars b/easy-rsa/2.0/vars
index 2ea1ced..780ecf6 100755
--- a/easy-rsa/2.0/vars
+++ b/easy-rsa/2.0/vars
@@ -26,7 +26,7 @@ export GREP=3D"grep"
 # This variable should point to
 # the openssl.cnf file included
 # with easy-rsa.
-export KEY_CONFIG=3D`$EASY_RSA/whichopensslcnf $EASY_RSA`
+export KEY_CONFIG=3D$("$EASY_RSA"/whichopensslcnf "$EASY_RSA")
=20
 # Edit this variable to point to
 # your soon-to-be-created key
--=20
1.7.4.1


