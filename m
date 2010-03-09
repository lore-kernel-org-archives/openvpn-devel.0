From: David Sommerseth <openvpn.list@...1114...>
Date: Tue,  9 Mar 2010 15:34:42 +0100
Message-Id: <1268145282-8727-1-git-send-email-openvpn.list@...1114...>
Subject: [Openvpn-devel] [PATCH] Don't ASSERT() on stream cipher
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
Cc: "Vladimir I. Kobylyanskiy" <kentlinux@...384...>, David Sommerseth <dazo@...384...>

From: Vladimir I. Kobylyanskiy <kentlinux@...384...>

We (Ltd. LISSI, http://www.lissi.ru, info at lissi.ru),
are trying to use OpenVPN with stream ciphers,
including Russian cipher GOST
28147-89(ALLOW_NON_CBC_CIPHERS flag is set).

And we found the bug:
function EVP_CipherFinal() returns 0, when cipher has
block_size == 1(stream cipher). So hear is the patch to
fix the bug.

sf.net tracker:
<https://sourceforge.net/tracker/?func=detail&aid=1552062&group_id=48978&atid=454721>

Signed-off-by: David Sommerseth <dazo@...384...>
---
 crypto.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/crypto.c b/crypto.c
index 444f036..fd7d2ef 100644
--- a/crypto.c
+++ b/crypto.c
@@ -159,7 +159,8 @@ openvpn_encrypt (struct buffer *buf, struct buffer work,
 	  /* Flush the encryption buffer */
 	  ASSERT (EVP_CipherFinal (ctx->cipher, BPTR (&work) + outlen, &outlen));
 	  work.len += outlen;
-	  ASSERT (outlen == iv_size);
+	  if (mode == EVP_CIPH_CBC_MODE)
+            ASSERT (outlen == iv_size);
 
 	  /* prepend the IV to the ciphertext */
 	  if (opt->flags & CO_USE_IV)
-- 
1.6.6.1


