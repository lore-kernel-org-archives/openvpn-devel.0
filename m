From: Antonio Quartulli <a@...2181...>
Date: Fri, 22 Jun 2018 18:21:10 +0800
Message-Id: <20180622102110.21888-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH] route: fix format string passed to
 argv_printf
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
Cc: Antonio Quartulli <a@...2181...>

%lu is not supported by our tiny argv_printf implementation and will
trigger an ASSERT() when parsing it. Even though this particular
ASSERT() is not critical as it happens during shutdown, we still have to
fix it.

Since in this case the code is trying to use a DWORD variable as
argument, and we know that DWORD is an unsigned long, which in turn is
32bit long on MS Windows (32 and 64bit version)[1][2], simply use
the already supported %u instead of %lu.

[1]https://msdn.microsoft.com/en-us/library/aa383751(VS.85).aspx
[2]https://en.wikipedia.org/wiki/Integer_(computer_science)#Long_integer

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index a45a273a..209daeab 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1616,7 +1616,7 @@ add_route(struct route_ipv4 *r, const struct tuntap *tt, unsigned int flags,
         if (is_on_link(is_local_route, flags, rgi))
         {
             ai = rgi->adapter_index;
-            argv_printf_cat(&argv, "IF %lu", ai);
+            argv_printf_cat(&argv, "IF %u", ai);
         }
 
         argv_msg(D_ROUTE, &argv);
-- 
2.17.1


