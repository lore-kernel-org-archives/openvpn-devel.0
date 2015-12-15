MIME-Version: 1.0
In-Reply-To: <1449751187-11395-1-git-send-email-arne@...1227...>
References: <1444571495-7670-1-git-send-email-arne@...1227...>
	<1449751187-11395-1-git-send-email-arne@...1227...>
From: Steffan Karger <steffan@...1856...>
Date: Tue, 15 Dec 2015 21:33:21 +0100
Message-ID: <CAA1AbxKJwx5fckOpDMA7=9UB6NKtCET_ajkMav65YKNy791eOw@...278...>
Subject: Re: [Openvpn-devel] [PATCHv2] Implement the compression V2 data
 format for stub and lz4.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi Arne,

Some comments after a first review:

On Thu, Dec 10, 2015 at 1:39 PM, Arne Schwabe <arne@...1227...> wrote:
> V2: Fix an unintended change in the old lz4 decompress code.
>
> [..snip...]
>
> +static void
> +lz4_compress (struct buffer *buf, struct buffer work,
> +             struct compress_context *compctx,
> +             const struct frame* frame)
> +{
> +  if (buf->len <= 0)
> +    return;
> +  bool compressed = do_lz4_compress(buf, &work, compctx, frame);

This looks like it will blow up on compilers that still not properly
support C99 (ie MSVC); declaration-after-statement.

> @@ -128,13 +141,73 @@ lz4_compress (struct buffer *buf, struct buffer work,
>    }
>  }
>
> +
> +static void
> +lz4v2_compress (struct buffer *buf, struct buffer work,
> +               struct compress_context *compctx,
> +               const struct frame* frame)
> +{
> +  bool compressed;
> +  if (buf->len <= 0)
> +    return;
> +
> +   compressed = do_lz4_compress(buf, &work, compctx, frame);
> +  if (buf->len <= 0)
> +    return;
> +
> +  /* On Error just return */
> +  if (buf->len == 0)
> +    return;

A space too many before compressed.  And the second check on buf->len
seems pointless.

> +  /* did compression save us anything? */
> +  {
> +    if (compressed && work.len < buf->len)

We could also check against work.len + 2, since we will be adding two
bytes of we are going to use compression. Should save some more bytes.

> @@ -176,7 +233,57 @@ lz4_decompress (struct buffer *buf, struct buffer work,
>      }
>    else
>      {
> +        struct gc_arena gc = gc_new ();
>        dmsg (D_COMP_ERRORS, "Bad LZ4 decompression header byte: %d", c);
> +      msg (M_INFO, "PKT_DUMP: %s", format_hex (BPTR (buf), buf->len, 0, &gc));
> +      buf->len = 0;
> +    }
> +}

Indenting looks off.  And don't forget to call gc_free().

> diff --git a/src/openvpn/compstub.c b/src/openvpn/compstub.c
> index 2ab7163..0f21a6f 100644
> --- a/src/openvpn/compstub.c
> +++ b/src/openvpn/compstub.c
> @@ -73,6 +73,8 @@ stub_compress (struct buffer *buf, struct buffer work,
>      }
>  }
>
> +
> +

Pure whitespace change?

-Steffan

