From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 17 Feb 2020 10:29:41 +0200
Message-Id: <20200217082942.173-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] ssl.c: refactor tls_item_in_cipher_list()
 code
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

 - remove unneeded _orig variable which stores pointer
to tokenized string. Unlike strsep(), strtok() doesn't modify
pointer itself, only string, so it is safe to call free() on that pointer.

 - "token" points to content inside tokenized string. It becomes
dangling pointer after freeing that string. Check its value before
free() call.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/ssl.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index e708fc93..8cba3a76 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1918,7 +1918,6 @@ bool
 tls_item_in_cipher_list(const char *item, const char *list)
 {
     char *tmp_ciphers = string_alloc(list, NULL);
-    char *tmp_ciphers_orig = tmp_ciphers;
 
     const char *token = strtok(tmp_ciphers, ":");
     while (token)
@@ -1929,9 +1928,11 @@ tls_item_in_cipher_list(const char *item, const char *list)
         }
         token = strtok(NULL, ":");
     }
-    free(tmp_ciphers_orig);
 
-    return token != NULL;
+    bool found = token != NULL;
+    free(tmp_ciphers);
+
+    return found;
 }
 
 void
-- 
2.17.1


