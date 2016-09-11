From: Steffan Karger <steffan@...1856...>
Date: Sun, 11 Sep 2016 16:50:31 +0200
Message-Id: <1473605431-20842-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH (master)] Update cipher-related man page text
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

As reported in trac #732, the man page text for --cipher is no longer
accurate.  Update the text to represent current knowledge, about NCP and
SWEET32.

This does not hint at changing the default cipher, because we did not make
a decision on that yet.  If we do change the default cipher, we'll have to
update the text to reflect that.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 doc/openvpn.8 | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 163bdf4..f86851c 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -4110,25 +4110,26 @@ Encrypt data channel packets with cipher algorithm
 The default is
 .B BF-CBC,
 an abbreviation for Blowfish in Cipher Block Chaining mode.
-Blowfish has the advantages of being fast, very secure, and allowing key sizes
-of up to 448 bits.  Blowfish is designed to be used in situations where
-keys are changed infrequently.
 
-For more information on blowfish, see
-.I http://www.counterpane.com/blowfish.html
+Using BF-CBC is no longer recommended, because of it's 64-bit block size.  This
+small block size allows attacks based on collisions, as demonstrated by SWEET32.
 
-To see other ciphers that are available with
-OpenVPN, use the
+To see other ciphers that are available with OpenVPN, use the
 .B \-\-show\-ciphers
 option.
 
-OpenVPN supports the CBC, CFB, and OFB cipher modes,
-however CBC is recommended and CFB and OFB should
-be considered advanced modes.
-
 Set
 .B alg=none
 to disable encryption.
+
+As of OpenVPN 2.4, cipher negotiation (NCP) can override the cipher specified by
+.B \-\-cipher\fR.
+See
+.B \-\-ncp-ciphers
+and
+.B \-\-ncp-disable
+for more on NCP.
+
 .\"*********************************************************
 .TP
 .B \-\-ncp\-ciphers cipher_list
@@ -4141,6 +4142,19 @@ is a colon-separated list of ciphers, and defaults to
 For servers, the first cipher from
 .B cipher_list
 will be pushed to clients that support cipher negotiation.
+
+Cipher negotiation is enabled in client-server mode only.  I.e. if
+.B \-\-mode
+is set to 'server' (server-side, implied by setting
+.B \-\-server
+), or if
+.B \-\-pull
+is specified (client-side, implied by setting \-\-client).
+
+If both peers support and do not disable NCP, the negotiated cipher will
+override the cipher specified by
+.B \-\-cipher\fR.
+
 .\"*********************************************************
 .TP
 .B \-\-ncp\-disable
-- 
2.7.4


