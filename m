Date: Sat, 6 Aug 2022 12:16:29 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Yu4/fVDdT8VKNUjn@...1296...>
References: <20220805151325.14021-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="CZu/b0tJKTkNDihw"
Content-Disposition: inline
In-Reply-To: <20220805151325.14021-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] dco: disable DCO if --allow-compress
 yes/asym was specified
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

--CZu/b0tJKTkNDihw
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Aug 05, 2022 at 05:13:25PM +0200, Antonio Quartulli wrote:
>  #if defined(USE_COMP)
> -    if (o->comp.alg !=3D COMP_ALG_UNDEF)
> +    if (o->comp.alg !=3D COMP_ALG_UNDEF
> +        || o->comp.flags & COMP_F_ALLOW_ASYM
> +        || o->comp.flags & COMP_F_ALLOW_COMPRESS)
>      {
> -        msg(msglevel, "Note: Using compression disables data channel off=
load.");
> +        msg(msglevel, "Note: Allowing or using compression disables data=
 channel offload.");

It does have an ACK, and it does what it promises to, but I do not
like the message - as in, it's technically correct, but it could be a
bit more helpful in regards to "what does the user need to do now?"

What about

> +        msg(msglevel, "Note: '--allow-compression' is not set to 'no'.  =
Disabling data channel offload.");

so they know "ah, need to look for that option" (and either set it to "no"
or remove it from the config).

Yes, this is not mentioning "using compression" at all anymore, but this
is indirectly handled - if you have "--allow-compression no", it will
disallow use of "--compress <whatever>" on its own, so we do not need
to mention it in the DCO specific part.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--CZu/b0tJKTkNDihw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi7j99AAoJEB2Cnv7KVigSx4cL/2DN9MVaKS2Jf/+LV/KTPCUQ
RtfYM3dz75zGi4QR/Wvxe9e4fQ/KGrHjUZfjzwnSVBfKmR+YcLcYP7Cyg7GyE1LX
z8cRadxbrEL+HWiAmN8w0arULiFw4FsO8nV9LzKFv88XBTpLoGDFuZCx4D3mdWkO
L9nsFtZ0e+rbMJhvHjBIlQM8EzPsjPF46nOxAyy11q3aIon+HLrooCK3+enf+Sn4
2kbsGGJjsyLUoUZZEGivx8iCd6NBCNyBOYNHo7gNVf6+ReTCdUJlYVG2C0US3OEB
uUlEMaS0MPlle0+gdr9RVGNo80zxAE62otCmkRELYMyk1n+Y+pCy3Ki7JL1zm5s8
21OaB3siSf5AgH9fx8zTgm849Qm4esWnAm9qRH3FHfEhgsmKkkMT4WYrO+s8yveT
9WPRUH2mpJnWFv1JshHnEHya7SMwdS6p+elutVClSrzs+hiZOyEiMfIwAdb3pMpr
yIMoiLmXfyWJLBFjrUUW/R6KqzsjUu6bTSB7/shXVg==
=3iBc
-----END PGP SIGNATURE-----

--CZu/b0tJKTkNDihw--

