From: Selva Nair <selva.nair@...277...>
Date: Fri,  2 Dec 2016 14:42:09 -0500
Message-Id: <1480707729-19578-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Correctly state the default dhcp server
	address in man page
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Also correct the default ifconfig-pool end in docs and comments

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 doc/openvpn.8        | 4 ++--
 src/openvpn/helper.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index e61b6bb..290a441 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -2793,7 +2793,7 @@ expands as follows:
  if dev tap OR (dev tun AND topology == subnet):
    ifconfig 10.8.0.1 255.255.255.0
    if !nopool:
-     ifconfig\-pool 10.8.0.2 10.8.0.254 255.255.255.0
+     ifconfig\-pool 10.8.0.2 10.8.0.253 255.255.255.0
    push "route\-gateway 10.8.0.1"
    if route\-gateway unset:
      route\-gateway 10.8.0.2
@@ -5594,7 +5594,7 @@ virtual DHCP server address.  In
 .B \-\-dev tun
 mode, OpenVPN will cause the DHCP server to masquerade as if it were
 coming from the remote endpoint.  The optional offset parameter is
-an integer which is > \-256 and < 256 and which defaults to 0.
+an integer which is > \-256 and < 256 and which defaults to -1.
 If offset is positive, the DHCP server will masquerade as the IP
 address at network address + offset.
 If offset is negative, the DHCP server will masquerade as the IP
diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
index 229523d..319c716 100644
--- a/src/openvpn/helper.c
+++ b/src/openvpn/helper.c
@@ -228,7 +228,7 @@ helper_client_server (struct options *o)
    * if tap OR (tun AND topology == subnet):
    *   ifconfig 10.8.0.1 255.255.255.0
    *   if !nopool: 
-   *     ifconfig-pool 10.8.0.2 10.8.0.254 255.255.255.0
+   *     ifconfig-pool 10.8.0.2 10.8.0.253 255.255.255.0
    *   push "route-gateway 10.8.0.1"
    *   if route-gateway unset:
    *     route-gateway 10.8.0.2
-- 
2.1.4


