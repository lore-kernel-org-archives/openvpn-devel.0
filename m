From: Christian Kujau <lists@...2941...>
Date: Mon,  6 Oct 2025 16:42:47 +0200
Message-ID: <20251006144249.23672-2-lists@...2941...>
In-Reply-To: <20251006144249.23672-1-lists@...2941...>
References: <20251006144249.23672-1-lists@...2941...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 1/2] doc: Fix hyperlinks in openvpn(8)
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
Cc: Christian Kujau <github@...2941...>

From: Christian Kujau <github@...2941...>

* http://www.cs.ucsd.edu/users/mihir/papers/hmac.html - 404, RFC104 basically
* http://sites.inka.de/sites/bigred/devel/tcp-tcp.html - 404, unfortunately
* http://www.ietf.org/rfc/rfc2246.txt - HTTPS upgrade to the HTML version

Signed-off-by: Christian Kujau <github@...2941...>
---
 doc/man-sections/link-options.rst     | 2 +-
 doc/man-sections/protocol-options.rst | 2 +-
 doc/openvpn.8.rst                     | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-options.rst
index 8334d16f..edda1ca2 100644
--- a/doc/man-sections/link-options.rst
+++ b/doc/man-sections/link-options.rst
@@ -338,7 +338,7 @@ the local and the remote host.
   used over unreliable or congested networks.
 
   This article outlines some of problems with tunneling IP over TCP:
-  http://sites.inka.de/sites/bigred/devel/tcp-tcp.html
+  https://web.archive.org/web/20141025181658/http://sites.inka.de/sites/bigred/devel/tcp-tcp.html
 
   There are certain cases, however, where using TCP may be advantageous
   from a security and robustness perspective, such as tunneling non-IP or
diff --git a/doc/man-sections/protocol-options.rst b/doc/man-sections/protocol-options.rst
index d04ace88..6eac14ce 100644
--- a/doc/man-sections/protocol-options.rst
+++ b/doc/man-sections/protocol-options.rst
@@ -52,7 +52,7 @@ configured in a compatible way between both the local and remote side.
   authentication.
 
   For more information on HMAC see
-  http://www.cs.ucsd.edu/users/mihir/papers/hmac.html
+  https://tools.ietf.org/html/rfc2104
 
 --cipher alg
   This option should not be used any longer in TLS mode and still
diff --git a/doc/openvpn.8.rst b/doc/openvpn.8.rst
index dd9180ab..81cfe278 100644
--- a/doc/openvpn.8.rst
+++ b/doc/openvpn.8.rst
@@ -150,10 +150,10 @@ NOTES
 This product includes software developed by the OpenSSL Project
 (https://www.openssl.org/)
 
-For more information on the TLS protocol, see
-http://www.ietf.org/rfc/rfc2246.txt
+For more information on the TLS protocol see:
+https://tools.ietf.org/html/rfc2246
 
-For more information on the LZO real-time compression library see
+For more information on the LZO real-time compression library see:
 https://www.oberhumer.com/opensource/lzo/
 
 
-- 
2.50.1 (Apple Git-155)


