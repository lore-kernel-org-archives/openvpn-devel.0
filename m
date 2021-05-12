From: Arne Schwabe <arne@...1227...>
Date: Wed, 12 May 2021 15:15:10 +0200
Message-Id: <20210512131511.1309914-9-arne@...1227...>
In-Reply-To: <20210512131511.1309914-1-arne@...1227...>
References: <20210512131511.1309914-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 8/9] Document stub-v2 being basically an
 alias for no compression at all
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

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 doc/man-sections/protocol-options.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/man-sections/protocol-options.rst b/doc/man-sections/protocol-options.rst
index 4b6928c68..34d4255ee 100644
--- a/doc/man-sections/protocol-options.rst
+++ b/doc/man-sections/protocol-options.rst
@@ -96,6 +96,11 @@ configured in a compatible way between both the local and remote side.
   other variants always add one extra framing byte compared to no
   compression framing.
 
+  Especially :code:`stub-v2` is essentially identical to no compression and
+  no compression framing as its header indicates IP version 5 in a tun setup
+  and can (ab)used to complete disable compression to clients. (See the
+  :code:`migrate option below)
+
   If the ``algorithm`` parameter is :code:`stub`, :code:`stub-v2` or empty,
   compression will be turned off, but the packet framing for compression
   will still be enabled, allowing a different setting to be pushed later.
-- 
2.31.1


