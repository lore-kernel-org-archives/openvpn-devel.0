Date: Tue, 15 Mar 2022 18:13:43 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YjDJR+xDcuV7QBIW@...1296...>
References: <20220315155344.37787-1-openvpn@...2080...>
 <20220315155344.37787-2-openvpn@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="1OHEu+7vhnw9TjQc"
Content-Disposition: inline
In-Reply-To: <20220315155344.37787-2-openvpn@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2.4 v5 1/3] sample-plugin: New plugin
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

--1OHEu+7vhnw9TjQc
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Mar 15, 2022 at 04:53:42PM +0100, David Sommerseth wrote:
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

We've discussed this on IRC, and decided to not invest further work
into 2.4 for this - the 2.5 plugin will work, but "fiddling with the
build stuff" is left as an excercise for the reader, as we consider
2.4 to be effectively "out of maintenance, only critical bugfixes".

Thus, formal NAK on this.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--1OHEu+7vhnw9TjQc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJiMMlHAAoJEB2Cnv7KVigSaGEL/0N8vfwYynqAqHXUNjxTsIeD
uc9XAegQGI0Us/lpgKfrXIuJhiYI8CsYQJQsiHXm7Q40ZZsjVoLOAeAQG2wLqj3K
ony2j+8ETaHowx5gI+seCjYwDXR8MnyCVBqMS8jPQ2TU8QjKtClCKjjOWAN9X7mG
l7H6aUFOM3vTOgPDD+Bv66EWYix0mrngGpDEDiIrWG35UhOFsKg+2Vw07mpYTmbq
ODDk5+OUP5Y170Wod6UyLde5m2JdPg540icMBzYvd99U2BpdWod11WIOSHVZqYMk
pEkLXATgEN6HonKlr+Fc9c7Ay9o9LyWdVANnpyfjX+ovshVxVi99zB14wyv+eM6b
/NQpoHvTS1AN+nbPRlXULZ6elakjqtbUiOmrWSx6ZobEiDmmCIsmzLGdJIEKZ8i5
uCzyu+J1q3V6ZHiaudpt0C0ef48XFDziqb2HliRSza+knpDOlAdtpVHPnMx3fM4s
cTI3dJrZD36Q/A6nhwxbSDonyvAqUAx6FYLxzle8CA==
=9lnj
-----END PGP SIGNATURE-----

--1OHEu+7vhnw9TjQc--

