From: Steffan Karger <steffan.karger@...1435...>
Date: Fri, 5 May 2017 22:30:21 +0200
Message-ID: <1494016221-21268-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Document tls-crypt security considerations
	in man page
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

The tls-crypt commit message contained an elaborate discussion on the
function's security properties.  This commit adds the gist of that
discussion, "rotate keys periodically" to the man page.

(The 'real' solution will follow later: add support for per-client
tls-crypt keys.  That will make tls-crypt useful for VPN providers too.)

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
Note to non-crypto-geek reviewers: please verify that this text is clear
enough to explain you when you need to replace tls-crypt keys.

Note to crypto-geek reviewers: please check the numbers - see the
--tls-crypt commit message (c6e24fa3) for details.

 doc/openvpn.8 | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index c3248fd..3a303a9 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -5090,6 +5090,28 @@ In contrast to
 .B \-\-tls\-crypt
 does *not* require the user to set
 .B \-\-key\-direction\fR.
+
+.B Security Considerations
+
+All peers use the same
+.B \-\-tls-crypt
+pre-shared group key to authenticate and encrypt control channel messages.
+To ensure that IV collisions remain unlikely, this key should not be used
+to encrypt more than 2^48 client-to-server or 2^48 server-to-client
+control channel messages.  A typical initial negotiation is about 10 packets
+in each direction.  Assuming both initial negotation and renogatiations are
+at most 2^16 (65536) packets, and (re)negotiations happen each minute for
+each user (24/7), this limits the tls\-crypt key lifetime to 8171 year divided
+by the number of users.  So a setup with 1000 users should rotate the key at
+least once each eight years.  (And a setup with 8000 users each year.)
+
+If IV collisions were to occur, this could result in the security of
+.B \-\-tls\-crypt
+degrading to the same security as using
+.B \-\-tls\-auth\fR.
+That is, the control channel still benefits from the extra protection against
+active man-in-the-middle-attacks and DoS attacks, but may no longer offer
+extra privacy and post-quantum security on top of what TLS itself offers.
 .\"*********************************************************
 .TP
 .B \-\-askpass [file]
-- 
2.7.4


