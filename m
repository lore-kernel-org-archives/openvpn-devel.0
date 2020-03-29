References: <961fb2b3-ca10-1549-3ec8-a408e0072e2f@...515...>
 <CAFdgGSB4qc1KsfQB+67oub+P2J7pMPb6W6d6jZzgZzsB7m_0Og@...278...>
 <20191222183308.GP74723@...1296...>
 <CAFdgGSD5EzgzOqRCDaaBe45qUvqV-NmcKU3ZVmwOdBnw4MUSbg@...278...>
 <20191224083553.GD74723@...1296...>
 <ca5fdf6f-b731-7fed-70d3-90154bc40616@...2542...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <03be009a-553e-abe9-6a0a-8a230e7e956a@...2080...>
Date: Mon, 30 Mar 2020 00:13:17 +0200
MIME-Version: 1.0
In-Reply-To: <ca5fdf6f-b731-7fed-70d3-90154bc40616@...2542...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="BjBiPapBvO5Sz1FjI9KwUaV6PfyMe1OwM"
Subject: Re: [Openvpn-devel] [Openvpn-users] Removing --disable-server
 option from OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Radu Hociung <radu.ovpndev@...2542...>, openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BjBiPapBvO5Sz1FjI9KwUaV6PfyMe1OwM
Content-Type: multipart/mixed; boundary="PdkqbiJK0vyJVACgVHDl3E8xJyOvYBv7t";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Radu Hociung <radu.ovpndev@...2542...>,
 openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net
Message-ID: <03be009a-553e-abe9-6a0a-8a230e7e956a@...2080...>
Subject: Re: [Openvpn-devel] [Openvpn-users] Removing --disable-server option
 from OpenVPN
References: <961fb2b3-ca10-1549-3ec8-a408e0072e2f@...515...>
 <CAFdgGSB4qc1KsfQB+67oub+P2J7pMPb6W6d6jZzgZzsB7m_0Og@...278...>
 <20191222183308.GP74723@...1296...>
 <CAFdgGSD5EzgzOqRCDaaBe45qUvqV-NmcKU3ZVmwOdBnw4MUSbg@...278...>
 <20191224083553.GD74723@...1296...>
 <ca5fdf6f-b731-7fed-70d3-90154bc40616@...2542...>
In-Reply-To: <ca5fdf6f-b731-7fed-70d3-90154bc40616@...2542...>

--PdkqbiJK0vyJVACgVHDl3E8xJyOvYBv7t
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 28/02/2020 20:18, Radu Hociung wrote:
> I would recommend that rather than removing the useful bit of
> documentation that is P2MP_SERVER, the developers consider:
>=20
> 1. Restructure the source tree to split the src/openvpn code into
>    src/{common,client,server}
>=20
> 2. Remove the configure --disable-server option, but add Makefile rules
>    to build separate client, server and combined binaries, while
>    also enabling distro maintainers to package openvpn-server and
>    openvpn-client separately, from the same tarball. The combined
>    binary can be used to build drop-in replacement packages.
>=20
> 3. Improve the test suite to verify the inter-operability of the
>    3 binaries.
>=20
> 4. Separate the manpage into a server and a client edition.

I've not had the capacity to go through your detailed mail too closely.  Bu=
t I
consider these 4 points to be a reasonable TL;DR version.

Yes, this all sounds lovely.  But I wonder who will have time to work on su=
ch
work?  This work will require quite some efforts to avoid duplicating too m=
uch
of what already exists in options.c and openvpn.c; which would be the start=
ing
point for such a task.

In addition, such a change has a big possibility to break a lot of existing
configurations via package upgrades - as in this case the unified openvpn w=
ill
no longer exists but be split into two different binaries.

To be honest, I think it makes more sense to put efforts into the OpenVPN 3
code base, which already is ready for such a split.  On top of getting such=
 a
split in place, you would get a higher performance as the OpenVPN 3 code is
more efficient than OpenVPN 2.x.  But OpenVPN 3 does not support all the use
cases OpenVPN 2.x does.

I hate to be so pessimistic, but I doubt any of the current core OpeVPN
community developers will have capacity to get such a job done in the near
future.  We already struggle to get the current open patches for review
processed, in addition to get OpenVPN 2.5 ready.  More people helping out
reviewing patches thoroughly would certainly help us move forward.

Btw, in regards to the man page.  On my plate, in time for the 2.5 release,=
 I
will redo the formatting of the man page from ?roff format to some .rst fil=
es
(and parse that to ?roff format during packaging).  This is just the first
step to get the man page in an easier editable format than what it is today.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--PdkqbiJK0vyJVACgVHDl3E8xJyOvYBv7t--

--BjBiPapBvO5Sz1FjI9KwUaV6PfyMe1OwM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJegR19AAoJEIbPlEyWcf3yIGgQAK0JFJ1arrLFprG9W+bqBi4z
PRnXGDVuhoKpn8zWWidUwDN0HsuXg2Jn3pnC73mzd0QehceJAHtFn2RIny4SK8JI
zKDpaDN8gMjqUkxD8qhuAHqc6tbpURIhhmFjz/kM2PcTUHSodw+Qyuh/k9a/KT5W
c4bhjIdbH8dO8USTQFuUjCvnw1G8tD6lSwWWfdECjLz9xQpVKMnxyNt213PZZjFx
QU2nHznKmRJVS/Pnq4jr3ob552QsuItMxtAYy1/6s4NJk7Gumn8at9y1mA1by2nz
C9wESVlE3LRfo9zqVKMvCPpzYZpO+C2LHJQB1wyvhUFMKDGRc2eLVozds633V/3T
b3vra9K1y7ZiwNDPa60m8i4Jk0bPzpoFsQriimcGxEqgqEr+xo17W2CL3FLvLb2D
8ZGcrlrmIvq9Sur603D5J1ZuARyi4E9sJCtz+Gu3BAYiMQpgiFpIxueAkL/oBc0B
tE5Wv6Nq4Pun0Imd/8vWzNgCmQypgmPxJCzwn/4jP7xVL0SNZo6pMaQdMhcVQx2B
rdVMTaMZ+zfwfK35s0iRFJxdY4E2yb4VkbXP2gevyaJD6VgHsfI/mHsPwkTXFe3K
f0O0Dueg/Cyi96W0TEi7DvVd7p/SjpYC+aJBIinR9EwuD/DlU5Me2mJHU9IEOpTA
lzUlLTEaRFhuQ23qVgiQ
=jB9t
-----END PGP SIGNATURE-----

--BjBiPapBvO5Sz1FjI9KwUaV6PfyMe1OwM--

