From: ValdikSS <iam@...2070...>
Date: Sat, 16 Jan 2016 02:45:05 +0300
Message-Id: <1452901505-3898-1-git-send-email-iam@...2070...>
Subject: [Openvpn-devel] [PATCH] Clarify --block-outside-dns documentation
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

---
 doc/openvpn.8 | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index ef77b29..a276936 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -5575,6 +5575,15 @@ DNS leaks. This option prevents any application from accessing
 TCP or UDP port 53 except one inside the tunnel. It uses
 Windows Filtering Platform (WFP) and works on Windows Vista or
 later.
+
+This option is considered unknown on non-Windows platforms
+and unsupported versions (Windows XP), resulting in fatal
+error. You may want to use
+.B \-\-setenv opt
+or
+.B \-\-ignore\-unknown\-option
+to ignore said error. Note that pushing unknown options
+from server does not trigger fatal errors.
 .\"*********************************************************
 .TP
 .B \-\-dhcp\-renew
-- 
2.7.0


