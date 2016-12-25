From: Steffan Karger <steffan@...1856...>
Date: Sun, 25 Dec 2016 23:02:14 +0100
Message-Id: <1482703334-18949-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] man: encourage user to read on about
	--tls-crypt
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

As suggested by krzee in trac #790, refer to the --tls-crypt option
form the --tls-auth section of the man page, to encourage users to
check out the --tls-crypt feature.

Trac: #790

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 doc/openvpn.8 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index b1ca9ed..c618746 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -5029,6 +5029,11 @@ key file used with
 .B \-\-tls\-auth
 gives a peer nothing more than the power to initiate a TLS
 handshake.  It is not used to encrypt or authenticate any tunnel data.
+
+Use
+.B \-\-tls\-crypt
+instead if you want to use the key file to not only authenticate, but also
+encrypt the TLS control channel.
 .\"*********************************************************
 .TP
 .B \-\-tls\-crypt keyfile
-- 
2.7.4


