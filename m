MIME-Version: 1.0
References: <20200213095539.11157-1-lstipakov@...277...>
In-Reply-To: <20200213095539.11157-1-lstipakov@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 13 Feb 2020 12:13:53 -0500
Message-ID: <CAKuzo_jvKnwprbs=0eq6tiYp_bD2gRTjd1NnXtOs-tgd_=PQqQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] cryptoapi.c: fix run-time check failure
 in msvc debugger
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

Hi,

On Thu, Feb 13, 2020 at 4:57 AM Lev Stipakov <lstipakov@...277...> wrote:
>
> From: Lev Stipakov <lev@...515...>
>
> When using certificate without RSA_PKCS1_PSS_PADDING padding,
> "saltlen" is passed unitialized to priv_enc_CNG(), which causes
>
>  > Run-Time Check Failure #3 - The variable 'saltlen' is being used without being initialized.
>
> in VS debugger.
>
> Initialize saltlen (and other variable for the sake of consistence) to zero

"consistency"

> to avoid above failure.
>
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>  src/openvpn/cryptoapi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
> index 1bf74fcd..30eba7b2 100644
> --- a/src/openvpn/cryptoapi.c
> +++ b/src/openvpn/cryptoapi.c
> @@ -882,9 +882,9 @@ pkey_rsa_sign(EVP_PKEY_CTX *ctx, unsigned char *sig, size_t *siglen,
>      EVP_MD *md = NULL;
>      const wchar_t *alg = NULL;
>
> -    int padding;
> -    int hashlen;
> -    int saltlen;
> +    int padding = 0;
> +    int hashlen = 0;
> +    int saltlen = 0;
>
>      pkey = EVP_PKEY_CTX_get0_pkey(ctx);
>      if (pkey)

Yeah, technically it may be "undefined behaviour" to pass an
uninitialized var to a function even when its not used there.

Acked-by: Selva Nair <selva.nair@...277...>




Selva

