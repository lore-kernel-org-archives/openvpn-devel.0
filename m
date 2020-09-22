Date: Tue, 22 Sep 2020 17:34:28 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200922153428.GA976@...1296...>
References: <b1352a58-c9a1-ab2d-f85d-c419c8887ef0@...515...>
 <1759346.tdWV9SEqCh@...2258...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="6Mt39TZj+HFMr11E"
Content-Disposition: inline
In-Reply-To: <1759346.tdWV9SEqCh@...2258...>
Subject: Re: [Openvpn-devel] OpenVPN 2.5-rc1 released unable to redirect
 IPv4 default gateway under Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Thomas =?iso-8859-1?Q?Sch=E4fer?= <tschaefer@...75...>
Cc: openvpn-devel@lists.sourceforge.net

--6Mt39TZj+HFMr11E
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Sep 22, 2020 at 04:21:49PM +0200, Thomas Sch=E4fer wrote:
> Am Dienstag, 22. September 2020, 11:10:44 CEST schrieb Samuli Sepp=E4nen:
> > The OpenVPN community project team is proud to release OpenVPN
> > 2.5-rc1. Source code and Windows installers can be downloaded from our
> > download page:
>=20
> I get=20
> Note: unable to redirect IPv4 default gateway -- Cannot read current defa=
ult gateway from system

Just to be sure: did this work in 2.4.x?  Or did this never work?

Did you try "redirect-gateway ipv6" or "redirect-gateway def1 ipv6"?

> Environment:
>=20
> Windows client: IPv6-only Wifi

"redirect-gateway" for IPv4 has two (at least) modes

 - default mode:=20
     find out where the current default route points to
     remove that route
     install a /32 route (if IPv4) for the VPN server to the old gateway
     install a new route 0.0.0.0/0 -> tap interface

 - "def1" mode
     find out where the current default route points to
     *keep* that route
     install a /32 route (if IPv4) for the VPN server to the old gateway
     install two new /1 routes 0.0.0.0/1 + 128.0.0.0/1 -> tap interface


Not sure how stupid our assumptions are here, but possibly "if finding
out the current default route" fails, it might be that we do not proceed
further at all...

As a workaround,

  route 0.0.0.0 128.0.0.0
  route 128.0.0.0 128.0.0.0

should do the same thing as "redirect-gateway def1" but without the
current gateway check (=3D will only work if you connect over IPv6).


Thanks for the test results anyway, this is a bug and needs to be fixed
- it probably is not a *new* bug, and might not be fixed in 2.5.0, but
it will be.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--6Mt39TZj+HFMr11E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfahmEAAoJEB2Cnv7KVigSOsIL/24q54q+9WRXm6DNPoCoP3nt
QVER/XHWpTf4F7mmZdt7L134NExk16L7gGnnJiSItK65psLyNy6eMBXrBI8D4rFd
URxSli7wrYW946hMabmP0mQqr8gXiOnCEqYgv2dYVC0AYH8mhD48FhAQEojIxhEZ
APxKLKIV2pTIAGifjGBG4kKPcIDfCoqLo0HUl0Axi6xa3Qa4UyjKGsduV3cNaHyC
XnUBz8j1EmtyGCZdmO4D/rtKuujd7sLqfqvrk4854gjDHRpr9q+i/ZASUmn6n1+8
uDNj51LIOCyDVa1k3z+AGOO3NoP6mm8cREl/6lsxYIUyWMItn9NjuDTOyD6r+Qt9
AUninARjISN6hsWmkLI/kYa40w/H/2TyU1tN0/ITEG+3eyJEEZ8PSx+3tDgBGbl/
p5dWHci/1oK2J/hTLJ/lwWlcR/o7MuwD9afscSqBvpU61pmBTwqNrtoB05JdGJil
ftwpzks8kw9JegLr7N8o4rg5/tzfQIn+i1Y2Lt2Pgg==
=p8t3
-----END PGP SIGNATURE-----

--6Mt39TZj+HFMr11E--

