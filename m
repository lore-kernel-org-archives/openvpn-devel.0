From: Steffan Karger <steffan@...1856...>
Date: Sun, 12 Jan 2014 20:39:31 +0100
Message-Id: <1389555572-6210-3-git-send-email-steffan@...1856...>
In-Reply-To: <1389555572-6210-1-git-send-email-steffan@...1856...>
References: <1389555572-6210-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 2/3] Remove unused variables from
	ssl_verify_polarssl.c's x509_get_serial()
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
 src/openvpn/ssl_verify_polarssl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/src/openvpn/ssl_verify_polarssl.c b/src/openvpn/ssl_verify_polarssl.c
index 5db4f02..e5ccd90 100644
--- a/src/openvpn/ssl_verify_polarssl.c
+++ b/src/openvpn/ssl_verify_polarssl.c
@@ -125,8 +125,6 @@ x509_get_username (char *cn, int cn_len,
 char *
 x509_get_serial (x509_cert *cert, struct gc_arena *gc)
 {
-  int ret = 0;
-  int i = 0;
   char *buf = NULL;
   size_t len = cert->serial.len * 3 + 1;
 
-- 
1.8.3.2


