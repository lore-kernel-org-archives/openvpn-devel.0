Date: Mon, 19 Dec 2016 14:55:22 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161219135522.GF78624@...1296...>
References: <CAA1AbxJZL70qY=ivMvskeUapj0V_+z_LVnM2Zp2LxAJT4t62vA@...278...>
	<CAFHpkQEnATPgCyxsLW6bpC5Qr-Cdh=+4X4MRXxgUD+orKpq+EQ@...278...>
	<20161121174953.GM28918@...1296...>
	<CAFHpkQFZD+hYzq_FW075wQt5AopcyCP20BEDzLsTx5Vq6uko3Q@...278...>
	<d48609b7-43df-80d5-a57f-e96e85ad4389@...2080...>
	<CAFHpkQHxVWvHSFK2hS7CV8ytUnxUHi5ZfjSOiuLBfWdufzMrCQ@...278...>
	<9048486e-03d9-7aa1-74f8-892a9cc7c1ee@...515...>
	<CAFHpkQHtPm2gPfHYEngJoMymUxt8iOFA7L0z+p54oVSNEmEPFQ@...278...>
	<4ea0b775-5681-b908-f06d-9251d28e8c8a@...515...>
	<c41ad01c-d1a2-cf2c-4876-c22954ae90a9@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cs2w6Z3FJD+b2LjO"
Content-Disposition: inline
In-Reply-To: <c41ad01c-d1a2-cf2c-4876-c22954ae90a9@...2080...>
Subject: Re: [Openvpn-devel] https://travis-ci.org/OpenVPN/openvpn/builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--cs2w6Z3FJD+b2LjO
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Dec 19, 2016 at 02:44:34PM +0100, David Sommerseth wrote:
> > 2) Ensure that CMake is not installed on MacOS X (does mbedTLS require=
=20
> > this?)
> If mbedTLS is built from source, then I believe CMake is needed.

"generally speaking", mbedTLS builds fine with normal make.

In the context of Travis, I'm not sure what it does.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--cs2w6Z3FJD+b2LjO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYV+bJAAoJEB2Cnv7KVigSLKQMAK2w+/Wx0SVTXeun1W6zAlE8
N+9ChmFBRf+V+t6/WJ4Fa65THb5n/sN98/BJoRtD3omVmVUtI5iTIsRu0H5HX5NG
GlnAhJyi9nHGIpuozw+/ErwezpUeNwEhvlgIrwKDsQQ7G3x7RyTRVTQjDfO1LK1P
BLmdT3HKpbZk1XQThmMBZZCe6dySEFO3tUSaDPbTfd4TPpfSOb1LgrAt1RhOnAAA
yJtoMHKjHQ86N9ECEUnzi1uXuEif51g9HH86iZz0eaHMgkffnhraSMVGE0yARFbM
t930ESpdvph0ocWSzcjn5+5XTD6xAButPTULjwH+oVWjOPpVucYXIZ/2QPiaJ2S0
C+/7fK1CDsSofKRwHE8bk3sYmsr41BCuB5Q1lDNETnKfxk6m4UComk8C1r6c4SaE
s4+zR1C5DcLv3LoAqcGLg8rFCDtlkGr/2p2S5OapS4T4vdUw8ahkDi1EIxID/Y6F
VPMvpUrdYyaFHvMWTbcB0SeMZbpeJzaqBZ/bx8Ikxg==
=5LLc
-----END PGP SIGNATURE-----

--cs2w6Z3FJD+b2LjO--

