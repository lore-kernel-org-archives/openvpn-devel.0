From: Gert Doering <gert@...1296...>
Date: Fri,  5 Jul 2019 15:00:01 +0200
Message-Id: <20190705130001.30741-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] repair windows builds (2.4)
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

commit 0c1cc8d65539f removed "DWORD len;" from service_enable_dhcp(),
but that variable is far from "unused" - breaking compilation.

The problem here was that it's a larger "cleanup compiler warnings"
patch which was fully correct for master, but this particular function
looks different in release/2.4 because the whole iservice call
refactoring patch isn't in release/2.4 - so master does not need the
DWORD len, but release/2.4 does.

More care needed with "warning cleanup"...

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/tun.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 9b830285..80eaa2c4 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -5374,6 +5374,7 @@ netsh_enable_dhcp(const char *actual_name)
 static bool
 service_enable_dhcp(const struct tuntap *tt)
 {
+    DWORD len;
     bool ret = false;
     ack_message_t ack;
     struct gc_arena gc = gc_new();
-- 
2.21.0


