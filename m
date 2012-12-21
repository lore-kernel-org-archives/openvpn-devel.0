Date: Fri, 21 Dec 2012 11:25:58 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20121221102558.GC22465@...1296...>
References: <20121214181815.GQ22465@...1296...>
	<50D2D610.5080406@...1114...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kOwL1JAUlCcfd5RC"
Content-Disposition: inline
In-Reply-To: <50D2D610.5080406@...1114...>
Subject: Re: [Openvpn-devel] coverity issue 2 - dead default / code cleanup
	in mtcp.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--kOwL1JAUlCcfd5RC
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Dec 20, 2012 at 10:10:40AM +0100, David Sommerseth wrote:
> > Cleanup in 2.4?
>=20
> Does it hurt to have this "dead code"?  Agreed, if all the flags are
> covered, we'll never see 'default' in action.  But is it possible that
> these flags can be extended at some point in the future, which we need
> to account for?  I somehow find confidence in having this "trap" with
> msg(M_FATAL,...) for future scenarios.  Not because I strongly believe
> it will be needed, but more like a precaution (as in "Yes, we have
> thought about this")

Well, I'd completely get rid of the switch/case here - we only have=20
4 different cases, 2 of which are handled in the same subcase, so
"setting up flags and then switch(flags), plus default: handler" seems=20
to add more confusion than just handling possible cases directly in
the if() statements...

In general, having a "must not happen" handler to validate assumptions
is a good thing, but if those preconditions are set by code 5 lines up,
it's a bit over the top...

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--kOwL1JAUlCcfd5RC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUNQ5NakuBuNlUUl1AQKKBwQAsqxNA8Pw3pKMVc/91sLoeDWRaaSI5XRe
svloOC8PnxRs2S4lmKqpko4kG5fsbfjK2vENpf9Og19+3mr/+69m6sk+wYCl+U1V
nW6EOhDOqGF3bo2gBuMYXZ7lLp1L11ffM6l5acZ4Gg38lUmeLTPak3uycBmTkCDr
sIEcAEnQY9Y=
=Tsmy
-----END PGP SIGNATURE-----

--kOwL1JAUlCcfd5RC--

