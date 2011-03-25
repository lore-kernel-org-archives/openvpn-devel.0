Date: Fri, 25 Mar 2011 16:23:57 +0100
From: JuanJo <jjo+ml@...410...>
Message-ID: <20110325152353.GA18863@...1455...>
References: <4D8C6068.2070702@...1114...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <4D8C6068.2070702@...1114...>
Subject: Re: [Openvpn-devel] Changes to the git tree
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Fri, Mar 25, 2011 at 10:29:12AM +0100, David Sommerseth wrote:
> Hi all,
>=20
> As we're getting closer and closer to the v2.2 release, I've began to
> prepare the git tree for the v2.3 development phase.
>=20
> In the developers meeting July 8, 2010 [1] it was also decided to start
> migrating completely over to git.  This move we are now doing is following
> in this track.  We have already released 2.1.4 and all the 2.2 betas and
> release candidates from the git tree as well.

Great news! =3D))

>=20
> The new change is that I have merged beta2.2, bugfix2.1 and feat_misc into
> a new master branch.  The old master branch is scrapped.
>=20
> When feat_ipv6_payload and feat_ipv6_transport branches have been *rebase=
d*
> against the new master branch, I will merge them into the master branch.
> These two feature branches will be the most important feature changes to
> OpenVPN 2.3.

I've rebased my latest ipv6_transport branch over _today_'s
openvpn-testing master, over commit badba714db7dc62c7844.

It git//github.com/jjo/openvpn-ipv6 master branch, ie:

$ git log --oneline openvpn-testing-master^1...master
ecff2d8 * ipv6-0.4.15b: rebase over openvpn-testing-master
d3774cd * ipv6-0.4.15: add --multihome support to xBSD   - _both_ for IPv4 =
(wh
c47fd4b * ipv6-0.4.14: fix xinetd usage:  - closes http://bugs.debian.org/5=
741
5d6dbb0 * fix --multihome for ipv6: IPV6_RECVPKTINFO   - setsockopt IPV6_RE=
CVP
830038f * fix --multihome for ipv4: cmsg_len must compare against in_pktinf=
o=20=20
a698464 * undo mroute.c changes related to ipv6 payload,   nothing to do w/=
ipv
3ac2ac7 * rebased to v2.1.1 release * document {un,}trusted_ip6 in manpage
4c25c5e * doc updates
6caf7f3 * fix --disable-ipv6 build
d4b9b74 * updated doc
9d4c64b * polished redirect-gateway (ipv4 on ipv6 endpoints) support
efa85c8 * (prototype) fix for supporting "redirect-gateway" for tunneled ip=
v4=20
1ad6fc2 * no new funcionality, just small cleanups: - cmdline options help:=
 ad
ebce9fb * openbsd: no IFF_MULTICAST, #ifdef around it
51b3ca6 * doc updates
4af2d42 * fixed segfault for undef address family in print_sockaddr_ex (tha=
nks
fc9a44e * socket.c: better buf logic in print_sockaddr_ex
e293510 * TODO.ipv6 update
aa8e957 * fix multi-tcp crash (corrected assertion)
ead3784 * init.c: small in-doc tweaks
2d7da34 * init.c: document the ENABLE_MANAGEMENT place to work on
bf00640 * updated {README,TODO}.ipv6 from feedback at openvpn-devel mlist
d7627b1 * renamed README.ipv6{.txt,}
6d1b80b * correctly setup hints.ai_socktype for getaddrinfo(),   althought =
sor
e478770 * make possible to x-compile openvpn/win32 in Linux
a1bea68 * doc update w/unittests results
485540c * document ipv6 milestone status
b7f203c * ipv6 on win32 "milestone": 1st snapshot that passes all unittests
4d3df22 * fixed win32 non-ipv6 build
387df51 * added README.ipv6.txt
97549c6 * important fix for tcp6 reconnection   was incorrectly creating a =
PF_
51afc8b * support --disable-ipv6 build properly: - tests now are pass (and =
fai
d9c04ef * socket.c: use USE_PF_INET6 in switch constructs to actually toss =
the
97ba084 * migrated all getaddrinfo() to getaddr6 * tests Ok: {loopback,remo=
te}
ea93a07 * created getaddr6(), use it from resolve_remote()   next: merge ip=
v{4
8335caf * rebased openvpn-2.1_rc1b.jjo.20061206.d.patch * passes {udp,tcp}x=
{v4
badba71 Use a version-less version identifier on the master branch

> {...snip...}
>=20
> kind regards,

Cheers,

>=20
> David Sommerseth
>=20
>=20
> [1] <http://thread.gmane.org/gmane.network.openvpn.devel/3829>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.11 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
>=20
> iEYEARECAAYFAk2MYGgACgkQDC186MBRfrqOzQCaAxhIVqjz+a0ApmoArNnLEWM2
> TeAAoJRTzUCoZD5ksG/nWNskghDyKiti
> =3D9UuW
> -----END PGP SIGNATURE-----
>=20
> -------------------------------------------------------------------------=
-----
> Enable your software for Intel(R) Active Management Technology to meet the
> growing manageability and security demands of your customers. Businesses
> are taking advantage of Intel(R) vPro (TM) technology - will your softwar=
e=20
> be a part of the solution? Download the Intel(R) Manageability Checker=20
> today! http://p.sf.net/sfu/intel-dev2devmar
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--=20
--=20
--JuanJo ; echo jAjo@...1263... | sed 's/[SPAM]//g'

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk2Ms4kACgkQo/fiSWZycXeyKACgoMG1I2sLoTeprN0QwOnP1M+Q
uB0AnAj21ZRNXH8Nx/0A/WHkaEQnpE7m
=4PaK
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--

