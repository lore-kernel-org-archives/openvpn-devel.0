From: Arne Schwabe <arne@...1227...>
Date: Wed, 24 Oct 2018 13:33:41 +0200
Message-Id: <20181024113341.1242-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Document comp-lzo no and compress being
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
---
 doc/openvpn.8 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index ac923f51..f8aa94ae 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -2551,6 +2551,9 @@ offering the best performance with least CPU usage.
 For backwards compatibility with OpenVPN versions before v2.4, use "lzo"
 (which is identical to the older option "\-\-comp\-lzo yes").
 
+Note however that the `stub` (or empty) option is NOT compatible with the
+older option "\-\-comp\-lzo no").
+
 The "lz4\-v2" and "stub\-v2" variants implement a better framing that does not add
 overhead when packets cannot be compressed. All other variants always add one extra
 framing byte compared to no compression framing.
-- 
2.19.0


