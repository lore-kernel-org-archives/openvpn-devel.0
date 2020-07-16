From: David Sommerseth <davids@...515...>
Date: Fri, 17 Jul 2020 00:53:35 +0200
Message-Id: <20200716225338.611-6-davids@...515...>
In-Reply-To: <20200716225338.611-1-davids@...515...>
References: <20200716225338.611-1-davids@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 5/8] doc/man: Mark compression options as
 deprecated
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

Due to the VORACLE attack vector, compression in general is deprecated.
Make this clear in the man page.

Also remove an incorrect statement claiming --compress lzo is compatible
with --comp-lzo.  It is not, as --compress lzo uses a different
compression framing than --comp-lzo.

Signed-off-by: David Sommerseth <davids@...515...>
---
 doc/man-sections/protocol-options.rst | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/doc/man-sections/protocol-options.rst b/doc/man-sections/protocol-options.rst
index ae85a25e..a5a1253a 100644
--- a/doc/man-sections/protocol-options.rst
+++ b/doc/man-sections/protocol-options.rst
@@ -60,9 +60,7 @@ configured in a compatible way between both the local and remote side.
 
   The ``algorithm`` parameter may be :code:`lzo`, :code:`lz4`, or empty.
   LZO and LZ4 are different compression algorithms, with LZ4 generally
-  offering the best performance with least CPU usage. For backwards
-  compatibility with OpenVPN versions before v2.4, use :code:`lzo` (which
-  is identical to the older option ``--comp-lzo yes``).
+  offering the best performance with least CPU usage.
 
   If the ``algorithm`` parameter is empty, compression will be turned off,
   but the packet framing for compression will still be enabled, allowing a
@@ -79,8 +77,9 @@ configured in a compatible way between both the local and remote side.
   *not* enable compression.
 
 --comp-lzo mode
-  *DEPRECATED* This option will be removed in a future OpenVPN release.
-  Use the newer ``--compress`` instead.
+  **DEPRECATED** Enable LZO compression algorithm.  Compression is
+  generally not recommended.  VPN tunnels which uses compression are
+  suspectible to the VORALCE attack vector.
 
   Use LZO compression -- may add up to 1 byte per packet for incompressible
   data. ``mode`` may be :code:`yes`, :code:`no`, or :code:`adaptive`
@@ -106,9 +105,9 @@ configured in a compatible way between both the local and remote side.
   link, the second sets the client side.
 
 --comp-noadapt
-  When used in conjunction with ``--comp-lzo``, this option will disable
-  OpenVPN's adaptive compression algorithm. Normally, adaptive compression
-  is enabled with ``--comp-lzo``.
+  **DEPRECATED** When used in conjunction with ``--comp-lzo``, this option
+  will disable OpenVPN's adaptive compression algorithm. Normally, adaptive
+  compression is enabled with ``--comp-lzo``.
 
   Adaptive compression tries to optimize the case where you have
   compression enabled, but you are sending predominantly incompressible
-- 
2.26.0


