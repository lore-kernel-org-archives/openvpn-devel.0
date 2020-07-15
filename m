From: David Sommerseth <davids@...515...>
Date: Thu, 16 Jul 2020 00:30:05 +0200
Message-Id: <20200715223013.11726-9-davids@...515...>
In-Reply-To: <20200715223013.11726-1-davids@...515...>
References: <20200715223013.11726-1-davids@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 08/16] doc/man: Mark compression options as
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
 doc/man-sections/protocol-options.rst | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/doc/man-sections/protocol-options.rst b/doc/man-sections/protocol-options.rst
index 37e55eb7..5bc072af 100644
--- a/doc/man-sections/protocol-options.rst
+++ b/doc/man-sections/protocol-options.rst
@@ -54,13 +54,13 @@ configured in a compatible way between both the local and remote side.
   Set ``alg`` to :code:`none` to disable encryption.
 
 --compress algorithm
-  Enable a compression algorithm.
+  **DEPRECATED** Enable a compression algorithm.  Compression is generally
+  not recommended.  VPN tunnels which uses compression are suspectible to
+  the VORALCE attack vector.
 
   The ``algorithm`` parameter may be :code:`lzo`, :code:`lz4`, or empty.
   LZO and LZ4 are different compression algorithms, with LZ4 generally
-  offering the best performance with least CPU usage. For backwards
-  compatibility with OpenVPN versions before v2.4, use :code:`lzo` (which
-  is identical to the older option ``--comp-lzo yes``).
+  offering the best performance with least CPU usage.
 
   If the ``algorithm`` parameter is empty, compression will be turned off,
   but the packet framing for compression will still be enabled, allowing a
@@ -77,8 +77,9 @@ configured in a compatible way between both the local and remote side.
   *not* enable compression.
 
 --comp-lzo mode
-  *DEPRECATED* This option will be removed in a future OpenVPN release.
-  Use the newer ``--compress`` instead.
+  **DEPRECATED** Enable LZO compression algorithm.  Compression is
+  generally not recommended.  VPN tunnels which uses compression are
+  suspectible to the VORALCE attack vector.
 
   Use LZO compression -- may add up to 1 byte per packet for incompressible
   data. ``mode`` may be :code:`yes`, :code:`no`, or :code:`adaptive`
@@ -104,9 +105,9 @@ configured in a compatible way between both the local and remote side.
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


