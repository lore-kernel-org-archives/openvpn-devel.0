Date: Wed, 19 Jun 2024 15:45:31 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <ZnLg-79txAYA-jn-@...1296...>
References: <20240618120219.5053-1-gert@...1296...>
 <202406181630.45IGU5vu098122@...2054...>
 <ZnKodXfUYfL5LUlJ@...1296...>
 <d2a5a966414745e2942f0cfa62db3fdc@...2507...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="tkzSmPuUtMCnAGUn"
Content-Disposition: inline
In-Reply-To: <d2a5a966414745e2942f0cfa62db3fdc@...2507...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: mbedtls: Remove support for
 old TLS versions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Maximilian Fillinger <maximilian.fillinger@...2507...>
Cc: Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--tkzSmPuUtMCnAGUn
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jun 19, 2024 at 01:38:46PM +0000, Maximilian Fillinger wrote:
> I *think* I reproduced the problem you're encountering.
>=20
> If I put
>=20
> setenv opt tls-version-min 1.0
>=20
> in the server config, then *every* connection attempt will trigger a fata=
l error in the server. Doesn't matter what TLS versions the client supports.
>=20
> If I put that option into the client config, the client will exit with an=
 error during startup.
>=20
> It's not clear to me what the expected behavior is when tls-version-min i=
s an unsupported version, but if it's an error, it should happen during sta=
rt-up.

I would argue for

 - we log "minimum supported version is 1.2" and go on

or=20

 - we log "minimum supported version is 1.2" and exit

both is acceptable.  It will break people's setups in different ways,
though...  the first will pretend all is well, and older clients can no
longer connect, while the second one will break everything, so making it
more obvious.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--tkzSmPuUtMCnAGUn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJmcuD7AAoJEB2Cnv7KVigS+SgMAJlMrkruJ0HFbdiBBJD2QAYu
uYqEoLokroC9KnLz9v60D9gbT+aDQUAMSnpzD/I6p6DXV31aMpSHoTiqPXFxCRcK
ax/TksY644kBTY1cPlusu8GONXnw6wcecnR9btomY8Kx9qMg0itB4zIorWPVXKb5
zIAr8XN4WauVWtVi1SP7+aOfOtV9NfJBpvFt76TIJWBX22WtdvmnArZVtqwThkH7
4FSBc+FNTsWAP0Uv/WIvSQg/0KuivhvcknSpZaj19N2haDaMJBI+02ib0agPU2lU
IUDS5vIKqeqhR5epgZM/bFWFrBC/jp5bQ4RmrAu30Uy42KEy+chPaUUZr9nGxRGg
DhvOH0OgPyMSmZrIGm/YxnLrdmUGQI3fjmqzGd3m0g29YtJxXGkq2aF5B9Q1ZVgh
j3bjoCQd9i1bSjuY9Qq5f9ZDugyU0hSVdrfDl8fRObBIuq6+amKdWnT+oO9D22w6
Opns+E8TEmweiLZal7onnTGKy7YLtrmiraLFQhdxJw==
=AMpd
-----END PGP SIGNATURE-----

--tkzSmPuUtMCnAGUn--

