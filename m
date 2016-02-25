Date: Thu, 25 Feb 2016 17:34:42 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160225163442.GJ24952@...1296...>
References: <1455937988-12414-1-git-send-email-selva.nair@...277...>
	<201602251201.u1PC1qiO020709@...2054...>
	<20160225125742.GA21087@...1296...>
	<CAKuzo_h4TxqCnQ9jzQ1D07jKjvfGJJAhjJR-OpPUU_cpNw20WA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lsD+SzsxON+tebmm"
Content-Disposition: inline
In-Reply-To: <CAKuzo_h4TxqCnQ9jzQ1D07jKjvfGJJAhjJR-OpPUU_cpNw20WA@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Restrict options/configs
 for startup through interactive service
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--lsD+SzsxON+tebmm
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Feb 25, 2016 at 10:57:52AM -0500, Selva Nair wrote:
> > I'm a bit at a loss why it is bombing here...
>=20
> Ah, sorry I should have checked 32 bit compilation. Its due to missing
> includes, not a big problem for 64 bit as dll import names are not mangle=
d,
> but in 32 bit linker may be looking for _PathIsRelativeW etc.. (I think..)
> Anyway my mistake.. Will do a patch..

Ah!  Learned something new today.

(Unixy systems usually only break on missing includes if functions are not=
=20
real "functions" but macros instead...)

Thanks for the quick explanation and ACK, buildbot should be happy again
now - and I can push stuff again without being hit by build failure
complaints :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--lsD+SzsxON+tebmm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVs8tIqkuBuNlUUl1AQLKuQP/ZleqPuYRqR7Sjvlz1h8L9PxnISf2YYHz
Be6NwZpcF1KGL4jHca3oGiC+cX403oxo8JM/PQUNC2Uej8c+jpnPJiI6G5RfbWUM
loS1kQT1FGmMwD56QnVXUUnY6AAuS5/KeLFiCgOebnSlevU+PPKMQMf95z4C97dX
qVr6e7NH980=
=Vyhz
-----END PGP SIGNATURE-----

--lsD+SzsxON+tebmm--

