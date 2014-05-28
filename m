Message-ID: <53863C41.1020408@...1856...>
Date: Wed, 28 May 2014 21:42:57 +0200
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <5381FEFF.1040609@...1856...>
	<201405251956.s4PJuRUW018867@...1295...>
In-Reply-To: <201405251956.s4PJuRUW018867@...1295...>
Content-Type: multipart/mixed; boundary="------------050406060507080703070003"
Subject: [Openvpn-devel] [PATCH applied] Re: Use SSL_MODE_RELEASE_BUFFERS if
 available
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------050406060507080703070003
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

On 25-05-14 21:56, Gert Doering wrote:
> your patch has been applied to the OpenVPN master branch.  Sorry it took
> us so long...

Just noticed this patch needed a little more then resolving the merge
conflict. The patch submission in 2011 was before the cipher abstraction
layer was added. The attached patch contains the required extra change.

I noticed this while working on something else, compiling using
--enable-strict. The compiler is very good in catching these kind of
mistakes, but there are currently too many warnings to spot the useful
ones. This is a good example why I think it would be worthwhile to get
rid of more warnings.

-Steffan

--------------050406060507080703070003
Content-Type: text/x-patch;
	name="0001-Fix-merge-error-in-a6c573d-the-ssl-ctx-is-now-abstra.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-Fix-merge-error-in-a6c573d-the-ssl-ctx-is-now-abstra.pa";
	filename*1="tch"

From 63cd7bba2884cc713118783adfe3f1b20623457d Mon Sep 17 00:00:00 2001
From: Steffan Karger <steffan@...1856...>
Date: Wed, 28 May 2014 21:40:34 +0200
Subject: [PATCH] Fix merge error in a6c573d, the ssl ctx is now abstracted.

Between the origin patch submission (2011) and now the cipher abstraction
layer has been added. This patch slipped through without proper adjustment.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl_openssl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 4862bad..c9d2d26 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -199,7 +199,7 @@ tls_ctx_set_options (struct tls_root_ctx *ctx, unsigned int ssl_flags)
   }
 
 #ifdef SSL_MODE_RELEASE_BUFFERS
-  SSL_CTX_set_mode (ctx, SSL_MODE_RELEASE_BUFFERS);
+  SSL_CTX_set_mode (ctx->ctx, SSL_MODE_RELEASE_BUFFERS);
 #endif
   SSL_CTX_set_session_cache_mode (ctx->ctx, SSL_SESS_CACHE_OFF);
   SSL_CTX_set_default_passwd_cb (ctx->ctx, pem_password_callback);
-- 
1.9.1


--------------050406060507080703070003--

