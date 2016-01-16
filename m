From: ValdikSS <iam@...2070...>
Date: Sat, 16 Jan 2016 17:05:26 +0300
Message-Id: <1452953126-6283-1-git-send-email-iam@...2070...>
Subject: [Openvpn-devel] [PATCH v2] Clarify --block-outside-dns documentation
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
 doc/openvpn.8 | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index ef77b29..76650e9 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -5575,6 +5575,16 @@ DNS leaks. This option prevents any application from accessing
 TCP or UDP port 53 except one inside the tunnel. It uses
 Windows Filtering Platform (WFP) and works on Windows Vista or
 later.
+
+This option is considered unknown on non-Windows platforms
+and unsupported on Windows XP, resulting in fatal error.
+You may want to use
+.B \-\-setenv opt
+or
+.B \-\-ignore\-unknown\-option
+(not suitable for Windows XP) to ignore said error.
+Note that pushing unknown options from server does not trigger
+fatal errors.
 .\"*********************************************************
 .TP
 .B \-\-dhcp\-renew
-- 
2.7.0


