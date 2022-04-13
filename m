From: Kristof Provost <kprovost@...2661...>
Date: Wed, 13 Apr 2022 13:58:11 +0200
Message-Id: <20220413115811.22534-2-kprovost@...2661...>
In-Reply-To: <20220413115811.22534-1-kprovost@...2661...>
References: <20220413115811.22534-1-kprovost@...2661...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] pass vpn addresses to the kernel
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

From: Kristof Provost <kp@...1376...>

---
 src/openvpn/dco_freebsd.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 3f8b39e0..8c300639 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -91,6 +91,17 @@ dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd,
         nvlist_add_nvlist(nvl, "remote", sockaddr_to_nvlist(remoteaddr));
     }
 
+    if (remote_in4)
+    {
+        nvlist_add_binary(nvl, "vpn_ipv4", &remote_in4->s_addr,
+            sizeof(remote_in4->s_addr));
+    }
+
+    if (remote_in6)
+    {
+        nvlist_add_binary(nvl, "vpn_ipv6", remote_in6, sizeof(*remote_in6));
+    }
+
     nvlist_add_number(nvl, "fd", sd);
     nvlist_add_number(nvl, "peerid", peerid);
 
-- 
2.35.1


