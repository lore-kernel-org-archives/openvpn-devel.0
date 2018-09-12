From: Arne Schwabe <arne@...1227...>
Date: Wed, 12 Sep 2018 13:07:01 +0200
Message-Id: <20180912110701.31609-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Properly free tuntap struct on android when
 emulating persist-tun
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

Trac-Ticket: #851
---
 src/openvpn/init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 2933d555..b1f4320a 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1680,6 +1680,9 @@ do_open_tun(struct context *c)
     if (c->c1.tuntap)
     {
         oldtunfd = c->c1.tuntap->fd;
+        free(c->c1.tuntap);
+        c->c1.tuntap = NULL;
+        c->c1.tuntap_owned = false;
     }
 #endif
 
-- 
2.18.0


