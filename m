From: Antonio Quartulli <a@...2181...>
Date: Tue, 21 Sep 2021 14:15:19 +0200
Message-Id: <20210921121519.18912-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] doc: fix indentation in protocol-options.rst
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
Cc: Antonio Quartulli <a@...2181...>

The bullet points are not proeprly indented and they trigger
the following error/warning:

rst2man.py openvpn.8.rst > openvpn.8
man-sections/protocol-options.rst:62: (ERROR/3) Unexpected indentation.
man-sections/protocol-options.rst:67: (WARNING/2) Block quote ends without a blank line; unexpected unindent.
rst2man.py openvpn-examples.5.rst > openvpn-examples.5
rst2html.py openvpn.8.rst > openvpn.8.html
man-sections/protocol-options.rst:62: (ERROR/3) Unexpected indentation.
man-sections/protocol-options.rst:67: (WARNING/2) Block quote ends without a blank line; unexpected unindent.

Fix indentation and add white lines as expected.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 doc/man-sections/protocol-options.rst | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/doc/man-sections/protocol-options.rst b/doc/man-sections/protocol-options.rst
index 4125b263..c7aa6b0e 100644
--- a/doc/man-sections/protocol-options.rst
+++ b/doc/man-sections/protocol-options.rst
@@ -59,11 +59,14 @@ configured in a compatible way between both the local and remote side.
 --cipher alg
   This option should not be used any longer in TLS mode and still
   exists for two reasons:
-      * compatibility with old configurations still carrying it
-	around;
-      * allow users connecting to OpenVPN peers older than 2.6.0
-	to have ``--cipher`` configured the same way as the remote
-	counterpart. This can avoid MTU/frame size warnings.
+
+  * compatibility with old configurations still carrying it
+    around;
+
+  * allow users connecting to OpenVPN peers older than 2.6.0
+    to have ``--cipher`` configured the same way as the remote
+    counterpart. This can avoid MTU/frame size warnings.
+
   Before 2.4.0, this option was used to select the cipher to be
   configured on the data channel, however, later versions usually
   ignored this directive in favour of a negotiated cipher.
-- 
2.32.0


