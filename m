From: David Sommerseth <davids@...515...>
Date: Wed,  5 Oct 2016 14:48:01 +0200
Message-Id: <1475671681-2864-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH] man page: Update the --cipher section to
	reflect recommendations after SWEET32
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

We should no longer make users believe Blowfish is a 'very secure' cipher.
Update this section to reflect our recommendations after the SWEET32
announcement.

Trac: #732
Signed-off-by: David Sommerseth <davids@...515...>
---
 doc/openvpn.8 | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 2d15944..657985c 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -4110,14 +4110,20 @@ Encrypt data channel packets with cipher algorithm
 The default is
 .B BF-CBC,
 an abbreviation for Blowfish in Cipher Block Chaining mode.
-Blowfish has the advantages of being fast, very secure, and allowing key sizes
+Blowfish has the advantages of being fast, and allowing key sizes
 of up to 448 bits.  Blowfish is designed to be used in situations where
 keys are changed infrequently.
 
-For more information on blowfish, see
-.I http://www.counterpane.com/blowfish.html
+Blowfish was considered very secure for a long time.  But recent attacks described
+in the SWEET32 discovery makes it very unsuitable.  If you depend on Blowfish
+today, at least enable more aggressive renegotiation of the tunnel (set
+.B \-\-reneg-bytes
+to maximum 64MB) and start planning a migration to one of the now recommended AES
+ciphers. For more information, see:
 
-To see other ciphers that are available with
+.I http://community.openvpn.net/openvpn/wiki/SWEET32
+
+To see all ciphers that are available with
 OpenVPN, use the
 .B \-\-show\-ciphers
 option.
-- 
1.8.3.1


