Date: Thu, 1 Dec 2016 13:38:13 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161201123813.GM78624@...1296...>
References: <1480545687-19365-1-git-send-email-davids@...515...>
	<20161201080132.GC78624@...1296...>
	<9796b12f-21c2-d9ed-90e3-51de843b2eb8@...2080...>
	<20161201123306.GK78624@...1296...>
	<CAA1AbxLbWojTD_gzqHGEkpYnSG3GSKakV0QEVptq+YURLqK4Ww@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gdTfX7fkYsEEjebm"
Content-Disposition: inline
In-Reply-To: <CAA1AbxLbWojTD_gzqHGEkpYnSG3GSKakV0QEVptq+YURLqK4Ww@...278...>
Subject: Re: [Openvpn-devel] [PATCH] push: Provide a warning if
 --ifconfig-push have argument mismatch with --topology
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: David Sommerseth <davids@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--gdTfX7fkYsEEjebm
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Dec 01, 2016 at 01:35:49PM +0100, Steffan Karger wrote:
> On 1 December 2016 at 13:33, Gert Doering <gert@...1296...> wrote:
> >    ((uchar *)&c->c2.push_ifconfig_remote_netmask)[0]
>=20
> Looks like dereferencing a type-punned pointer to me ;)

I was waiting for this :-)

(...but I thought "char *" is allowed by the rules?)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--gdTfX7fkYsEEjebm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYQBm0AAoJEB2Cnv7KVigSmCIL/igbN0QtoRoOhF4fbCxeC+E/
r7tPc9z2JOkhOc/NZ4bZjJIVjB0PgNVGsGm0F2UswMxrXLOndo6v/bd8jpfrbu4u
aI5IJ5hqeoDSn2jmYZ0nTV+weidvn1GYj2auRtoAs17tdWVA+bUOwvLE8PrrlTo6
cdC8UFyb+vZGhGPpewKW5T/uQzvuRanXSHpWDXypkxupHwFHpY5inS2lqSxqsiYK
tEj5+kgN6jfZ1PkcyYP/Q62MQdWDI86965GHf70EHG0k3FhtQ54soXEKwbF86ILa
7WEqWVCtE+G5MuOOKgBSYXsuJDWad2Q2Jrny8mdEhLQ8SNC/mU2tSEFjA/7o2ZD0
K+OCn7NcBYcYKQt2Q1hVj15NZpJs+zIUXTsE99F/BWw1MfojGPoFPG2golMUY7zT
MPRftcy1PDC0HvHEjzupEmcZAyu3kdADZqZcVj2z++v5WH7eD4rWjihu2EyXjJlD
sM1odMEMwY7bbQJeHFURCTd0W463yl+ptfLBadbxsA==
=ebnP
-----END PGP SIGNATURE-----

--gdTfX7fkYsEEjebm--

