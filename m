From: Antonio Quartulli <a@...2181...>
Date: Sat, 23 Jun 2018 10:11:47 +0800
Message-Id: <20180623021147.22792-1-a@...2181...>
In-Reply-To: <20180622102110.21888-1-a@...2181...>
References: <20180622102110.21888-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH v2] add support for %lu in argv_printf and
 prevent ASSERT
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

%lu is not supported by our tiny argv_printf implementation, therefore
it will trigger an ASSERT() when parsing it at route.c:1638.

Add support for '%lu' in argv_print() and prevent the ASSERT from being
triggered.

Signed-off-by: Antonio Quartulli <a@...2181...>
---

It seems I managed to trigger this ASSERT when connecting to my v6-only
server with "gateway-redirect !ipv4 ipv6" set. Not sure why this issue
hasn't surfaced earlier though.


Changes from v1:
- keep format string as "%lu" but add support for it in argv_printf()
- tested on Windows 10 on top of the ipv6-only branch

 src/openvpn/argv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c
index dec7e3bf..9100a196 100644
--- a/src/openvpn/argv.c
+++ b/src/openvpn/argv.c
@@ -251,6 +251,13 @@ argv_printf_arglist(struct argv *a, const char *format, va_list arglist)
                 openvpn_snprintf(numstr, sizeof(numstr), "%u", va_arg(arglist, unsigned int));
                 argv_append(a, string_alloc(numstr, NULL));
             }
+            else if (!strcmp(term, "%lu"))
+            {
+                char numstr[64];
+                openvpn_snprintf(numstr, sizeof(numstr), "%lu",
+                                 va_arg(arglist, unsigned long));
+                argv_append(a, string_alloc(numstr, NULL));
+            }
             else if (!strcmp(term, "%s/%d"))
             {
                 char numstr[64];
-- 
2.17.1


