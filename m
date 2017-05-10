From: Steffan Karger <steffan@...1856...>
Date: Wed, 10 May 2017 21:50:44 +0200
Message-Id: <1494445844-8327-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH (release/2.3)] Document that OpenVPN 2.3
	does not check the CRL signature
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

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 doc/openvpn.8 | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 612cddd..284e8e6 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -5208,6 +5208,15 @@ Note: As the crl file (or directory) is read every time a peer connects,
 if you are dropping root privileges with
 .B \-\-user,
 make sure that this user has sufficient privileges to read the file.
+
+.B Security considerations
+
+.B \-\-crl\-verify
+does not check whether the CRL is correctly signed by the CA.  It merely checks
+that the CRL issuers matches the CA CN.  Therefore, users should ensure that
+the supplied CRL is correct.
+
+OpenVPN 2.4 and newer resolve this issue.
 .\"*********************************************************
 .SS SSL Library information:
 .\"*********************************************************
-- 
2.7.4


