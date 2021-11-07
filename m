References: <20211107090147.3150261-1-arne@...1227...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <ca41ed8c-632b-7be4-e055-e8f60b81f8ee@...1856...>
Date: Sun, 7 Nov 2021 11:30:33 +0100
MIME-Version: 1.0
In-Reply-To: <20211107090147.3150261-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Remove custom PRNG function
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 07-11-2021 10:01, Arne Schwabe wrote:
> Remove the custom PRNG from OpenVPN and instead rely always on the random
> number generator from the SSL library. The only place that this is in a
> performance critical place is the CBC IV generation. Even with that in mind
> a micro benchmark shows no significant enough change with OpenSSL 3.0:
> 
> ------------------------------------------------------------------------
> Benchmark                              Time             CPU   Iterations
> ------------------------------------------------------------------------
> BM_OpenSSL_RAND                      842 ns          842 ns       753401
> BM_OpenVPN_RAND                      743 ns          743 ns       826690
> BM_Encrypt_AES_CBC_dummy            1044 ns         1044 ns       631530
> BM_Encrypt_AES_CBC_RAND_bytes       1892 ns         1891 ns       346566
> BM_Encrypt_AES_CBC_prng_bytes       1818 ns         1817 ns       373970
> 
> (source https://gist.github.com/schwabe/029dc5e5a690df8e2e3f774a13ec7bce)


Feature-ACK. The performance of the PRNGs once was much larger, *and*
OpenVPN has moved along from CBC mode to (AES-)GCM. So there's not much
reason left to keep our own prng implementation.

> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  Changes.rst                           |  6 ++
>  doc/man-sections/advanced-options.rst | 17 ------
>  src/openvpn/crypto.c                  | 88 +--------------------------
>  src/openvpn/crypto.h                  | 20 ------
>  src/openvpn/init.c                    | 30 ---------
>  src/openvpn/options.c                 | 30 +--------
>  src/openvpn/options.h                 |  2 -
>  src/openvpn/ps.c                      |  5 +-
>  src/openvpn/ssl.c                     |  1 -
>  9 files changed, 9 insertions(+), 190 deletions(-)
> 
> diff --git a/Changes.rst b/Changes.rst
> index b08bff3d7..174e233c8 100644
> --- a/Changes.rst
> +++ b/Changes.rst
> @@ -94,6 +94,11 @@ TLS 1.0 and 1.1 are deprecated
>      Should backwards compatibility with older OpenVPN peers be
>      required, please see the ``--compat-mode`` instead.
>  
> +``--prng`` has beeen removed
> +    OpenVPN used to implement its own PRNG based on a hash. However implementing
> +    a PRNG is better left to a crypto library. So we use mbed TLS or OpenSSL
> +    PRNG instead now.

That last sentence doesn't read well. Suggestion: "So we use the PRNG
from mbed TLS or OpenSSL now."

>  void
>  prng_bytes(uint8_t *output, int len)
>  {
> -    static size_t processed = 0;
> -
> -    if (nonce_md)
> -    {
> -        const int md_size = md_kt_size(nonce_md);
> -        while (len > 0)
> -        {
> -            const int blen = min_int(len, md_size);
> -            md_full(nonce_md, nonce_data, md_size + nonce_secret_len, nonce_data);
> -            memcpy(output, nonce_data, blen);
> -            output += blen;
> -            len -= blen;
> -
> -            /* Ensure that random data is reset regularly */
> -            processed += blen;
> -            if (processed > PRNG_NONCE_RESET_BYTES)
> -            {
> -                prng_reset_nonce();
> -                processed = 0;
> -            }
> -        }
> -    }
> -    else
> -    {
> -        ASSERT(rand_bytes(output, len));
> -    }
> +    ASSERT(rand_bytes(output, len));
>  }

Hmm, this leaves just this tiny wrapper. Why not just remove that too,
and just use ASSERT(rand_bytes()) in the callers? (I can live with the
wrapper too, if you prefer to keep it.)


> diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
> index a61176172..a0f8a00e9 100644
> --- a/src/openvpn/ps.c
> +++ b/src/openvpn/ps.c
> @@ -912,10 +912,7 @@ port_share_open(const char *host,
>  
>          /* no blocking on control channel back to parent */
>          set_nonblock(fd[1]);
> -
> -        /* initialize prng */
> -        prng_init(NULL, 0);
> -
> +        
>          /* execute the event loop */

Trailing whitespace inserted.

Other from these details, this looks good to me. As long as the typos
and whitespace is fixed before committing:

Acked-by: Steffan Karger <steffan@...1856...>

-Steffan

