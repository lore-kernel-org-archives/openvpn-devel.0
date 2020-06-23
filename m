Date: Tue, 23 Jun 2020 11:02:52 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200623090252.GE1431@...1296...>
References: <20200622113022.23047-1-davids@...515...>
 <CAKuzo_g7QxVL90ikT57H6b4+St2c860us6S3cN_6jbfeHujpzw@...278...>
 <a1cfd42d-e371-187a-55c2-f14a3a986b34@...1823...>
 <4562876f-45c1-d3bb-f725-52e9b78600de@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="2TsvvDHlsYpYdLuL"
Content-Disposition: inline
In-Reply-To: <4562876f-45c1-d3bb-f725-52e9b78600de@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] systemd: Change the default cipher to
 AES-256-GCM for server configs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Dmitry Melekhov <dm@...1823...>, openvpn-devel@lists.sourceforge.net

--2TsvvDHlsYpYdLuL
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jun 23, 2020 at 10:34:47AM +0200, Arne Schwabe wrote:
> > Well, may be it is possible to add support for setting cipher in ccd
> >=20
> > as it was possible before 2.4.9 using patch from here
> >=20
> > https://community.openvpn.net/openvpn/ticket/845
> >
>=20
> I get that this might have been needed in 2.4.x with the first version
> of NCP. But the NCP negoiation in 2.5.x should handle all use cases.
>=20
> Help me understand why --cipher in ccd should be needed?

Non-negotiated (because dumb clients) per-client cipher - e.g. for=20
migration.

That patch is from Steffan, and review has been sitting in my lap for
way too long.  Need to see if it still applies.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--2TsvvDHlsYpYdLuL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJe8cU7AAoJEB2Cnv7KVigSOnUL/iDVKq847EfOOpBvqfHhWiai
f4ybgqByj3GrlVuQwxOKTx4Pb7HAUqqCchiac2cdArJ/qKdZKS6iMehFb6x3RsIW
SIui3Dmme5LiVF4IZdohHuGiu07ktqYE80tEDcewV+aNz9mJglCb5SkZlGHRlP9Z
KPcqIdodmFM1N0gCC+Qai+Z8LsvTWi3K2TcY0/3TVgso3i0Pz4G28HOdcNGxcatb
FWuJAYxiRJrm+KgFBvsTtnZleQmxLpLXXO5KxvEc4cgZVT1ArQyO9Tfo6ePQGAYM
JYywwielDPx18P9ZJqxZn6fy/wCgImfh8ottzTaArv9p2ny6sholVzKM116ZGpfY
+CagXzNlXxpngaGWgx7IBxqIy7lRLP2JmiKj27pBFyE1LgYWv2RGd3iMkdwfvz5J
dXx3oJHK4v/jN6T2OyWWckWrR8XyoYnoDn2fLuybdyuXqSocwsQNMoFSjBUaCpHc
+V6vl9VfEMi2aeud/l1ZwxjxWRNnXoN/WWwsYsiCng==
=FXVe
-----END PGP SIGNATURE-----

--2TsvvDHlsYpYdLuL--

