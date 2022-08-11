Date: Thu, 11 Aug 2022 22:58:14 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YvVtZnwurH7sepM/@greenie.muc.de>
References: <20220624083809.23487-1-a@...2181...>
 <20220624083809.23487-21-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="gRAh38WcwqZ/PJ/1"
Content-Disposition: inline
In-Reply-To: <20220624083809.23487-21-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 20/25] dco-win: add platform dependant
 check on incompatible options
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

--gRAh38WcwqZ/PJ/1
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jun 24, 2022 at 10:38:04AM +0200, Antonio Quartulli wrote:
> Some platforms may have different constraints in terms of incompatible
> opions, therefore we add a function that explicitly checks those.
>=20
> Also, add generic option check for when ovpn-dco-win is in use.

Looking more closely at this, this patch needs a carefuly rebase :-)

> --- a/src/openvpn/dco.c
> +++ b/src/openvpn/dco.c
> @@ -190,6 +190,26 @@ dco_update_keys(dco_context_t *dco, struct tls_multi=
 *multi)
>      }
>  }
>=20=20
> +static bool
> +dco_check_option_conflict_platform(int msglevel, const struct options *o)
> +{
> +#if defined(_WIN32)
> +    if (o->mode =3D=3D MODE_SERVER)
> +    {

... it *introduces* dco_check_option_conflict_platform() with "only
windows" content, but in the current master tree, this function already
exists, with Linux content...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--gRAh38WcwqZ/PJ/1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi9W1mAAoJEB2Cnv7KVigStEwL/3OAgq42VcPiYOvVdnarhUY4
h0ng1XNcXntFAlOeGNdhn6VFRiMq7s71qzCNamIRxSYF35UhakfzehMKgaRGC5CC
fUWBDgwyRKVFIC85vgIdD1vVYJLgtWxn2h8mmG76yJ6RY3R/zowcepRwMVnIVNBY
ZjsFTIZsHMZvfNQPB4E7OCqBRf9OqRPT7LP4F1D0M2/2+aUredVDH/cUezQhj4sW
oBNZxEHqHEnsmdDLt3/IvQ/2DX5UArnzYRelrdUDlK/kGpZt8OlYxdYLpkuoVpVb
umnC6uD/JzsEVwL1mTLHgcJ8HMAWZwYKcqCq+RrIbStQWL43jZ3Rjs0cvMXLcMUD
TXgGx65rJA3tqtwuLbjubaQpLMjhKw1AwkwI0JuOFi3DpepOjVLNocgYC/0g7PWZ
31aGBcwT3qoURVuhi3D0EvVo+TOd2CBCw44TKYV3i6bVnbo8wxeSLtTu/kVsnGW7
4BqUIrpKoD0fMMpcFAvBIuEF0kllvSszEQQA5M3zxw==
=OcSe
-----END PGP SIGNATURE-----

--gRAh38WcwqZ/PJ/1--

