Message-ID: <45211F3B.3050403@...797...>
Date: Mon, 02 Oct 2006 18:16:27 +0400
From: kent <kent@...797...>
MIME-Version: 1.0
Subject: [Openvpn-devel] NON_CBC_CIPHER bug
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi!

We (Ltd. LISSI, http://www.lissi.ru, info at lissi.ru),
are trying to use OpenVPN with stream ciphers,
including Russian cipher GOST
28147-89(ALLOW_NON_CBC_CIPHERS flag is set).

And we found the bug:
function EVP_CipherFinal() returns 0, when cipher has
block_size == 1(stream cipher). So hear is the patch to
fix the bug.

P.S.: is it posible to make option in configure
"--allow_non_cbc"?


--- openvpn-2.0.7/crypto.c 2005-11-01 14:06:11.000000000 +0300
+++ openvpn-2.0.7-kent/crypto.c 2006-09-04 18:51:38.729055336 +0400
@@ -165,7 +165,9 @@
/* Flush the encryption buffer */
ASSERT (EVP_CipherFinal (ctx->cipher, BPTR (&work)+ outlen, &outlen));
work.len += outlen;
- ASSERT (outlen == iv_size);
+
+ if (mode == EVP_CIPH_CBC_MODE)
+ ASSERT (outlen == iv_size);

/* prepend the IV to the ciphertext */
if (opt->flags & CO_USE_IV)


-- 
Vladimir I. Kobylyanskiy,
Ltd. LISSI, http://www.lissi.ru


