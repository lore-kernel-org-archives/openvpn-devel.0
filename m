MIME-Version: 1.0
References: <20210607182602.273-1-lstipakov@...277...>
In-Reply-To: <20210607182602.273-1-lstipakov@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 7 Jun 2021 15:38:14 -0400
Message-ID: <CAKuzo_hezzGWecLBxC8_t22fNU9x2VeEe_n1DnBdCvWLBJEaVA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] options.c: fix msvc build error
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

On Mon, Jun 7, 2021 at 2:56 PM Lev Stipakov <lstipakov@...277...> wrote:
>
> From: Lev Stipakov <lev@...515...>
>
> Commit b7fe49c ("Do not require CA when peer-fingerprint is used") broke
> msvc build by adding #ifdef within msg() macro call.
>
>     options.c(2074,1): error C2121: '#': invalid character: possibly the =
result of a macro expansion
>     options.c(2074,1): error C2146: syntax error: missing ')' before iden=
tifier 'ifndef'
>     options.c(2074,1): error C2059: syntax error: ')'
>
> Fix by moving #ifdef outside of msg().
>
> Reported-by: Samuli Sepp=C3=A4nen <samuli@...515...>
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>  src/openvpn/options.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 6bbe5c15..606e6903 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -2067,11 +2067,12 @@ check_ca_required(const struct options *options)
>          return;
>      }
>
> -    msg(M_USAGE, "You must define CA file (--ca)"
> +    const char* str =3D "You must define CA file (--ca)"
>  #ifndef ENABLE_CRYPTO_MBEDTLS
>          " or CA path (--capath)"
>  #endif
> -        " and/or peer fingeprint verification " "(--peer-fingerprint)");
> +        " and/or peer fingeprint verification " "(--peer-fingerprint)";
> +    msg(M_USAGE, str);
>  }

I forgot msg was a macro... Surprisingly, gcc preprocessor can handle this.

Let's also use this opportunity to fix the typo "fingeprint" and
remove the unneeded " " before (--peer-fingerprint). If it could be
done at commit time?

Acked-by: selva.nair@...277...

