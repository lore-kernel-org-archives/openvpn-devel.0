Date: Mon, 16 Feb 2026 12:07:49 +0000
From: Rudi Heitbaum <rudi@...2993...>
Message-ID: <aZMIlXEbofy5oZhD@...2995...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 2/2] ntlm: fix discards 'const' qualifier
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
    src/openvpn/ntlm.c: In function 'ntlm_phase_3':
    src/openvpn/ntlm.c:241:15: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      241 |     separator = strchr(p->up.username, '\\');
          |               ^

Signed-off-by: Rudi Heitbaum <rudi@...2993...>
---
 src/openvpn/ntlm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
index 8e913dce..244ee945 100644
--- a/src/openvpn/ntlm.c
+++ b/src/openvpn/ntlm.c
@@ -218,7 +218,7 @@ ntlm_phase_3(const struct http_proxy_info *p, const char *phase_2, struct gc_are
 
     char domain[128];
     char username[128];
-    char *separator;
+    const char *separator;
 
     ASSERT(strlen(p->up.username) > 0);
     ASSERT(strlen(p->up.password) > 0);
-- 
2.51.0


