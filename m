From: David Sommerseth <dazo@...384...>
Date: Fri,  7 Jun 2013 12:15:11 +0200
Message-Id: <1370600111-5983-1-git-send-email-dazo@...384...>
Subject: [Openvpn-devel] [PATCH 1/3] man page: Update man page about the
	tls_digest_{n} environment variable
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

From: David Sommerseth <davids@...1347...>

Signed-off-by: David Sommerseth <davids@...1347...>
---
 doc/openvpn.8 |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 397e2bf..25daafa 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -5962,6 +5962,16 @@ Set prior to execution of the
 script.
 .\"*********************************************************
 .TP
+.B tls_digest_{n}
+Contains the certificate SHA1 fingerprint/digest hash value,
+where
+.B n
+is the verification level.  Only set for TLS connections.  Set prior
+to execution of
+.B \-\-tls-verify
+script.
+.\"*********************************************************
+.TP
 .B tls_id_{n}
 A series of certificate fields from the remote peer,
 where
-- 
1.7.10.2


