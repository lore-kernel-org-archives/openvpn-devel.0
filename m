From: Gert Doering <gert@...1296...>
Date: Wed, 25 Sep 2024 17:11:04 +0200
Message-ID: <20240925151104.13036-1-gert@...1296...>
In-Reply-To: <gerrit.1727274369000.I9966636163c7dfa208d26f1cadbf5b81937f3a34@...2715...>
References: <gerrit.1727274369000.I9966636163c7dfa208d26f1cadbf5b81937f3a34@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Remove null check after checking for
 checking for did_open_tun
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

From: Arne Schwabe <arne@...1227...>

If we indicate that the tun device has been opened the c1.tuntap struct
is guaranteed to be defined. This extra null check is something that
Coverity flags as we access a do a null check after already accessing fields
of tuntap

Change-Id: I9966636163c7dfa208d26f1cadbf5b81937f3a34
Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/772
This mail reflects revision 1 of this Change.

Signed-off-by line for the author was added as per our policy.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 876edad..ae911a9 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2546,10 +2546,7 @@
             {
                 event_timeout_init(&c->c2.route_wakeup, c->options.route_delay, now);
                 event_timeout_init(&c->c2.route_wakeup_expire, c->options.route_delay + c->options.route_delay_window, now);
-                if (c->c1.tuntap)
-                {
-                    tun_standby_init(c->c1.tuntap);
-                }
+                tun_standby_init(c->c1.tuntap);
             }
             else
             {

