From: Steffan Karger <steffan@...1856...>
Date: Tue,  8 Nov 2016 22:28:27 +0100
Message-Id: <1478640507-14415-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Remove unneeded check for
	extra_certs_file_inline
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

As with all the file/file_inline variable, the _inline variable is only
relevant if the file variable is equal to INLINE_FILE_TAG.  The
tls_ctx_load_extra_certs() function nicely follows this mantra.

Removing this unneeded check silences a coverity 'dereference after null
check' warning (tls_ctx_load_extra_certs() always dereferences
options->extra_cert_file, and the check implies it might be null).  In
reality, this cannot occur, because if options->extra_cert_file_inline is
non-null, so is options->extra_cert_file.  Still, coverity is correct this
this check is a bit weird, so let's fix it and make coverity happy.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 43ae73d..cb72978 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -602,7 +602,7 @@ init_ssl (const struct options *options, struct tls_root_ctx *new_ctx)
 
   /* Load extra certificates that are part of our own certificate
      chain but shouldn't be included in the verify chain */
-  if (options->extra_certs_file || options->extra_certs_file_inline)
+  if (options->extra_certs_file)
     {
       tls_ctx_load_extra_certs(new_ctx, options->extra_certs_file, options->extra_certs_file_inline);
     }
-- 
2.7.4


