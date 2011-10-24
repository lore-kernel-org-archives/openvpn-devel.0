Message-ID: <4EA52800.4080205@...1147...>
Date: Mon, 24 Oct 2011 10:55:28 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <1319445962-21686-1-git-send-email-dejong@...1435...>
	<1319445962-21686-3-git-send-email-dejong@...1435...>
In-Reply-To: <1319445962-21686-3-git-send-email-dejong@...1435...>
Subject: Re: [Openvpn-devel] [PATCH 3/3] Changed default algorithm for
 PolarSSL to AES-128, as BF is not supported
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
To: Adriaan de Jong <dejong@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

I'd NACK this patch : the default behaviour of OpenVPN should be
independent of the SSL implementation.

JJK

Adriaan de Jong wrote:
> Signed-off-by: Adriaan de Jong <dejong@...1435...>
> ---
>  options.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/options.c b/options.c
> index 39e7a57..d917072 100644
> --- a/options.c
> +++ b/options.c
> @@ -810,7 +810,12 @@ init_options (struct options *o, const bool init_gc)
>    o->server_poll_timeout = 0;
>  #endif
>  #ifdef USE_CRYPTO
> +#ifdef USE_OPENSSL
>    o->ciphername = "BF-CBC";
> +#endif
> +#ifdef USE_POLARSSL
> +  o->ciphername = "AES-128-CBC";
> +#endif
>    o->ciphername_defined = true;
>    o->authname = "SHA1";
>    o->authname_defined = true;
>   


