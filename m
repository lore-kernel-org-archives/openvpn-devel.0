Date: Tue, 3 Jan 2017 21:57:09 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20170103205709.GU78624@...1296...>
References: <1483152307-15687-1-git-send-email-selva.nair@...277...>
	<20170103171747.GR78624@...1296...>
	<CAKuzo_jHka7eDtb4We0SvLX9kTN3x=1ae917NZHkweWpij94sA@...278...>
	<CAKuzo_hnrsHcJoUKsKcKR6ZfYXsJPrww0=aDbem5_m+ukiJAug@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Sao9idefCFjK9Dt3"
Content-Disposition: inline
In-Reply-To: <CAKuzo_hnrsHcJoUKsKcKR6ZfYXsJPrww0=aDbem5_m+ukiJAug@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Always release dhcp address in
 close_tun()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--Sao9idefCFjK9Dt3
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jan 03, 2017 at 02:36:47PM -0500, Selva Nair wrote:
> > Agreed. Will send a v2 later today.
>=20
> There is one corner case that I realized only now: what
> happens when a real dhcp server is in use (say in bridge mode).
> Current dhcp_release() function is a no-op unless the
> masquerading dhcp server in the tap driver is active (it checks
> ltt->options.ip_win32_type =3D=3D IPW32_SET_DHCP_MASQ)

I'd leave it at that, at least for the time being.

I'm sure bridge mode with a remote DHCP server has even more interesting
caveats... (there is a trac ticket somewhere that claims OpenVPN eats
*some* DHCP options in this scenario...)

gert


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Sao9idefCFjK9Dt3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYbBAlAAoJEB2Cnv7KVigSP4AL/0O19CpaqVrVhkHcNTBX4y0t
727KXSafS7LS8HjbzvD1UbKUF4ciZLHfabwu6P5r6p6wS03DwzUxYZzoRvAbOmhc
OE0Fxnn31wsdAlpnW9xm8Jd/jRz9vDQy8R0Un6OmbqJsDGk+Ih3OzG2K++apfW9Z
mrkX4q+caL7WpHqsgy/hlpzcVnzoXI0kWblsFEGNMbtEX5V5Rbcx/VY44HaZOirq
e1b3BHZWyYfk7dUFclyiUJ9B3Uidj6JsbNPPHXgQzpxmba+IU5XbyRbCVzAtLEZc
ZBc8OASNnDjOmcTeOSnkIkQ8nVe0n9Wj2u4X+pDaMjFEHI7M8wCwPElptRzE7Z8H
9pzMtsrqkYudBb3ob1rwKk+09bH/MLVWpTR31klopP4KppQ9eNELp707SNyD6rWM
SbvnKE5NYCGgisNQkISzISr3U1ZdpJP7LAZQwV5F5FtEYhzgngh07b2gaMxTOlL/
QaI/Hgy/i14RWe+JMHk19MP/yAdkj5qLkk863Th/cg==
=wscC
-----END PGP SIGNATURE-----

--Sao9idefCFjK9Dt3--

