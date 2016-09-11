From: Steffan Karger <steffan@...1856...>
Date: Sun, 11 Sep 2016 16:51:17 +0200
Message-Id: <1473605477-20908-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH (2.3)] Update cipher-related man page text
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
 doc/openvpn.8 | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index d9bb77c..fd23f8b 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -3910,22 +3910,14 @@ Encrypt data channel packets with cipher algorithm
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
-- 
2.7.4


