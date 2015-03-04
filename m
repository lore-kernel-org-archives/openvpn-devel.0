From: Arne Schwabe <arne@...1227...>
Date: Wed,  4 Mar 2015 15:23:45 +0100
Message-Id: <1425479025-7573-2-git-send-email-arne@...1227...>
In-Reply-To: <1425479025-7573-1-git-send-email-arne@...1227...>
References: <1425479025-7573-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 2/2] Document the default for tls-cipher.
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
 doc/openvpn.8 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index a8c189c..32cdcb9 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -4514,6 +4514,9 @@ of security they both support.
 Use
 .B \-\-show-tls
 to see a list of supported TLS ciphers.
+
+The default for --tls-cipher is to use PolarSSL's default cipher list 
+when using PolarSSL or "DEFAULT:!EXP:!PSK:!SRP:!kRSA" when using OpenSSL.
 .\"*********************************************************
 .TP
 .B \-\-tls-timeout n
-- 
1.9.3 (Apple Git-50)


