Date: Tue, 15 Mar 2022 16:17:42 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YjCuFlaRZhVnE+wA@...1296...>
References: <20220313200715.13518-1-openvpn@...2080...>
 <20220313200715.13518-2-openvpn@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ojECex7r5fqOgE3E"
Content-Disposition: inline
In-Reply-To: <20220313200715.13518-2-openvpn@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2.4 v4 1/3] sample-plugin: New plugin
 for testing multiple auth plugins
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>
Cc: openvpn-devel@lists.sourceforge.net

--ojECex7r5fqOgE3E
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Mar 13, 2022 at 09:07:13PM +0100, David Sommerseth wrote:
> From: David Sommerseth <davids@...515...>
>=20
> This plugin allows setting username/passwords as well as configure
> deferred authentication behaviour as part of the runtime initialization.
>=20
> With this plug-in it is easier to test various scenarios where multiple
> authentication plug-ins are active on the server side.
>=20
> A test documentation was also added to describe various test cases and
> the expected results.
>=20
> Signed-off-by: David Sommerseth <davids@...515...>

Well, not sure if we really want this new plugin in 2.4, but if we
want this, we need a v5 of this patch with correct build instructions
for 2.4 - as it is, it does not build (there is no Makefile in=20
"sample/sample-plugins", and "build" does not set proper -I, so=20
"config.h" cannot be found).

Thus, NAK.

Focusing on "only the CVE patch" for now.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--ojECex7r5fqOgE3E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJiMK4WAAoJEB2Cnv7KVigSwHwL/iXygYFmp33qhVoTJtao4M5o
jDStFVAzLHeflxDxwEEXTxctKAqShSw83e1gEnXhcRCpcvAzdlQ2z5O2nMcheSou
opiZPg03o8UTFTi6HjRDMJi02dY64b49xoChS+ivxHCZHgHqgryH7MGNYwOD52Mw
PV7QV9f/XbwBcVVjUehaJepSNSMVJsQ+l9lVVGikO39RpLkmj8VGdAmwQUcuDTqQ
1OIztqDRqLZD0dCZjeVeRe/BNxKMuNPDV+IDeMJfIY1+biZO+GLAYOjJS3hmnlik
+00eRBuUUVOgqZWlbnmt6jmxQwdxbfzni84SHjGHjEZzBfx5OFeufGunaWYG9zr9
Y1/z6ggFO8RZbyqm0erd0wcywJGwsFpgrPDmHSFJGlze+aKp8upYnwvSYPmJf8QD
oG5U85YdXDXmfS0wGNZoYAhw9+2YUEQVpi1HeB/BDgXTLViEwFL0BXc19sVnGodv
WIAe+qvYeRQ7FYgtiofBmVhRk3r8OIZUiqeKvWzTgg==
=a452
-----END PGP SIGNATURE-----

--ojECex7r5fqOgE3E--

