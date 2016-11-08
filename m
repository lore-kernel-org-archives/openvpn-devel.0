References: <1478596632-22842-1-git-send-email-gert@...1296...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <3ade1d1d-b35a-d87c-53df-9be9d2340991@...1435...>
Date: Tue, 8 Nov 2016 11:04:23 +0100
MIME-Version: 1.0
In-Reply-To: <1478596632-22842-1-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Check previously-unchecked
 buf_alloc_write() call in crypto self-test.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 08-11-16 10:17, Gert Doering wrote:
> "It cannot be NULL", but since this is self-test infrastructure, assume
> the worst - add ASSERT() check to ensure assumptions are true.
> 
> Found by Coverity.
> 
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/crypto.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
> index 6e1e46b..41dae92 100644
> --- a/src/openvpn/crypto.c
> +++ b/src/openvpn/crypto.c
> @@ -1028,6 +1028,7 @@ test_crypto (struct crypto_options *co, struct frame* frame)
>    struct buffer encrypt_workspace = alloc_buf_gc (BUF_SIZE (frame), &gc);
>    struct buffer decrypt_workspace = alloc_buf_gc (BUF_SIZE (frame), &gc);
>    struct buffer buf = clear_buf();
> +  void * buf_p;

Most of our code would use "void *buf_p".

>    /* init work */
>    ASSERT (buf_init (&work, FRAME_HEADROOM (frame)));
> @@ -1073,7 +1074,9 @@ test_crypto (struct crypto_options *co, struct frame* frame)
>  
>        /* copy source to input buf */
>        buf = work;
> -      memcpy (buf_write_alloc (&buf, BLEN (&src)), BPTR (&src), BLEN (&src));
> +      buf_p = buf_write_alloc (&buf, BLEN (&src));
> +      ASSERT(buf_p);
> +      memcpy (buf_p, BPTR (&src), BLEN (&src));
>  
>        /* initialize work buffer with FRAME_HEADROOM bytes of prepend capacity */
>        ASSERT (buf_init (&encrypt_workspace, FRAME_HEADROOM (frame)));

ACK, whether you remove the space or not.

-Steffan


