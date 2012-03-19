Date: Mon, 19 Mar 2012 10:42:35 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120319094235.GM1359@...1296...>
References: <4F632647.30603@...515...>
	<20120316114747.GV6615@...1330...>
	<CAOazyz2K4s3V3Yq6W8f9Q2us+vk9ArLT1UX3gKCS4Zxr245o+g@...278...>
	<4F633670.1000807@...1114...>
	<CAOazyz0nMAdD5H2MbBR=+ssOPPHgFsdgxr2g-SwWb4BHzDMdcw@...278...>
	<4F633B0C.8080502@...515...>
	<20120316152145.GF1359@...1296...>
	<4F66EE39.5050405@...515...> <4F66F5ED.30006@...1114...>
	<4F66FE98.4030707@...1114...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXAoLeOWtqbacoe/"
Content-Disposition: inline
In-Reply-To: <4F66FE98.4030707@...1114...>
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
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--OXAoLeOWtqbacoe/
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Mar 19, 2012 at 10:38:32AM +0100, David Sommerseth wrote:
> On 19/03/12 10:01, David Sommerseth wrote:
> [...snip...]
> >=20
> > On a related note: --enable-iproute2
> >=20
> > Should we also expect this to be available on all *nix platforms?=20
> > iproute2 has been available on most platforms I know of for a very
> > long time, and is superior net-tools in very many ways.
>=20
> I've been educated by Gert now, and learned that iproute2 is not common
> on most Unix based platforms, but is a Linux oriented tool.  So this
> suggestion makes no longer much sense.

Actually, I still agree with you that enabling it by default on Linux
is the way forward.

(Or hook into the netlink interface directly, but I'm not sure whether
this will lead to easier to understand code, and easier to read log files,
than what we have now - where you could, for testing, run the commands=20
manually to see which ones cause problems)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--OXAoLeOWtqbacoe/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT2b/i6kuBuNlUUl1AQKj4AP/fw0soJLfNADSbtE+0aFF1KrsWofNPHbT
gGMe7HRLduF8an17/lCH0EGPlX/zv658A4E8FMu9VsJNebm7LTMIM9hZMkulPzdX
23mbDj0svcMfhQ7oz7NRo1Hk6XSIfuuDmWqDr33p7I713gjHnQamrinKn4gHb2my
alN0T3DS1DY=
=/LiK
-----END PGP SIGNATURE-----

--OXAoLeOWtqbacoe/--

