MIME-Version: 1.0
From: Guido Vranken <guidovranken@...277...>
Date: Thu, 8 Jun 2017 00:44:15 +0200
Message-ID: <CAO5O-ELXwXgGtRFou=FY1TAhW4W4BHPZF4=rqSY877njtXNMJg@...278...>
Subject: [Openvpn-devel] [PATCH] Refactor my_strupr such that it will not
 check and possibly alter bytes after the string's null terminator for
 strings of length 0
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Signed-off-by: Guido Vranken <guidovranken@...277...>
---
 src/openvpn/ntlm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
index 0c43681..9348337 100644
--- a/src/openvpn/ntlm.c
+++ b/src/openvpn/ntlm.c
@@ -130,17 +130,16 @@ gen_nonce(unsigned char *nonce)
     }
 }

-unsigned char *
+void
 my_strupr(unsigned char *str)
 {
     /* converts string to uppercase in place */
-    unsigned char *tmp = str;

-    do
+    while (*str)
     {
         *str = toupper(*str);
-    } while (*(++str));
-    return tmp;
+        str++;
+    }
 }

 static int
-- 
2.1.4

