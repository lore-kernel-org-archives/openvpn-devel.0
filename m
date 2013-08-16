From: Arne Schwabe <arne@...1227...>
Date: Fri, 16 Aug 2013 10:11:20 +0200
Message-Id: <1376640680-26468-1-git-send-email-arne@...1227...>
In-Reply-To: <1371818610-4599-1-git-send-email-arne@...1227...>
References: <1371818610-4599-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [Patch v2 2/2] Add a note what setenv opt does for
	OpenVPN < 2.3.3
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
 doc/openvpn.8 |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 1680ebc..9c3f400 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -1897,6 +1897,10 @@ a fatal error if the directive isn't recognized.  To do this,
 prepend the following before the directive:
 .B setenv opt
 
+Versions prior to OpenVPN 2.3.3 will always ignore options set with the
+.B setenv opt
+directive.
+
 See also 
 .B \-\-ignore-unknown-option
 .\"*********************************************************
-- 
1.7.9.5


