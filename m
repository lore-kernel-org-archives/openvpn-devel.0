Date: Fri, 24 Feb 2017 22:49:00 +0100
From: Christian Hesse <list@...1798...>
Message-ID: <20170224224900.52f0a022@...1799...>
In-Reply-To: <20170224131307.45e14633@...1799...>
References: <20170220160816.114598d9@...1799...>
	<cover.1487859361.git.logout@...260...>
	<20170223215707.60e567de@...1799...> <20170224131307.45e14633@...1799...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/YrMbxqT/hQmEvU=UQw26_15";
	protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] [PATCH v3 00/15] Add support for OpenSSL 1.1.x
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Emmanuel Deloget <logout@...260...>
Cc: openvpn-devel@lists.sourceforge.net

--Sig_/YrMbxqT/hQmEvU=UQw26_15
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Christian Hesse <list@...1798...> on Fri, 2017/02/24 13:13:
> Christian Hesse <list@...1798...> on Thu, 2017/02/23 21:57:
> > Built v3 against openssl 1.0.2k without issues, tests succeed and two
> > instanced successfully established vpn connection (with server version
> > 2.3.12 and 2.4.0).=20=20
>=20
> Just tested a server instance with ancient client (version 2.1.4). Works =
as
> well.
>=20
> I will try to restart another server instance later.

Just restarted the server. Here is the current client connect statistic:

      1  2.3.8
      4  2.3.12
      6  2.3.13
      7  2.3.11
     18  2.3.14
     70  2.4.0

So looks good for now. ;)
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/YrMbxqT/hQmEvU=UQw26_15
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAliwqkwACgkQiUUh18yA
9HYGUQf/Q00S6NKnOWDGP1FP0khcni/d+ikqM8MgY47xneQ99/Vhmel+cXQfsDr6
xU/1gn7yd3N4kw6FDPcu8idy6+Ppd2EzYiv2bu2fskZdJWRIJTrhmDnCQADhaVqa
u9+2D2O068T/c0/f0e8w2zTFZ+INgcyTNTrdqL9qw3DHITluS0qNMYJ8Pi7KOo0J
KIBzi6zvZFX3sfAyohFR19ksCY11WBkvqMNG+b5EQg4+r3nuryRW8zXlnrrDJ15N
xmN58Fz6wgCZJBXXx5LTs0fvl6R5Ic/2iFPUOMcwJOytpv8E7ASlBL6DhdhcpCdW
vEpteM1ggaZ2E4g0wv4nb4H0tYPtBw==
=kHpK
-----END PGP SIGNATURE-----

--Sig_/YrMbxqT/hQmEvU=UQw26_15--

