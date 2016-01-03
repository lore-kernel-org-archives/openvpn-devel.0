References: <CAA1AbxKJwx5fckOpDMA7=9UB6NKtCET_ajkMav65YKNy791eOw@...278...>
	<1451730042-25063-1-git-send-email-arne@...1227...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <568949A2.9020502@...1856...>
Date: Sun, 3 Jan 2016 17:17:38 +0100
MIME-Version: 1.0
In-Reply-To: <1451730042-25063-1-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v5] Implement the compression V2 data
 format for stub and lz4.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi Arne,

Some final comments (mostly just nitpicking).  Other than this, I think 
the patch is ready to be merged.  I tested it against James' openvpn 3 
test server.

On 02-01-16 11:20, Arne Schwabe wrote:
> +static void
> +lz4_compress (struct buffer *buf, struct buffer work,
> +	      struct compress_context *compctx,
> +	      const struct frame* frame)
> +{
> +  bool compressed;
> +  if (buf->len <= 0)
> +    return;
> +
> +  compressed = do_lz4_compress(buf, &work, compctx, frame);
> +
> +  /* On error do_lz4_compress sets buf len to zero, just return */
> +  if (buf->len == 0)
> +    return;
>
>     /* did compression save us anything? */
>     {
>       uint8_t comp_head_byte = NO_COMPRESS_BYTE_SWAP;
> -    if (compressed && work.len < buf->len)
> +    if (compressed && work.len +2 < buf->len)

This +2 needs to go too - it only makes sense for the v2 format.

> +static void
> +lz4v2_compress (struct buffer *buf, struct buffer work,
> +		struct compress_context *compctx,
> +		const struct frame* frame)
> +{
> +  bool compressed;
> +  if (buf->len <= 0)
> +    return;
> +
> +  compressed = do_lz4_compress(buf, &work, compctx, frame);
> +
> +  /* On Error just return */
> +  if (buf->len == 0)
> +    return;
> +
> +  /* did compression save us anything?  Include 2 byte compression header
> +     in calculation */
> +  {
> +    if (compressed && work.len + 2 < buf->len)
> +      {
> +	ASSERT(buf_prepend(&work, 2));
> +	uint8_t *head = BPTR (&work);
> +	head[0] = COMP_ALGV2_INDICATOR_BYTE;
> +	head[1] = COMP_ALGV2_LZ4_BYTE;
> +	*buf = work;
> +      }
> +    else
> +      {
> +	compv2_escape_data_ifneeded(buf);
> +      }
> +  }

This extra pair of scoping braces is not needed.

> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 5a83897..b00059a 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -6318,16 +6318,20 @@ add_option (struct options *options,
>         VERIFY_PERMISSION (OPT_P_COMP);
>         if (p[1])
>   	{
> +	  options->comp.flags = 0;
>   	  if (streq (p[1], "stub"))
>   	    {
>   	      options->comp.alg = COMP_ALG_STUB;
>   	      options->comp.flags = (COMP_F_SWAP|COMP_F_ADVERTISE_STUBS_ONLY);
>   	    }
> +	  else if (streq(p[1], "stub-v2"))
> +	    {
> +	      options->comp.alg = COMP_ALGV2_UNCOMPRESSED;

I think this also needs
     options->comp.flags = COMP_F_ADVERTISE_STUBS_ONLY;

-Steffan

