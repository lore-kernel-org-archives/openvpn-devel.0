From: Richard Bonhomme <tincanteksup@...277...>
Date: Wed,  1 Jul 2020 23:40:31 +0100
Message-Id: <20200701224031.15113-1-tincanteksup@...277...>
Subject: [Openvpn-devel] [Patch] New man page corrections -
 protocol-options.rst
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Signed-off-by: Richard Bonhomme <tincanteksup@...277...>
---
 doc/man-sections/protocol-options.rst | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/doc/man-sections/protocol-options.rst b/doc/man-sections/protocol-options.rst
index 5bc072af..a5a1253a 100644
--- a/doc/man-sections/protocol-options.rst
+++ b/doc/man-sections/protocol-options.rst
@@ -1,7 +1,7 @@
 Protocol options
 ----------------
-Options in this section affects features available in the OpenVPN wire
-protocol.  Many of these options also defines the encryption options
+Options in this section affect features available in the OpenVPN wire
+protocol.  Many of these options also define the encryption options
 of the data channel in the OpenVPN wire protocol.  These options must be
 configured in a compatible way between both the local and remote side.
 
@@ -9,15 +9,15 @@ configured in a compatible way between both the local and remote side.
   Authenticate data channel packets and (if enabled) ``tls-auth`` control
   channel packets with HMAC using message digest algorithm ``alg``. (The
   default is ``SHA1`` ). HMAC is a commonly used message authentication
-  algorithm (MAC) that uses a data string, a secure hash algorithm, and a
-  key, to produce a digital signature.
+  algorithm (MAC) that uses a data string, a secure hash algorithm and a
+  key to produce a digital signature.
 
   The OpenVPN data channel protocol uses encrypt-then-mac (i.e. first
-  encrypt a packet, then HMAC the resulting ciphertext), which prevents
+  encrypt a packet then HMAC the resulting ciphertext), which prevents
   padding oracle attacks.
 
-  If an AEAD cipher mode (e.g. GCM) is chosen, the specified ``--auth``
-  algorithm is ignored for the data channel, and the authentication method
+  If an AEAD cipher mode (e.g. GCM) is chosen then the specified ``--auth``
+  algorithm is ignored for the data channel and the authentication method
   of the AEAD cipher is used instead. Note that ``alg`` still specifies
   the digest used for ``tls-auth``.
 
@@ -55,7 +55,7 @@ configured in a compatible way between both the local and remote side.
 
 --compress algorithm
   **DEPRECATED** Enable a compression algorithm.  Compression is generally
-  not recommended.  VPN tunnels which uses compression are suspectible to
+  not recommended.  VPN tunnels which use compression are susceptible to
   the VORALCE attack vector.
 
   The ``algorithm`` parameter may be :code:`lzo`, :code:`lz4`, or empty.
@@ -161,7 +161,7 @@ configured in a compatible way between both the local and remote side.
   either specify ``--cipher BF-CBC`` or ``--cipher AES-256-CBC`` and both
   will work.
 
-  Note, for using NCP with a OpenVPN 2.4 peer this list must include the
+  Note for using NCP with an OpenVPN 2.4 peer: This list must include the
   :code:`AES-256-GCM` and :code:`AES-128-GCM` ciphers.
 
   This list is restricted to be 127 chars long after conversion to OpenVPN
-- 
2.17.1


