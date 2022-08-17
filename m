Date: Wed, 17 Aug 2022 17:31:12 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Yv0JwEtcda9CmV2P@...1296...>
References: <20220514103717.235-1-timo@...2669...>
 <202208111003.27BA3jBP091528@...2054...>
 <YvoXzZNWGa49RJ6D@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="sqvfkL+7tEmhjVuI"
Content-Disposition: inline
In-Reply-To: <YvoXzZNWGa49RJ6D@...1296...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: platform: Retain
 CAP_NET_ADMIN when dropping privileges
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Timo Rothenpieler <timo@...2669...>
Cc: openvpn-devel@lists.sourceforge.net

--sqvfkL+7tEmhjVuI
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Aug 15, 2022 at 11:54:21AM +0200, Gert Doering wrote:
> [..]
> > commit 2e359a088226ab1e5ee41fbab27d38d8a8d192ac
> > Author: Timo Rothenpieler
> > Date:   Sat May 14 12:37:17 2022 +0200
> >=20
> >      platform: Retain CAP_NET_ADMIN when dropping privileges
>=20
> Unfortunately, it seems that our approach to "if SITNL is used, we hard
> require that setting CAP_NET_ADMIN succeeds" is too strong for the twisted
> ways that people use openvpn.
>=20
> Namely, network-manager...
>=20
>   https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1017379

For the sake of the list archives: *this* particular problem has been
solved by=20

commit da31c1654c8534658157cfe9c9de5750ee752608
Author: Timo Rothenpieler <timo@...2669...>
Date:   Wed Aug 17 15:18:17 2022 +0200

    dco: disable DCO if --user specified but unable to retain capabilities


so if we detect "the caller wants us to go to --user $notroot but we do
not have the necessary capabilities to retain CAP_NET_ADMIN, disable DCO".

This is basically the only thing we can do - if we have no CAP_NET_ADMIN,
DCO will be unable to function today.


Next steps are

 - talk to the NM maintainers to get them to call OpenVPN with something
   like "CAP_NET_ADMIN and uid !=3D 0" (and no --user config) - so we can
   just do our thing, without root privs.  David :-)

 - figure out if we can do Linux DCO without CAP_NET_ADMIN, at least=20
   "after startup" (open with privs, get a ticket, continue without privs,
   something mumble mumble).  Antonio :-)

Thanks for all the enlightenment that happened here.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--sqvfkL+7tEmhjVuI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi/QnAAAoJEB2Cnv7KVigSLcgMAKbM6ZWmhv0Oh1eM2MI8Fj+8
Kj01qYMeNTRpsVkVASOTjXaG4kGB5kuIyZZEyA25zteHettNgv6FcdIq48ITbPVR
wc9E6NCacAG//dethXj4OiFoeUV/RdaidbB+Zkx7piTgWjYQ30VGBzVL4QANdkZB
0KoEAXzMdSaxCdSb2fTjA/1V9kCCxR+PD5zETyvaZ4RcliESjjIMKGOADpm6ddHB
n8l0QgzJol0aEfcpvHlM8czYIkgnihLkOFOFul0vg3BJE4elddS+OwOAQsqb6oBX
g896yZSxePhQiXipjj6dEccL9oMGz393BOOiKP66QaFuVGTcpaKidh9fHfrqFJb7
7G2JJnoAR30xvs9qdE6JkCqY9X2kEGlVwLSh6nUria1s89RoXpz7G/qki+jCChh4
yervFvDMUSz4alpoIrlHXH/enpbGl3D/9Es0XU6InSElNBcKdNj+647Yda3NQdlQ
byehz1EV1kBKkiX2EHVPjDdEzSmttyCtJ98bsCmvqg==
=jw9h
-----END PGP SIGNATURE-----

--sqvfkL+7tEmhjVuI--

