From: samuli@...515...
Date: Mon,  2 Jul 2012 17:27:53 +0300
Message-Id: <1341239273-7509-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Incrementing version number of tap-windows
	to 9.9.1
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

Tap-windows driver is now built using it's own buildsystem, whereas earlier=
 it
was built using the Python-based buildsystem in OpenVPN. Incrementing relea=
se
date and version number in tap-windows/version.m4 to help differentiate the=
se
new drivers from the old ones.

Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
---
 version.m4 |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/version.m4 b/version.m4
index 2d21396..4ac0561 100644
--- a/version.m4
+++ b/version.m4
@@ -1,6 +1,6 @@
 dnl define the TAP version
 define([PRODUCT_NAME], [TAP-Windows])
-define([PRODUCT_VERSION], [9.9.0_master])
+define([PRODUCT_VERSION], [9.9.1])
 define([PRODUCT_VERSION_RESOURCE], [9,0,0,9])
 define([PRODUCT_TAP_WIN_COMPONENT_ID], [tap0901])
 define([PRODUCT_TAP_WIN_MAJOR], [9])
@@ -8,4 +8,4 @@ define([PRODUCT_TAP_WIN_MINOR], [9])
 define([PRODUCT_TAP_WIN_PROVIDER], [TAP-Windows Provider V9])
 define([PRODUCT_TAP_WIN_CHARACTERISTICS], [0x81])
 define([PRODUCT_TAP_WIN_DEVICE_DESCRIPTION], [TAP-Windows Adapter V9])
-define([PRODUCT_TAP_WIN_RELDATE], [04/19/2010])
+define([PRODUCT_TAP_WIN_RELDATE], [07/02/2012])
--=20
1.7.5.4


