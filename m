From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 13 Oct 2023 12:23:16 +0200
Message-Id: <20231013102316.330086-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] doc: fix argument name in --route-delay
 documentation
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

Also remove redundant "by default".

Change-Id: I6f55d15ce6a5fe2f59bbc1cb51c8474f1f81dfca
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 doc/man-sections/vpn-network-options.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vpn-network-options.rst
index b7f33acd..3fa3ccf1 100644
--- a/doc/man-sections/vpn-network-options.rst
+++ b/doc/man-sections/vpn-network-options.rst
@@ -420,7 +420,7 @@ routing.
 
        route-delay
        route-delay n
-       route-delay n m
+       route-delay n w
 
   Delay ``n`` seconds (default :code:`0`) after connection establishment,
   before adding routes. If ``n`` is :code:`0`, routes will be added
@@ -434,7 +434,7 @@ routing.
   to complete before routes are added.
 
   On Windows, ``--route-delay`` tries to be more intelligent by waiting
-  ``w`` seconds (default :code:`30` by default) for the TAP-Win32 adapter
+  ``w`` seconds (default :code:`30`) for the TAP-Win32 adapter
   to come up before adding routes.
 
 --route-ipv6 args
-- 
2.34.1


