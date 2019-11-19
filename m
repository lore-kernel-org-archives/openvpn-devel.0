Date: Tue, 19 Nov 2019 08:37:19 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20191119073719.GK40538@...1296...>
References: <CAGyAFMWXS9F3OzSchqGtizgBoj+7E5JTEnKrnCQqMiejTuHs4g@...278...>
 <1573234655-905-1-git-send-email-lstipakov@...277...>
 <CAKuzo_iQD0ehZHisNQyTN1LtcwEogAgdTOBouPrbBb5OPyg8uA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="nzRVTedY3Q7hsbEF"
Content-Disposition: inline
In-Reply-To: <CAKuzo_iQD0ehZHisNQyTN1LtcwEogAgdTOBouPrbBb5OPyg8uA@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3] wintun: add --windows-driver config
 option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Lev Stipakov <lstipakov@...277...>, Lev Stipakov <lev@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--nzRVTedY3Q7hsbEF
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Nov 18, 2019 at 11:17:33PM -0500, Selva Nair wrote:
> Looks like this will most likely break any dhcp-related options
> in the client config.. Say "dhcp-option DNS xxx". We currently require
> ip_win32_type to be  adaptive or dynamic when such options are specified.
> I think we should set this to adaptive here, and then handle it in tun.c
>=20
> Although there is no dhcp when wintun is used, we'll still support
> dhcp-options such as DNS etc using netsh or service, right?

I had the same concerns, and if I remember right (I haven't looked just now)
one of the later patches adds the missing bits to the iservice.

So we'd accept the DHCP options, pass them on, and iservice would IPAPI
them in.

I'll have another look...

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--nzRVTedY3Q7hsbEF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJd05uuAAoJEB2Cnv7KVigSKwcMAIFcm4Qy1HW2QazAh6dH65r0
hVyzmG7MOeLDAc0iW2HSSb4dZVCmOLAlf9lh/PNs1n+VPy0jb0jhQXRtVIHItbWy
YbL88nDmFDOMx1+nDt6bKJ2k8CllnraydRBi+t/S/hBtX2kJMd3hn3lg7MaI4Fgo
2VFMSbrSaAX2gkEzEi8xEsHX1eev9xW+4HRK9FIBf8I7XJxRqlrjhNQ0IAhhGgq5
PaP6j/foCcCWhCAQ8iCfJe6dUZmxK1qa2AKniBYZHet2B/9mwioUsttvhKig3Cmq
hxKjfjBD3FasoknJSk4hp6oRtGztDO7XNGrjwCj0ui1v0DnU32Y6qlXqbWNYGkEY
OBy8ReJn/8cgWTDgWtu+QMZAINKFzIDuMbnuBh49Y4Hvvesy9e9KnqWguIVZNO4c
6raXeF9OUJIxA/75R1fA4EYDLQBVxGDpka555QCTRjuKtQdJO1QBkbX+80wkwyRZ
3F5u/vymGkZlWlO5SzvtTfX4l70BY2P8ewf4jn2lfw==
=MbF3
-----END PGP SIGNATURE-----

--nzRVTedY3Q7hsbEF--

