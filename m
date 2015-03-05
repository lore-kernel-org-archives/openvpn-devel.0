From: Steffan Karger <steffan@...1856...>
Date: Thu,  5 Mar 2015 22:58:36 +0100
Message-Id: <1425592716-14243-2-git-send-email-steffan@...1856...>
In-Reply-To: <1425592716-14243-1-git-send-email-steffan@...1856...>
References: <1425592716-14243-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 2/2] polarssl: make sure to always
	null-terminate the cn
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Just a precaution, this could never fail in the current code since in the
one place this function is called, the cn is already zero-initialized.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl_verify_polarssl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/ssl_verify_polarssl.c b/src/openvpn/ssl_verify_polarssl.c
index 3e8d712..976df50 100644
--- a/src/openvpn/ssl_verify_polarssl.c
+++ b/src/openvpn/ssl_verify_polarssl.c
@@ -115,7 +115,10 @@ backend_x509_get_username (char *cn, int cn_len,
 
   /* Found, extract CN */
   if (cn_len > name->val.len)
-    memcpy( cn, name->val.p, name->val.len );
+    {
+      memcpy( cn, name->val.p, name->val.len );
+      cn[name->val.len] = '\0';
+    }
   else
     {
       memcpy( cn, name->val.p, cn_len);
-- 
2.1.0


