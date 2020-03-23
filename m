References: <b7699035-f70a-6df4-c2a2-082d7f3433cf@...2080...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <fbf8cb1d-5dee-fd15-389d-8338b371a4dc@...515...>
Date: Mon, 23 Mar 2020 11:10:58 +0200
MIME-Version: 1.0
In-Reply-To: <b7699035-f70a-6df4-c2a2-082d7f3433cf@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZkHOFkNnHNeljunej2yVqS5ChDmlx9Lf9"
Subject: Re: [Openvpn-devel] OpenVPN git master builds for Fedora/RHEL/CentOS
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZkHOFkNnHNeljunej2yVqS5ChDmlx9Lf9
Content-Type: multipart/mixed; boundary="vQ5sWmlvNhZ1kTjsE1eORja8o9J5tC0Pg"

--vQ5sWmlvNhZ1kTjsE1eORja8o9J5tC0Pg
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Il 22/03/20 16:38, David Sommerseth ha scritto:
>=20
> Hi,
>=20
> I've put together a Fedora Copr repository which contains builds of the
> OpenVPN 2.x git master; which will contains what will arrive in the next =
major
> release.
>=20
> <https://copr.fedorainfracloud.org/coprs/dsommers/openvpn-git/>
>=20
> Instructions are pretty simple when using yum copr.  If you are on
> RHEL/CentOS/Scientific Linux, ensure you have the 'yum-plugin-copr' packa=
ge
> installed first.
>=20
> Then you can just do:
>=20
>     # yum copr enable dsommers/openvpn-git
>     # yum clean all
>=20
> If the copr plugin is not available, see the URL above for direct access =
to
> the repository files.
>=20
> If you already have openvpn installed:
>=20
> 	# yum update openvpn
>=20
> Or replace 'update' with 'install' if this is a fresh openvpn install.
>=20
> I will on some semi-regular intervals update these builds when I see git
> master has been updated.   If you have any issues, you can easily downgra=
de to
> the previous version by doing 'yum downgrade openvpn'.
>=20
> If you have automated updates enabled on your system, you might want to
> consider to blacklist the openvpn package - as the openvpn git master mig=
ht
> not be as stable yet as the released versions.
>=20

Excellent work! I will enable this on my laptop.

Samuli


--vQ5sWmlvNhZ1kTjsE1eORja8o9J5tC0Pg--

--ZkHOFkNnHNeljunej2yVqS5ChDmlx9Lf9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl54fSIACgkQKVhNn0CG
RXgB9gf/czCDQFsGD5+WktMhV9sOMlVgRQOL0U2UZQHxiY09+St+ielgh/7aLqbn
Km/YM/okiqxu++m108B4qjuWXPMpoYMLBydNgD0sVdouLfeJOxDK9jGGf0a5JTMU
Pkc6T3IuzU5VN9cN8ywRcSvLoFYVyuS+dZnuWUJb4x9ku7k3NY2yKHzUuLSQX0gq
9c5kP72EeNWeyiyPBcSOw/oK2EsGV2JKlpLTvzytKiOR9y2C31ABg3exNJzGIXPf
vyyDPsCsgLN4QcJh2/WdBE89Bd/sqaRgVyJG9Y4QQhCv1WZ6ntTLRIil/dLMlhh3
HGqHfWUmu9aQ34yNT7zyG7exOXQs+g==
=PBLR
-----END PGP SIGNATURE-----

--ZkHOFkNnHNeljunej2yVqS5ChDmlx9Lf9--

