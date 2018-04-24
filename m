Date: Tue, 24 Apr 2018 22:16:36 +0200
From: Christian Hesse <list@...1798...>
Message-ID: <20180424221636.257dd814@...1799...>
In-Reply-To: <a0da03f3-a1bb-6d2b-bdb5-500db52c5dc1@...2181...>
References: <20180423092813.24844-1-list@...1798...>
 <20180424083801.GB24895@...2161...>
 <20180424120337.0fab107d@...1799...>
 <20180424130817.GA20143@...2161...>
 <a0da03f3-a1bb-6d2b-bdb5-500db52c5dc1@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/vdgSo2xN=pC1_4voelDsEe2"; protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] [PATCH 1/1] systemd: run openvpn with dedicated
 user
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Simon Ruderich <simon@...2161...>, OpenVPN Development <openvpn-devel@lists.sourceforge.net>

--Sig_/vdgSo2xN=pC1_4voelDsEe2
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Antonio Quartulli <a@...2181...> on Tue, 2018/04/24 23:08:
> OTOH I understand that there are people that don't care about having a
> working tunnel reconfiguration and are fine with starting openvpn as
> root (and then dropping privileges).
>=20
> For these people, adding the above capabilities results in giving the
> openvpn process more power than before.
>=20
> Maybe users willing to adopt this stricter behaviour should have a knob
> somewhere that will enable the usual
> run-as-root-and-then-drop-priv-with-no-caps?

NAK. :-p

I think the solution for this dilemma is pretty easy: I should strip the pa=
rt
from my patch that disables user switching when started from systemd. We can
start as user "openvpn" any way - as long as the process has capabilities
CAP_SETGID and CAP_SETUID it still can switch user context and drop
privileges.

So users have two options: keep the process running as user "openvpn" with
capabilities for more flexibility or switch to unprivileged user for more
security.

No need to have root involved. Sounds good?
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/vdgSo2xN=pC1_4voelDsEe2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAlrfkKUACgkQiUUh18yA
9HYBKQgAzkEqUuRe8ldXZaNTtQreCZOM2F04Vwq69wMz6GQNppy6V/w/zjfJ6Esq
zO3wfDOdeTkkNCPhBG+cjVjCiwP9CPD7VOR4IF63vnnIcx1cSmiRf+N8CC0KMiqZ
LbZdX29q0IedcpYr05pMBLV86u6bMXseOPnbuVTIEfY9KXdRYCJdjcguDh72UbAj
AvZc/6LSTw4Oy6/0tkNd6iNqq5Wj8/MOihT3C7lU2Qc6GGHQA7JEPszK8RgdeL+d
yGdMK3DBliwWabLrrR8kiZ7lIIkk5JiGiTsVBVPAhZe1DCDUW3bRSLRzKzHx+uJ5
kC8W6+eCN2yj6K5ubm7ZrkqTC9bVQw==
=vGUi
-----END PGP SIGNATURE-----

--Sig_/vdgSo2xN=pC1_4voelDsEe2--

