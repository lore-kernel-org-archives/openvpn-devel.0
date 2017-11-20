Date: Mon, 20 Nov 2017 09:06:04 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20171120080604.GX958@...1296...>
References: <20171112163636.17434-1-steffan@...1856...>
 <201711192037.vAJKbuHH080370@...2054...>
 <20171119213837.GA80839@...1296...>
 <8760a6kjwc.fsf@...2274...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="2eMsdCYyWAhZPdeO"
Content-Disposition: inline
In-Reply-To: <8760a6kjwc.fsf@...2274...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Add --tls-cert-profile
 option for mbedtls builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net

--2eMsdCYyWAhZPdeO
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Nov 19, 2017 at 11:01:39PM +0100, Jeremie Courreges-Anglas wrote:
> > (Not sure, though, why it only complains about two out of three, but
> > still annoyance...  if LibreSSL claims OPENSSL_VERSION_NUMBER >=3D 0x10=
100000
> > it better should provide everything needed)
>=20
> LibreSSL defines:
>=20
>   #define OPENSSL_VERSION_NUMBER        0x20000000L
>=20
> breaking #ifdef checks based on it.=20=20

Indeed.  I find this a curious and not useful setting - "if it's not=20
compatible with OPENSSL, why define such a version number"?  But that's
slightly out of scope here...

> Sadly, people tend to prefer adding
>=20
>   && !defined(LIBRESSL_VERSION_NUMBER)
>=20
> to fix the build, rather than doing features detection using autoconf or
> similar.  openvpn can easily solve this.

... and I'm thankful for your patch, because this is exactly what I=20
considered doing here.  We already check for all the 1.0/1.1 openssl
differences (accessor functions), so adding this one is logical.

> > This is on OpenBSD 6.0, which happens to be something Samuli's vagrant
> > setup can provide nicely if anyone wants to have a look :-)
>=20
> Here's a diff, master builds and seems to run fine as a client on
> OpenBSD-current.

Thanks.  Patch looks good to me, but I leave the final word to Steffan
(maybe he wants to amend the non-support message to include LibreSSL,
or whatever)

> I can cook a similar diff for the remaining OPENSSL /
> LIBRESSL_VERSION_NUMBER #ifdef.

This would be appreciated.

gert
--=20
now what should I write here...

Gert Doering - Munich, Germany                             gert@...1296...

--2eMsdCYyWAhZPdeO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJaEozrAAoJEB2Cnv7KVigSTbUL/3PhzhVOc35PU/ns/mDIOWmC
ph0cxEK68kV2sjGLYDkbF2Q38XH3DHn1+7SG0SZcJBvD+l1MzylhhaKALs58rJG/
SOl3D4GvprKqKVNrj0tmyNcPuCJ73V6IVI+2MLpZ/X4NM0ErajbEvtec5fch/7MG
jF0XSTQFpR9QWR9xzZSvLDPkGbKGNndaHBrhx+MGryH9t9j6GyRRRRFlWbHwFFYC
ydM332IJIPlMUAjwMovBYdO31ttmQjDluoItpzycp6L+kJlOh89RLxLZTd8SRxKi
RadAScOv1Rogf5ggzzM09GUR80IaH6WIiOvE97P+4+5cQCTFebPLrI/j5HnQ6xwL
5+Zap++x0RScGl1ZtdcvSNFBT3L0mqoxgAssSrTpVILaeEpX5lmC5s4cnxRu+c1f
146ZaSmYCWQn21NVHY/sdfPJu7kOSdiUoEk3DNcP/+eP1KpbSKqaQ8lFbYIk/5Yi
gx+QsZAh60MeRAoAomE0z0JtBzNvTn2ci2gC81BNxQ==
=a6LR
-----END PGP SIGNATURE-----

--2eMsdCYyWAhZPdeO--

