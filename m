From: Gert Doering <gert@...1296...>
Date: Wed, 18 Feb 2026 22:46:12 +0100
Message-ID: <20260218214618.27059-1-gert@...1296...>
In-Reply-To: <gerrit.1771415352000.I262705189edfbd9aa9a32bcd712840fffa592435@...2715...>
References: <gerrit.1771415352000.I262705189edfbd9aa9a32bcd712840fffa592435@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] dns: fix discards 'const' qualifier from
 pointer target type
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

From: Rudi Heitbaum <rudi@...2993...>

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

Change-Id: I262705189edfbd9aa9a32bcd712840fffa592435
Signed-off-by: Rudi Heitbaum <rudi@...2993...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1544
(cherry picked from commit 157fd949aff80ae3fb5897045af3ec4c213e1b0f)
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1544
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 7de3991..66ac32f 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -38,7 +38,7 @@
  * @return              True if parsing was successful
  */
 static bool
-dns_server_port_parse(in_port_t *port, char *port_str)
+dns_server_port_parse(in_port_t *port, const char *port_str)
 {
     char *endptr;
     errno = 0;
@@ -64,8 +64,8 @@
     in_port_t port = 0;
     sa_family_t af;
 
-    char *first_colon = strchr(addr, ':');
-    char *last_colon = strrchr(addr, ':');
+    const char *first_colon = strchr(addr, ':');
+    const char *last_colon = strrchr(addr, ':');
 
     if (!first_colon || first_colon == last_colon)
     {
@@ -86,7 +86,7 @@
         if (addr[0] == '[')
         {
             addr += 1;
-            char *bracket = last_colon - 1;
+            const char *bracket = last_colon - 1;
             if (*bracket != ']' || bracket == addr || !dns_server_port_parse(&port, last_colon + 1))
             {
                 return false;

