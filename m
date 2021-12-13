Message-ID: <274325af-dbe6-71be-ae2e-62a498ac9497@...1227...>
Date: Mon, 13 Dec 2021 19:41:08 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20211213150654.3993358-1-arne@...1227...>
 <202112131741.1BDHf4ec080420@...2054...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <202112131741.1BDHf4ec080420@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Remove cipher_kt_t and
 change type to const char* in API
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 13.12.21 um 18:41 schrieb Gert Doering:
> Acked-by: Gert Doering <gert@...1296...>
> 
> Thanks to Selva for the v2 review, and thanks for the timely v3 + v4.
> 
> I have tested this most thoroughly this time...
> 
>   - Linux, OpenSSL 1.1.1l   (full client + server side tests) -> OK
>   - Linux, mbedTLS 2.27.0   (full client + server side tests) -> ????
>   - Linux, OpenSSL 3.0.0    (full client side tests)          -> OK
>   - FreeBSD, OpenSSL 1.1.1h  (fairly thorough client side tests) -> OK
>   - FreeBSD, mbedTLS 2.16.11 (fairly thorough client side tests) ->
> 
> and everything went well.
> 
> Plus, stare-at code, which also looks good (Selva's points addressed).
> 
> I have not fixed the "TYPE* x" vs. "TYPE *x" this round, as it will
> lead to extra rounds of conflicts with the later patchsets.  We have
> agreed on IRC to do an uncrustify run when the "frame" set (xx/21) is in.
> 
> Some observations and request for a followup patch:
> 
>   - crypto_mbedtls/cipher_ctx_init() has a sequence of events that need
>     swapping
> 
> +    const mbedtls_cipher_info_t *kt = cipher_get(ciphername);
> +    int key_len = kt->key_bitlen/8;
> +
> +    ASSERT(kt);
> 
>     ... if kt is NULL, it won't reach the ASSERT()...
>     (this is unlikely to happen, so not a showstopper today, but still)
> 
>   - crypto_openssl.c has functions that do not check the return value
>     of cipher_get() (e.g. cipher_kt_iv_size()) and some that do
>     (e.g. cipher_kt_block_size()) - is this intentional, due to "it is
>     ok to pass NULL to EVP_CIPHER_iv_length()", or an oversight?
> 
>   - cipher_kt_mode_cbc(), cipher_kt_mode_ofb_cfb() and cipher_kt_mode_aead()
>     do very similar things - except that the coding style of the third
>     is totally different...
> 
>   - cipher_ctx_init() ASSERTs on ciphername & ctx, but not on *kt
>     - intentional and guaranteed safe?

This was the same mess before but less obvious to be honest. Just now 
with instead blindly taking ctx having a cipher_get it is now become 
obvious that some of these functions expect their input to be always 
correct.

Arne

