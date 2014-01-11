From: Gert Doering <gert@...1296...>
Date: Sat, 11 Jan 2014 12:50:36 +0100
Message-Id: <1389441036-12538-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH v2] Document issue with --chroot,
	/dev/urandom and PolarSSL.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

See trac#218

Signed-off-by: Gert Doering <gert@...1296...>
---
 doc/openvpn.8 | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 7736c63..f694080 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -2097,6 +2097,16 @@ In many cases, the
 parameter can point to an empty directory, however
 complications can result when scripts or restarts
 are executed after the chroot operation.
+
+Note: if OpenVPN is built using the PolarSSL SSL
+library,
+.B \-\-chroot
+will only work if a /dev/urandom device node is available
+inside the chroot directory
+.B dir.
+This is due to the way PolarSSL works (it wants to open
+/dev/urandom every time randomness is needed, not just once
+at startup) and nothing OpenVPN can influence.
 .\"*********************************************************
 .TP
 .B \-\-setcon context
-- 
1.8.3.2


