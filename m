Message-ID: <510D0687.1030503@...1227...>
Date: Sat, 02 Feb 2013 13:28:55 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1345106302-22850-1-git-send-email-heiko.hund@...1489...>
	<1345106302-22850-2-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1345106302-22850-2-git-send-email-heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] [PATCH 1/7] refine assertion to allow other
 modes than CBC
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

Am 16.08.12 10:38, schrieb Heiko Hund:
> cipher_ctx_final() only returns an outlen in CBC mode. If CFB or OFB
> are used the assertion outlen == iv_len is always false.
>
> There's no CBC mode defined for the GOST 28147-89 block cipher. Hence
> this patch is needed for it to work. It's needed for other ciphers like
> BF-CFB as well, though.
>
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>
> ---
>  src/openvpn/crypto.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
> index ac2eecd..2f67e5e 100644
> --- a/src/openvpn/crypto.c
> +++ b/src/openvpn/crypto.c
> @@ -153,7 +153,7 @@ openvpn_encrypt (struct buffer *buf, struct buffer work,
>  	  /* Flush the encryption buffer */
>  	  ASSERT(cipher_ctx_final(ctx->cipher, BPTR (&work) + outlen, &outlen));
>  	  work.len += outlen;
> -	  ASSERT (outlen == iv_size);
> +	  ASSERT (mode != OPENVPN_MODE_CBC || outlen == iv_size);
>  
>  	  /* prepend the IV to the ciphertext */
>  	  if (opt->flags & CO_USE_IV)

I have a user of my app that also tripped over this asssert line:

> Here is the log that pointed it to me from the server side.
>
> Wed Jan 30 14:47:56 2013 208.54.86.158:52876 WARNING: 'cipher' is used
> inconsistently, local='cipher AES-128-CBC', remote='cipher AES-128-CFB'
>
> Before that I had used cipher AES-256-CFB8, but I had forgotten the 8 on the
> Android.



