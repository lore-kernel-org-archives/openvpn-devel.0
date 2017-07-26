Date: Wed, 26 Jul 2017 16:36:12 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170726143612.GJ70062@...1296...>
References: <334D9817-7B72-4E78-B0CB-BC65EC004037@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="m0XfRaZG5aslkcJX"
Content-Disposition: inline
In-Reply-To: <334D9817-7B72-4E78-B0CB-BC65EC004037@...277...>
Subject: Re: [Openvpn-devel] TAP-adapter iftype question
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Karl Mueller <ewiley@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--m0XfRaZG5aslkcJX
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jul 26, 2017 at 08:50:09AM -0400, Karl Mueller wrote:
> The reason I???m posting this to the Dev list is I???ve no idea what the =
ramifications of changing the iftype, maybe someone???s looked in to this, =
but I haven???t seen any mention on this list about it. It seems reasonable=
 that the change should be relatively minor, but again i???m not aware of a=
ll the corner cases that might rely on the if type being Ethernet for Windo=
ws to work properly.

I have no idea what the effect would be ("will it stop doing ethernet
framing?  no more ARP?"), but it's an interesting idea to try.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--m0XfRaZG5aslkcJX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZeKjbAAoJEB2Cnv7KVigSybML/2QDPb4USjMy5LeQ3E5Q4lJN
PzQq3Wf6cSAS+JrFeHQATwsYBn2Z7NwXd5YqN7KmFEYjVbieZ94QuDF8gH9+5Wh+
oUVdCh8jOTrlCzh2bJl0tY/QY7HiuwvgO7qaxl0UUgwrI3fX9lpnGPNduL9wXVhv
Y96wEJBaF2BH0VN0e/uY5J7HUvCuqR7/tNVFldcU0Vbm6ae7KZh3biCpbG7AzkiL
WhxQQigP+Z5T1fXrPkQkAhWtSAjVmg5RXG9QIhM+gaRcCbomFglowlwOwrr4OQV5
qOSRY8t9u9BBR9U/XqA8kk3ghBRd7/aVsFe09FQJk/oAK9VckDBLfAUmYZ3qRYAM
lqYJMstRRDLtqCYdyMK7LmEYlcSJg6oyBB0rLJC0kU4o1a6P4l6bRA7AnWSosS6T
uCehkm3pG71Ek44S5+15mA+CAx4UnXgDyQ9xJRFHkYnFj5346TYukMjsJV8EE5mQ
LBiJ6BWgRr+pDIJcqIhG1nETsTrVZ1pC+WkojfggVg==
=W6rE
-----END PGP SIGNATURE-----

--m0XfRaZG5aslkcJX--

