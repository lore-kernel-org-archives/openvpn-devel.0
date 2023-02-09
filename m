Date: Thu, 9 Feb 2023 20:38:07 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y+VLn5pTX3a3y08t@...1296...>
References: <20230209153658.24001-1-ynezz@...2710...>
 <b187a379-2bc1-6a7b-9bb6-a53fb1358c4f@...2712...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="dXdhaYAYunb5wKl9"
Content-Disposition: inline
In-Reply-To: <b187a379-2bc1-6a7b-9bb6-a53fb1358c4f@...2712...>
Subject: Re: [Openvpn-devel] [PATCH] get_addr_generic: fix server crash in
 freeaddrinfo on musl libc
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Mykhailo Mishchenko <mdmisch@...2712...>
Cc: openvpn-devel@lists.sourceforge.net

--dXdhaYAYunb5wKl9
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Feb 09, 2023 at 07:40:06PM +0200, Mykhailo Mishchenko wrote:
> On 09.02.23 17:36, Petr ??tetiar wrote:
> > Server can crash on systems using musl libc when client with comma in
> > commonName tries to connect:
> >
> >   ifconfig_pool_read(), in=3D'VPN Client, abc,192.168.1.2,'
> >   RESOLVE: Cannot parse IP address:  abc: (Name does not resolve)
>=20
> I also would like to empathize what exactly leads to the crash. It=20
> clearly tried to parse a part of client certificate's Common Name as an=20
> IP address. As I understand it, this IP address was supposed to be used=20
> to restore client's previous IP address. This is another bug, different=20
> from trying to "free" NULL pointer.

CNs with commas in them are a long-standing issue, because OpenVPN
doesn't know how to deal with them.  So, don't do that.

(There is an old Trac ticket about it, but nobody went out and fixed
the code yet - which is tricky, as you can't just change the format
of ifconfig-pool-persist without breaking existing setups)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--dXdhaYAYunb5wKl9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJj5UufAAoJEB2Cnv7KVigSRTwL/0uttX9umA36KktWC2NzJph8
ZNwnjovDOBg7APNy6Ud5ew61OxDqmcBYUvztdUTGZ/b+Vx7AoIgo3KNtr2WDHdeb
LFWBdJ6fWK5EFmt6N2daiWOTl1DxZ4dTFB4gP0GB9rYhXxkEnZkYS0bija/Bx2EZ
qbJDAxuZHoXQ36/PBGchsPnoRBKIzUL8lxZQHjbYMLCIncFP8148ySnL0e8uUst9
J2tjba5vkt1kepKGJT/husUJT57Te7RZ0wzrgtVrOyYa8hh6lyU/dkTLLjhBlGDo
knjo3/NOicGJMenjqO28wOOCGebkgbFXOFMKhWtkb4CjpwXEtGfKOzR+lINVyxh/
40ITWLJIsAkGUKQEggYNLNm4USChRaHufqwPX7Lih53vMOc+PpLbZsVivpu9EQt5
g3VsDzRZw9agiPVsVEVBCzv5BCWZd/N2tXoXSHbabRl1F5R8XCTQt6EpkLvk5COA
IY8Hle/TA5HV6ztsGB2Yc0eowqQORAqjskIh8zaGCg==
=Zv8h
-----END PGP SIGNATURE-----

--dXdhaYAYunb5wKl9--

