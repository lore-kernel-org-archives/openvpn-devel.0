From: Conrad Hoffmann <ch@...2291...>
Date: Wed,  2 Aug 2017 20:14:35 +0200
Message-Id: <20170802181435.14549-3-ch@...2291...>
In-Reply-To: <20170802181435.14549-1-ch@...2291...>
References: <20170802181435.14549-1-ch@...2291...>
Subject: [Openvpn-devel] [PATCH 2/2] Document down-root plugin usage in
 client.down
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

Signed-off-by: Conrad Hoffmann <ch@...2291...>
---
 contrib/pull-resolv-conf/client.down | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/pull-resolv-conf/client.down b/contrib/pull-resolv-conf/client.down
index 90bc5891..c9090b56 100644
--- a/contrib/pull-resolv-conf/client.down
+++ b/contrib/pull-resolv-conf/client.down
@@ -30,6 +30,10 @@
 # the client "up" script will run fine, but the "down" script
 # will require the use of the OpenVPN "down-root" plugin
 # which is in the plugins/ directory of the OpenVPN source tree
+# The config example above would have to be changed to:
+#   client
+#   up /etc/openvpn/client.up
+#   plugin openvpn-plugin-down-root.so "/etc/openvpn/client.down"
 
 # A horrid work around, from a security perspective,
 # is to run OpenVPN as root. THIS IS NOT RECOMMENDED. You have
-- 
2.13.3


