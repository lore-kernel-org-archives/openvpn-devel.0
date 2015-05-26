From: Gert Doering <gert@...1296...>
Date: Tue, 26 May 2015 23:01:03 +0200
Message-Id: <1432674063-15916-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] slightly enhance documentation about
	--cipher
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

point out that this is for "data channel" packets

trac #463

Signed-off-by: Gert Doering <gert@...1296...>
---
 doc/openvpn.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index b1c2fab..fb759cf 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -3904,7 +3904,7 @@ For more information on HMAC see
 .\"*********************************************************
 .TP
 .B \-\-cipher alg
-Encrypt packets with cipher algorithm
+Encrypt data channel packets with cipher algorithm
 .B alg.
 The default is
 .B BF-CBC,
-- 
2.3.6


