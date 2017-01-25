Date: Wed, 25 Jan 2017 15:04:25 +0100
From: Christian Hesse <list@...1798...>
Message-ID: <20170125150425.2a7b880e@...1799...>
In-Reply-To: <20170124232344.7825-1-davids@...515...>
References: <20170124232344.7825-1-davids@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/1AsCco5vXUpWJihJguhQFC4";
	protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] [PATCH] systemd: Move the READY=1 signalling to
 an earlier point
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--Sig_/1AsCco5vXUpWJihJguhQFC4
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

David Sommerseth <davids@...515...> on Wed, 2017/01/25 00:23:
> Currently, OpenVPN will first tell systemd it is ready once the
> log will be appended with "Initialization Sequence Completed".
> This turns out to cause some issues several places.
>=20
> [...]
>=20
> Trac: #827, #801
> Signed-off-by: David Sommerseth <davids@...515...>

I am pretty sure people will complain that units depending on
openvpn-client@...1685... unit can no longer rely on an established connect=
ion.
That said the line of argumentation is still valid and changes to solve this
have been discussed in IRC channel. So for the time being...

ACK.
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/1AsCco5vXUpWJihJguhQFC4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAliIsGkACgkQiUUh18yA
9HYhHAf/SC2IledQzHEofEHe7ZGavNV7i3K1rojYbk7caCOC2KVMlHv1rZBl9Y9h
InCiaYbh7pAkpMZXfIG7ht/kdBjKqnfjBjWZJFHmR9b2EIF3LL8K+2SPwXHwKtOj
9stGF3Q9T0KOShBrvCGK30vIOdzDqbZVhQkwhSt70fqC0zYOp6Gcy/iEnYCfaZdZ
6XWIeks1MAj1zA7b22s1pZhbh6aA7OzNqTVg3nOC2ayBHagQtF9jKml7EZ0d0mIR
s1rwNC6nft4AzFEUci3cssHhzWgZacJkb9X7nqX/gY5TU7JdArcMBN+0gFtKExRo
zO2+Z+5LAPNAOZGmVB5v2rxm+W6bHA==
=sxWa
-----END PGP SIGNATURE-----

--Sig_/1AsCco5vXUpWJihJguhQFC4--

