From: Arne Schwabe <arne@...1227...>
Date: Tue, 11 Aug 2020 13:02:48 +0200
Message-Id: <20200811110248.3396-1-arne@...1227...>
In-Reply-To: <20181024113341.1242-1-arne@...1227...>
References: <20181024113341.1242-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v2] Document comp-lzo no and compress being
 incompatible
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

Most of the new compress but not v2 version do use swap operation. For
'compress lzo' the swap option is not used for backwards compatibility.
For lz4 the swap option is also not a problem since there is no version
without swap. Unfortunately, compress introduced a second stub format
with swap, contrary to the one in 'comp-lzo no' that does not use swap.

Document this weirdness to let not others fall into this trap.

Patch V2: redo patch for rst man pages
---
 doc/man-sections/protocol-options.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/doc/man-sections/protocol-options.rst b/doc/man-sections/protocol-options.rst
index 240d0edf..82e4b2bd 100644
--- a/doc/man-sections/protocol-options.rst
+++ b/doc/man-sections/protocol-options.rst
@@ -103,6 +103,9 @@ configured in a compatible way between both the local and remote side.
   ``lzo`` and ``lz4`` compression support via *IV_* variables to the
   server.
 
+  Note: the :code:`stub` (or empty) option is NOT compatible with the older
+  option ``--comp-lzo no``.
+
   ***Security Considerations***
 
   Compression and encryption is a tricky combination. If an attacker knows
-- 
2.26.2


