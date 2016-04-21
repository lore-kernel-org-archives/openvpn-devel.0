Date: Thu, 21 Apr 2016 19:59:53 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160421175953.GJ53051@...1296...>
References: <950C8167-A5FF-4F56-9020-C956EED49557@...2127...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UkJByDtiyhV6M6Gk"
Content-Disposition: inline
In-Reply-To: <950C8167-A5FF-4F56-9020-C956EED49557@...2127...>
Subject: Re: [Openvpn-devel] Unit testing in openvpn?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jens <openvpn-devel@...2127...>
Cc: openvpn-devel <Openvpn-devel@lists.sourceforge.net>

--UkJByDtiyhV6M6Gk
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Apr 21, 2016 at 09:12:28AM +0200, Jens wrote:
> I think that adding unit tests would greatly improve the ease of
> implementing new features for openvpn.  I have spend a lot of time
> coding Java (and others), and unit testing greatly improved my code
> quality, my throughput, and last, but not least, my confidence in
> the code. Indeed I have become very humble when it comes to the
> question of ???what could possibly go wrong with this small change????

I'm somewhat of a mixed mind on this.

Experience in the last few years after the current development team
sort of "inherited" the OpenVPN code base was that *these* things that
have blown up in a spectactular way were usually

 - (unexpected) system dependencies - like, a totally harmless and well-tes=
ted
   change to the socket stuff which broke compilation on all *BSDs

 - too many options, and users using "unexpected" combinations of options -=
=20
   so you change something, you are aware that it's an intrusive change, and
   all your individual tests work out nicely - but then, incoming user=20
   complaint, because "if I use this with systemd *and* a password-protected
   key *and* <x>, it fails!"

 - operating systems changing behind us, like MacOS 64 bit keeping binary
   compatibility with MacOS 32 bit for some structures, thus breaking=20
   source API compatibility (use uint32_t instead of "int" now)


some of theses can be fairly well tested in our current buildbot framework
(=3D each commit is built on nearly all supported platforms, and runs
"make check", which does a full "setup network, transfer data, close down
network, see if it cleans up properly" check if t_client.rc is there),
but some are really hard to test for, like the constant --multihome=20
brokenness on one or the other platform (because you need that platform,
more than one IP address configured, and actual UDP packets being sent
back and forth to excercise the problem)...


So, I'm all for doing more extensive testing, but unit testing will not
catch those things that have bitten us big time in the past - because=20
when we do "big changes", on purpose, but forget about combinations of
options, all the unit tests will succeed (because the individual units
are all well-behaved, just the combination isn't)

> What would be the steps to include unit testing?
> ?????????????????????????????????????????????????????????????????????????=
??????????????????????????
>=20
> 1) Decide /if/ we want unit tests

Yes :-)

But it will be hard.  The current source code does not lend itself very
nicely to unit testing (and those bits that *do*, like buffer.c, are so
well established and tested by now that we tend to never having to touch=20
anything there anyway)...

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--UkJByDtiyhV6M6Gk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVxkVGakuBuNlUUl1AQJrBwQAtNSRPwvXj9IOncGHQQZtykhIiwCqVqc5
akgiqdS5LHUvh8AoetbNmsh+Zdb59UBZU9a6OHsqXfrq61vEO6idfSNnKDMEE4Z2
aW0PG/u1rL7ddrZiz7TX8isEbnaPeWs+DCsaF6Kv3GWTHOP9mxJeAkE0YVQU/Nna
UKhdwYeeyj0=
=TIdI
-----END PGP SIGNATURE-----

--UkJByDtiyhV6M6Gk--

