References: <1444393757-21376-1-git-send-email-lstipakov@...277...>
	<20151009133950.GN22054@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <5720755F.8020504@...1227...>
Date: Wed, 27 Apr 2016 11:16:31 +0300
MIME-Version: 1.0
In-Reply-To: <20151009133950.GN22054@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="Q8dEicU1LHBeDWU8Mrwq9o0UKs6QSeUMe"
Subject: Re: [Openvpn-devel] [PATCH] Support for disabled peer-id
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Q8dEicU1LHBeDWU8Mrwq9o0UKs6QSeUMe
Content-Type: multipart/mixed; boundary="pBeQJN1UMF8Oex17d1hUgCWWwa6tXuSvp"
From: Arne Schwabe <arne@...1227...>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <5720755F.8020504@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Support for disabled peer-id
References: <1444393757-21376-1-git-send-email-lstipakov@...277...>
	<20151009133950.GN22054@...1296...>
In-Reply-To: <20151009133950.GN22054@...1296...>

--pBeQJN1UMF8Oex17d1hUgCWWwa6tXuSvp
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Am 09.10.15 um 16:39 schrieb Gert Doering:
> Hi,
>=20
> On Fri, Oct 09, 2015 at 03:29:17PM +0300, Lev Stipakov wrote:
>> +	  peer_id_disabled =3D peer_id =3D=3D 0xFFFFFF;
>=20
> The general patch is fine, but while this line is technical correct, I do=
n't
> think we should do so...  please add least add some brackets...
>=20
> 	  peer_id_disabled =3D (peer_id =3D=3D 0xFFFFFF);
>=20
>=20
>> +		      /* TODO: support for disabled peer-id */
>=20
> What is this TODO about?
>=20

I am just going through the patches. Lev, do you plan a follow up for this?

Arne



--pBeQJN1UMF8Oex17d1hUgCWWwa6tXuSvp--

--Q8dEicU1LHBeDWU8Mrwq9o0UKs6QSeUMe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlcgdXEACgkQe8+cMNS4zRdVowCfYgr/DpgbZkkiCpsuMYyqucZ8
DEwAoIo6T3R9edcuE0vads+Nx1hw3OaS
=Fpix
-----END PGP SIGNATURE-----

--Q8dEicU1LHBeDWU8Mrwq9o0UKs6QSeUMe--

