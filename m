From: Gert Doering <gert@...1296...>
Date: Mon,  6 May 2013 09:55:41 +0200
Message-Id: <1367826941-22412-1-git-send-email-gert@...1296...>
In-Reply-To: <1367759408-16770-1-git-send-email-gert@...1296...>
References: <1367759408-16770-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH v2] Use constrain_int() instead of
	MIN()+syshead.c compat definition - v2.
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

Reverts commit 15ca5c297b556fbb, instead change ssl_openssl.c to use
"constrain_int()", which already exists in "integer.h".

Using this instead of min_int() ensures that the result is always bounded
to 0...256 even in the case of a potential MAX_INT overflow.
---
 src/openvpn/ssl_openssl.c |    2 +-
 src/openvpn/syshead.h     |    7 -------
 2 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 79cc056..c1b19dc 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -232,7 +232,7 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
           // %.*s format specifier expects length of type int, so guarantee
           // that length is small enough and cast to int.
           msg (M_WARN, "No valid translation found for TLS cipher '%.*s'",
-              (int) MIN(current_cipher_len, 256), current_cipher);
+                 constrain_int(current_cipher_len, 0, 256), current_cipher);
         }
       else
 	{
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 0c3e4ee..db02c23 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -399,13 +399,6 @@
 #endif
 
 /*
- * do we have the MIN() macro?
- */
-#ifndef MIN
-#define MIN(a,b) (((a)<(b))?(a):(b))
-#endif
-
-/*
  * Do we have the capability to report extended socket errors?
  */
 #if defined(HAVE_LINUX_TYPES_H) && defined(HAVE_LINUX_ERRQUEUE_H) && defined(HAVE_SOCK_EXTENDED_ERR) && defined(HAVE_MSGHDR) && defined(HAVE_CMSGHDR) && defined(CMSG_FIRSTHDR) && defined(CMSG_NXTHDR) && defined(IP_RECVERR) && defined(MSG_ERRQUEUE) && defined(SOL_IP) && defined(HAVE_IOVEC)
-- 
1.5.6.5


