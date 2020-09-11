From: David Sommerseth <davids@...515...>
Date: Fri, 11 Sep 2020 17:42:59 +0200
Message-Id: <20200911154259.13837-1-davids@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] man: Add missing --server-ipv6
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

During the conversion from .8 to .rst and further reorganizing of the
content into separate files, the --server-ipv6 entry got lost.  This
resurrects it again.

Signed-off-by: David Sommerseth <davids@...515...>
---
 doc/man-sections/server-options.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-options.rst
index 2009953c..1c25d75a 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -639,6 +639,20 @@ fast hardware. SSL/TLS authentication must be used in this mode.
     mode server
     tls-server
 
+--server-ipv6 args
+  Convenience-function to enable a number of IPv6 related options at once,
+  namely ``--ifconfig-ipv6``, ``--ifconfig-ipv6-pool`` and
+  ``--push tun-ipv6``.
+
+  Valid syntax:
+  ::
+
+     server-ipv6 ipv6addr/bits
+
+  This is only accepted if ``--mode server`` or ``--server`` is set.
+  Pushing of the ``--tun-ipv6`` directive is done for older clients which
+  require an explicit ``--tun-ipv6`` in their configuration.
+
 --stale-routes-check args
   Remove routes which haven't had activity for ``n`` seconds (i.e. the ageing
   time).  This check is run every ``t`` seconds (i.e. check interval).
-- 
2.26.0


