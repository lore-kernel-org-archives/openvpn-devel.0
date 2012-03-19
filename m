Date: Mon, 19 Mar 2012 10:30:35 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120319093035.GL1359@...1296...>
References: <4F632647.30603@...515...>
	<20120316114747.GV6615@...1330...>
	<CAOazyz2K4s3V3Yq6W8f9Q2us+vk9ArLT1UX3gKCS4Zxr245o+g@...278...>
	<4F633670.1000807@...1114...>
	<CAOazyz0nMAdD5H2MbBR=+ssOPPHgFsdgxr2g-SwWb4BHzDMdcw@...278...>
	<4F633B0C.8080502@...515...>
	<20120316152145.GF1359@...1296...>
	<4F66EE39.5050405@...515...> <4F66F5ED.30006@...1114...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tpXmNJJzF/fVXUEg"
Content-Disposition: inline
In-Reply-To: <4F66F5ED.30006@...1114...>
Subject: Re: [Openvpn-devel] New generic buildsystem: lzo enabled or
	disabled by default?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn.list@...1114...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--tpXmNJJzF/fVXUEg
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Mar 19, 2012 at 10:01:33AM +0100, David Sommerseth wrote:
> On a related note: --enable-iproute2
>=20
> Should we also expect this to be available on all *nix platforms?
> iproute2 has been available on most platforms I know of for a very long
> time, and is superior net-tools in very many ways.

<nitpick>
s/*nix/Linux/, and even there, it's not always installed by default.
</nitpick>

I would agree that openvpn should use iproute2 by default on Linux,
and the option should be renamed to --disable-iproute2 to get back
to the old-style ifconfig/route style behaviour.

Currently, iproute2-or-not is a linux thing, so this would not have an
effect on any *BSD (no iproute2) or Solaris (I'm not sure right now
whether OpenSolaris has it, can't check).   Solaris buildbot is on my
roadmap... so I can look into this as soon as The Big Merge is done.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--tpXmNJJzF/fVXUEg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT2b8uqkuBuNlUUl1AQKUFwP9Gati/Uq1yobONJ6Cfiy81x6zWs1Uw//w
iSTeSCrjSH9aMhxSdCnEG9blL4OoqK+Ruuz6OCd4Jz4kiVwnE6AfCTJSvZhBdStm
q2dpRYA2wEzFG+3biTJzWYVzQ7uFjnRskihYItGZWcFlE18EGnMAoPqdY7pmDc5A
Gns7n302sYk=
=HnbK
-----END PGP SIGNATURE-----

--tpXmNJJzF/fVXUEg--

