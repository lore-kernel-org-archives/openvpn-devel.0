From: Max Fillinger <maximilian.fillinger@...2507...>
Date: Sat, 26 Nov 2022 17:26:47 +0100
Message-ID: <20221126162648.150678-1-maximilian.fillinger@...2507...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2] Correct tls-crypt-v2 metadata length in
 man page
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

The manual page claims that the client metadata can be up to 735 bytes
(encoded as upt to 980 characters base64), but the actual maximum length
is 733 bytes which is also encoded as 980 characters in base64.

Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
---
 doc/man-sections/encryption-options.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/doc/man-sections/encryption-options.rst b/doc/man-sections/encryption-options.rst
index ee34f14e..abc73d90 100644
--- a/doc/man-sections/encryption-options.rst
+++ b/doc/man-sections/encryption-options.rst
@@ -104,7 +104,8 @@ Generating key material
 
     If supplied, include the supplied ``metadata`` in the wrapped client
     key. This metadata must be supplied in base64-encoded form. The
-    metadata must be at most 735 bytes long (980 bytes in base64).
+    metadata must be at most 733 bytes long (980 characters in base64, though
+    note that 980 base64 characters can encode more than 733 bytes).
 
     If no metadata is supplied, OpenVPN will use a 64-bit unix timestamp
     representing the current time in UTC, encoded in network order, as
-- 
2.30.2


