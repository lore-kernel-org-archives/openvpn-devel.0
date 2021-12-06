Date: Mon, 6 Dec 2021 09:59:14 +0100 (CET)
Message-Id: <202112060859.1B68xEuq020316@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211201180727.2496903-3-arne@...1227...>
References: <20211201180727.2496903-3-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove cipher_ctx_get_cipher_kt
 and replace with direct context calls
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Change makes sense, resulting code passes t_client tests (with and
without AES ciphers), on OpenSSL 1.1 and mbedTLS builds.  

Thanks for the explanation wrt the ASSERT() calls - indeed, if the 
caller already checks the cipher itself, no need to double-check it 
in the called function.

Reviewing the change to crypto_backend.h I noticed that the comments
seem to be "german invalid grammar" according to what I remember from 
school...

+ * @param ctx           Cipher's context. May not be NULL.

shouldn't that be "Must not be NULL" for "NULL is not allowed" here?
(There are many more of these, so it's not *this* patch introducing
the error - so, not changing these on the fly)


Another observation: cipher_ctx_mode_cbc() and cipher_ctx_mode_ofb_cfb()
seem to want the same thing ("no AEAD, no EVP_CIPH_FLAG_CTS") but 
do it in different ways - this looks a bit weird.

And then, cipher_ctx_mode_aead() does not use "early return" on
if (!ctx)... which is inconsistent to the previous two.

And *then*, _cbc() use EVP_CIPHER_CTX_get_mode(), while _ofb_cfb()
uses EVP_CIPHER_CTX_mode(), which seems to be the 3.0 <-> 1.1 variants,
and we do have a compat call...

Could these be unified in a followup patch, please?


Your patch has been applied to the master branch.

commit 0b1c721e4f19c84ea35a2e266c3913eb893355ec
Author: Arne Schwabe
Date:   Wed Dec 1 19:07:21 2021 +0100

     Remove cipher_ctx_get_cipher_kt and replace with direct context calls

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20211201180727.2496903-3-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23278.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


