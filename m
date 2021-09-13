Date: Mon, 13 Sep 2021 14:39:43 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YT9GjxtLencLAZlr@...1296...>
References: <20210904095629.6273-1-a@...2181...>
 <20210904095629.6273-7-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="CRhYpmpZ1jlHcxXl"
Content-Disposition: inline
In-Reply-To: <20210904095629.6273-7-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 6/7] set TLS 1.2 as minimum by default
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--CRhYpmpZ1jlHcxXl
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Sep 04, 2021 at 11:56:28AM +0200, Antonio Quartulli wrote:
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index f2fb6d64..6f6eb73d 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -850,6 +850,7 @@ init_options(struct options *o, const bool init_gc)
>      o->use_prediction_resistance =3D false;
>  #endif
>      o->tls_timeout =3D 2;
> +    o->ssl_flags =3D (TLS_VER_1_2 << SSLF_TLS_VERSION_MIN_SHIFT);
>      o->renegotiate_bytes =3D -1;
>      o->renegotiate_seconds =3D 3600;
>      o->renegotiate_seconds_min =3D -1;

This code confuses me.  We now unconditionally initialize ssl_flags to
"TLS_VER_1_2"...

> @@ -3140,6 +3141,21 @@ need_compatibility_before(const struct options *o,=
 int version)
>  static void
>  options_set_backwards_compatible_options(struct options *o)
>  {
> +    /* TLS min version is not set */
> +    if ((o->ssl_flags & SSLF_TLS_VERSION_MIN_MASK) =3D=3D 0)
> +    {

... and then we check if that happens to be "0", so we can invoke the
compat handler...

The first hunk looks wrong.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--CRhYpmpZ1jlHcxXl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhP0aPAAoJEB2Cnv7KVigSCM8MAJLZBg0Xux88ScFBclHW7k/K
pvhhbsa0FbcR3Qs+RorC4j533AHUgn4RRAqKfi6HC8nzZX29JxSPr6pHWCJXVeUZ
Q7BdjwQEZEz35h2K2JE0IV6N9z9J40z98HeaEP7mRxt1YlDF/U/rKOdouvb08bQC
mz9j7MUccR4Ix59XdNIx1wfeZFwl4Hg4XC3lXBNFgg0vP4SjMvsXZor1YxSAoj7D
Sir1FjGptlH8EacLcYdZMQS0/WroC1OZDVWGocmPlAImU35nQ9fUg9B0OAtUSr8H
xci6oNtoVNoHf1JGFGIM1rW5b+Yn1ne357tgzt9vO/mjtzwVaqqaLbvt0cykqZY6
UAYrD0vk7uFyZPFKdD2hfBEiH33FqxAIAbexKc5Jbg9U6B36pFvSmL2MMUZoxmk8
zkgKk8RG5tX72RNYXa7dLs2imNbzAvC2rPCfSci2LqgmtNkyOmzaes9sQ3x/UitG
RXttNWZFWyq0l5jHsGUhh5r1y23PYyJVM/9LPn0oQA==
=7bar
-----END PGP SIGNATURE-----

--CRhYpmpZ1jlHcxXl--

