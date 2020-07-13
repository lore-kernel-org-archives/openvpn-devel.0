Date: Mon, 13 Jul 2020 14:43:51 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200713124351.GZ1431@...1296...>
References: <20200711093655.23686-1-arne@...1227...>
 <2ef4d637-8b73-dd83-5f1b-be4a6b82d8cb@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="wmVCS26nhIVHj/le"
Content-Disposition: inline
In-Reply-To: <2ef4d637-8b73-dd83-5f1b-be4a6b82d8cb@...277...>
Subject: Re: [Openvpn-devel] [PATCH v5 01/14] Allow changing fallback cipher
 from ccd files/client-connect
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: tincanteksup <tincanteksup@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--wmVCS26nhIVHj/le
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jul 13, 2020 at 01:30:11PM +0100, tincanteksup wrote:
> grammar:
>=20
> On 11/07/2020 10:36, Arne Schwabe wrote:
> > This allows to control the fallback cipher that is used when the
> > client/server do have any common cipher on a per client basis.
>=20
> client/server do not have any common cipher

Too late, that patch went in yesterday already.

> (otherwise it looks like you forgot "in what" - That is if my=20
> interpretation is correct)

It's missing the commit ID here, which I added :-) - so the commit
message is a bit more complete.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--wmVCS26nhIVHj/le
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfDFcGAAoJEB2Cnv7KVigSmkcL/RXzmyw0FIfYC1WDZ2Te2REH
RQ1envsQM4qweH2A+MMEkOi8aJBfUziMnBLRZsZ9wrbtCNx0rxchUe2m9o0Y4524
fx+sPOk5iHHGBMQZQF8TgLZeSF9a+TYaAJZrQ0ucd6nb8PQ+4D1qW3U9Ixc7wCu5
AENyPNxpXSiGn2wCokQ2pXv78zbo21iiKF7BQ6ru8NAd2RbovyYbXGx5hDTaByrp
DG9Irk5hBojIPjsubCkMfNN04mFdOOq0R/RUsRVJooYAikXPXzRMvP2ALpos5l0h
s063zWX211aGyo8695fvvFgo9yRZlfj4xxqrFXan9b0bBRJfaGUJIbRBOqSTDYPA
jntHQzYVVtKnbnbCBagcFtpjGDX9nr3x8+vubq1H6uruV7kwdmhtVx25KSbOmkcP
/XlCLXkq55cPzRVFrhcoi1EowKyVcoDrX7C1jpBtYWJ4yYD8eQpnAssJGRkFvtmE
6Y4YUDDrxMvtpegMCy+18eti40dQT4ft9OEoC/la6A==
=LusZ
-----END PGP SIGNATURE-----

--wmVCS26nhIVHj/le--

