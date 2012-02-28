MIME-Version: 1.0
Sender: fabian@...1547...
In-Reply-To: <1330446625-5768-1-git-send-email-dejong@...1435...>
References: <1330446625-5768-1-git-send-email-dejong@...1435...>
From: Fabian Knittel <fabian.knittel@...1547...>
Date: Tue, 28 Feb 2012 18:10:07 +0100
Message-ID: <CAP+U6tJUgraKJLB2BEdoW3_WHWxc_UFV=YhjQguWyfwDKPof_Q@...278...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Added support for new PolarSSL 1.1
	RNG
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Adriaan de Jong <dejong@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

Hi Adriaan,

I only found a minor nit:

2012/2/28 Adriaan de Jong <dejong@...1435...>:
> --- a/ssl.c
> +++ b/ssl.c
> @@ -385,6 +385,11 @@ init_ssl (const struct options *options, struct tls_=
root_ctx *new_ctx)
> =C2=A0 =C2=A0 =C2=A0 tls_ctx_restrict_ciphers(new_ctx, options->cipher_li=
st);
> =C2=A0 =C2=A0 }
>
> +#ifdef USE_POLARSSL
> + =C2=A0/* Fox-IT hardening: Personalise the random by mixing in the cert=
ificate */
> + =C2=A0tls_ctx_personalise_random (new_ctx);
> +#endif

Unless it's intentional, the "Fox-IT hardening" string is probably
from an earlier, internal iteration?

The rest looks fine AFAICT. :)

Cheers
Fabian

