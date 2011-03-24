From: =?utf-8?q?Samuli=20Sepp=C3=A4nen?= <samuli@...515...>
Date: Thu, 24 Mar 2011 21:17:10 +0200
Message-Id: <1300994230-22739-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Clarified --client-config-dir section on
	the man-page.
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
 openvpn.8 |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/openvpn.8 b/openvpn.8
index 525ddd5..a40b0b8 100644
--- a/openvpn.8
+++ b/openvpn.8
@@ -2895,7 +2895,9 @@ as the client's X509 common name.  If a matching file
 exists, it will be opened and parsed for client-specific
 configuration options.  If no matching file is found, OpenVPN
 will instead try to open and parse a default file called
-"DEFAULT", which may be provided but is not required.
+"DEFAULT", which may be provided but is not required. Note that
+the configuration files must be readable by the OpenVPN process
+after it has dropped it's root privileges.
=20
 This file can specify a fixed IP address for a given
 client using
--=20
1.6.3.3


