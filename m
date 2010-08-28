Message-ID: <20100828230440.31685.qmail@...1287...>
Date: Sun, 29 Aug 2010 01:04:40 +0200
From: Peter Stuge <peter@...1287...>
References: <4C77640D.6000708@...515...> <20100828024617.942.qmail@...1287...>
	<20100828092954.GI10703@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <20100828092954.GI10703@...1296...>
Subject: Re: [Openvpn-devel] Summary of the IRC meeting (26th Aug 2010)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Gert Doering wrote:
> > > Did some testing to see if creating a static binary would be
> > > trivial. As it was not,
> >=20
> > Why wasn't it? Please share details from the testing.
>=20
> Naively just calling "gcc -static" led to linker failures due to
> OpenSSL not being found.
>=20
> This was a "can we do it that easily?" quick test, so we didn't
> investigate further why it failed.

It failed because dependencies were not met, so the test doesn't
really say much about OpenVPN..

I tried to add a comment to the ticket in Trac about USE flags in
Gentoo, but Trac rejects it as potential spam and I will not waste
my life trying to work around the filter.

I tried adding -static -lz when building openvpn-testing.git and got
the following:

$ gcc  -g -O2 -static  -o openvpn base64.o buffer.o crypto.o dhcp.o error.o=
 event.o fdmisc.o forward.o fragment.o gremlin.o helper.o httpdigest.o llad=
dr.o init.o interval.o list.o lzo.o manage.o mbuf.o misc.o mroute.o mss.o m=
tcp.o mtu.o mudp.o multi.o ntlm.o occ.o pkcs11.o openvpn.o options.o otime.=
o packet_id.o perf.o pf.o ping.o plugin.o pool.o proto.o proxy.o ieproxy.o =
ps.o push.o reliable.o route.o schedule.o session_id.o shaper.o sig.o socke=
t.o socks.o ssl.o status.o thread.o tun.o win32.o cryptoapi.o  -lssl -lcryp=
to -llzo2 -ldl -lz
plugin.o: In function `plugin_init_item':
/tmp/openvpn-testing/plugin.c:215: warning: Using 'dlopen' in statically li=
nked applications requires at runtime the shared libraries from the glibc v=
ersion used for linking
misc.o: In function `get_group':
/tmp/openvpn-testing/misc.c:117: warning: Using 'getgrnam' in statically li=
nked applications requires at runtime the shared libraries from the glibc v=
ersion used for linking
misc.o: In function `get_user':
/tmp/openvpn-testing/misc.c:82: warning: Using 'getpwnam' in statically lin=
ked applications requires at runtime the shared libraries from the glibc ve=
rsion used for linking
socket.o: In function `getaddr_multi':
/tmp/openvpn-testing/socket.c:170: warning: Using 'gethostbyname' in static=
ally linked applications requires at runtime the shared libraries from the =
glibc version used for linking
/usr/lib/gcc/i686-pc-linux-gnu/4.4.4/../../../libcrypto.a(b_sock.o): In fun=
ction `BIO_get_port':
(.text+0x48a): warning: Using 'getservbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking

I get a binary though:

$ ls -l openvpn
-rwxr-xr-x 1 stuge stuge 3781597 Aug 29 00:58 openvpn
$ strip openvpn
$ ls -l openvpn
-rwxr-xr-x 1 stuge stuge 2160084 Aug 29 00:59 openvpn


The only thing missing was -lz to satisfy OpenSSL dependencies.
If pkg-config is available in the system then pkg-config openssl --libs
is all that is needed to get the linker flags needed for OpenSSL.
Maybe use PKG_CHECK_MODULES() in configure.ac to check for OpenSSL
before trying the current seemingly manual tests?


//Peter

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFMeZYIhR3Q0dhIfEgRAk9tAJ4scuCtd3plU57MDF/L1jt/+aTBjACgip5p
ygEktRpaWUCy3LfODFux84s=
=8yGQ
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--

