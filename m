Date: Tue, 30 Jun 2020 08:34:59 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200630063459.GT1431@...1296...>
References: <20200629230839.24765-1-tincanteksup@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="O2oqnSN/nicY60WJ"
Content-Disposition: inline
In-Reply-To: <20200629230839.24765-1-tincanteksup@...277...>
Subject: Re: [Openvpn-devel] [Patch][New-man] Update --txqueuelen default
 setting (Now OS default)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Richard Bonhomme <tincanteksup@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--O2oqnSN/nicY60WJ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jun 30, 2020 at 12:08:39AM +0100, Richard Bonhomme wrote:
> Signed-off-by: Richard Bonhomme <tincanteksup@...277...>
> ---
>  doc/man-sections/advanced-options.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/doc/man-sections/advanced-options.rst b/doc/man-sections/adv=
anced-options.rst
> index dbf7799c..9b96e406 100644
> --- a/doc/man-sections/advanced-options.rst
> +++ b/doc/man-sections/advanced-options.rst
> @@ -104,4 +104,4 @@ used when debugging or testing out special usage scen=
arios.
>  --txqueuelen n
>    *(Linux only)* Set the TX queue length on the TUN/TAP interface.
> -  Currently defaults to 100.
> +  Currently defaults to operating system default.


Acked-by: gert@...1296...

David, can you please merge into your tree?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--O2oqnSN/nicY60WJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJe+tz6AAoJEB2Cnv7KVigSawQL/3JsS2lnvo2l5CjDUQXllD2X
SJA9YOTCNptb/XnPovg1Mz3GLfzGuTFVy7ZFdZNdYmw45bfK4iw/TzqIpH9SaO7f
IYy9O6oY9ig3ljTSol7mxCKXsicTqj7ZW9CtFiELi6Q+aKeVHMc/rBMDAptaDhQk
i/dv6xvHyuZ0uOr/PFmSGAdO6tNW02EIzv9eG5cGRdUQkv1qswzJkmQN14vPNwU6
AWWBQz2IvM6WBqwu+x8w0xHqeO/N+pBp9rwOuQMncrZr23kSoTK/wNqBSnzsE9A0
irPle26kd38rlYSFkC3K2Itja1dFvNSAkxp+MrbC/PdUefLzgpPnkPE8xIiV5Xbk
jJToKoPybJNBl/eESLFzDQ6adYdiPTu2L7qFkF9FBsjzjLG5B3jibOrhiKcDId5t
qyJ0DY7N9b2SMhEMnlLZXpEHja5AEUtt86o43cdVJmIzULIHgNYMup00HLFh/yjE
ga0aYYOCdHqNwtfwB1elkX44hSFB2oresH9nyBGyrQ==
=k/+x
-----END PGP SIGNATURE-----

--O2oqnSN/nicY60WJ--

