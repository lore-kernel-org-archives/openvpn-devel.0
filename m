From: Steffan Karger <steffan@...1856...>
Date: Sat, 25 Oct 2014 11:54:11 +0200
Message-Id: <1414230851-5350-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Remove unused variables from
	ssl_verify_openssl.c extract_x509_extension()
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

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl_verify_openssl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 56e1c11..33cd757 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -101,9 +101,7 @@ static
 bool extract_x509_extension(X509 *cert, char *fieldname, char *out, int size)
 {
   bool retval = false;
-  X509_EXTENSION *pExt;
   char *buf = 0;
-  int length = 0;
   GENERAL_NAMES *extensions;
   int nid = OBJ_txt2nid(fieldname);
 
-- 
1.9.1


