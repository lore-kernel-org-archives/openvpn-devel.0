Date: Mon, 16 Feb 2026 11:19:53 +0000
From: Rudi Heitbaum <rudi@...2993...>
Message-ID: <aZL9Wa8AuPv5Pewa@...2994...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2] dns: fix discards 'const' qualifier
 from pointer target type
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Since glibc-2.43:

For ISO C23, the functions bsearch, memchr, strchr, strpbrk, strrchr,
strstr, wcschr, wcspbrk, wcsrchr, wcsstr and wmemchr that return pointers
into their input arrays now have definitions as macros that return a
pointer to a const-qualified type when the input argument is a pointer
to a const-qualified type.

fixes:
    src/openvpn/dns.c: In function 'dns_server_addr_parse':
    src/openvpn/dns.c:67:25: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
       67 |     char *first_colon = strchr(addr, ':');
          |                         ^~~~~~
    src/openvpn/dns.c:68:24: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
       68 |     char *last_colon = strrchr(addr, ':');
          |                        ^~~~~~~

Signed-off-by: Rudi Heitbaum <rudi@...2993...>
---
 src/openvpn/dns.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index c00d4b9c..38739923 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -45,7 +45,7 @@
  * @return              True if parsing was successful
  */
 static bool
-dns_server_port_parse(in_port_t *port, char *port_str)
+dns_server_port_parse(in_port_t *port, const char *port_str)
 {
     char *endptr;
     errno = 0;
@@ -71,8 +71,8 @@ dns_server_addr_parse(struct dns_server *server, const char *addr)
     in_port_t port = 0;
     sa_family_t af;
 
-    char *first_colon = strchr(addr, ':');
-    char *last_colon = strrchr(addr, ':');
+    const char *first_colon = strchr(addr, ':');
+    const char *last_colon = strrchr(addr, ':');
 
     if (!first_colon || first_colon == last_colon)
     {
@@ -93,7 +93,7 @@ dns_server_addr_parse(struct dns_server *server, const char *addr)
         if (addr[0] == '[')
         {
             addr += 1;
-            char *bracket = last_colon - 1;
+            const char *bracket = last_colon - 1;
             if (*bracket != ']' || bracket == addr || !dns_server_port_parse(&port, last_colon + 1))
             {
                 return false;
-- 
2.51.0


