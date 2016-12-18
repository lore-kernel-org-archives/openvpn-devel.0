References: <1482078820-14635-1-git-send-email-steffan@...1856...>
	<CAKuzo_ge1S6BFPaTmipkTq9_gMYgYFBWWprKKEOpNvGeJjt_ag@...278...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <949ac6c4-093f-3c03-c597-2ac6855b3477@...1856...>
Date: Sun, 18 Dec 2016 19:20:39 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_ge1S6BFPaTmipkTq9_gMYgYFBWWprKKEOpNvGeJjt_ag@...278...>
Subject: Re: [Openvpn-devel] [PATCH] reformatting: fix style in crypto*.{c,
	h}
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On 18-12-16 18:45, Selva Nair wrote:
> Not a comprehensive review, but a couple of teeny things I noticed ..

Thanks.

> On Sun, Dec 18, 2016 at 11:33 AM, Steffan Karger <steffan@...1856...
> <mailto:steffan@...1856...>> wrote:
> 
> in crypto.c
> 
>     @@ -1389,13 +1396,15 @@ read_key_file(struct key2 *key2, const char
>     *file, const unsigned int flags)
>          {
>              if (!key2->n)
>              {
>     -            msg(M_FATAL, "Insufficient key material or header text
>     not found in file '%s' (%d/%d/%d bytes found/min/m
>     ax)",
>     +            msg(M_FATAL,
>     +                "Insufficient key material or header text not found
>     in file '%s' (%d/%d/%d bytes found/min/max)",
>                      error_filename, count, onekeylen, keylen);
>              }
> 
>              if (state != PARSE_FINISHED)
>              {
>     -            msg(M_FATAL, "Footer text not found in file '%s'
>     (%d/%d/%d bytes found/min/max)",
> 
> 
> wrong indent :)

Good catch!  Will fix.

> In cryptoapi.c
> 
>     @@ -290,7 +305,8 @@ rsa_priv_enc(int flen, const unsigned char
>     *from, unsigned char *to, RSA *rsa, i
> 
>      /* decrypt */
>      static int
>     -rsa_priv_dec(int flen, const unsigned char *from, unsigned char
>     *to, RSA *rsa, int padding)
>     +rsa_priv_dec(int flen, const unsigned char *from, unsigned char
>     *to, RSA *rsa,
>     +        int padding)
>      {
>          /* I haven't been able to trigger this one, but I want to know
>     if it happens... */
>          assert(0);
> 
> 
> following this there is a
> 
> static int init(RSA *rsa)
> 
> which appears unused (at least mingw always complains so)
> Can it be removed?

I don't know, but if so I'd like to do that as a separate patch.

>> @@ -509,7 +534,7 @@ SSL_CTX_use_CryptoAPI_certificate(SSL_CTX
> *ssl_ctx, const char *cert_prop)
>>         goto err;
>>   }
>>    /* SSL_CTX_use_RSAPrivateKey() increased the reference count in
> 'rsa', so
>>-  * we decrease it here with RSA_free(), or it will never be cleaned
> up. */
>>+   * we decrease it here with RSA_free(), or it will never be cleaned
> up. */
> 
> Add a new line before the closing */ ?
> 
> Further, cryptoapi.c has a few for loops with opening brace on same line
> as for, those could be wrapped with a new line?

Yeah, there are quite a lot of such comments in cryptoapi.c, so I
decided to leave it like that (and tbh I don't really care about these).
 I'll fix the for's though.

> Otherwise all look "safe and good" white space changes.

Great.  v2 upcoming!

-Steffan

