Date: Wed, 26 Oct 2016 21:35:46 +0800
From: Antonio Quartulli <a@...2181...>
Message-ID: <20161026133546.GA26376@...2182...>
References: <20161026120631.15946-1-a@...2181...>
	<30247351-24a3-4314-40c5-bfb5e82f84b0@...1435...>
	<20161026124019.GE8925@...2182...>
	<2f3f0e84-38f8-3940-d9d5-5e8c99c10696@...1435...>
	<41f11dfb-3910-ac81-e665-d1e4fa30de0e@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <41f11dfb-3910-ac81-e665-d1e4fa30de0e@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] don't mix settings when crl-verify
 option appears more than once
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wed, Oct 26, 2016 at 03:30:39PM +0200, Arne Schwabe wrote:
>=20
>=20
> Am 26.10.16 um 14:48 schrieb Steffan Karger:
> > On 26-10-16 14:40, Antonio Quartulli wrote:
> >> I was planning to do the rest of the refactoring in a second patch.
> >>
> >> At this point I think it would make sense to reject this patch and wai=
t for a
> >> full patchset set where I will:
> >>
> >> 1) "fix" every inline option to be sure that we don't carry around bog=
us
> >> settings
> >> 2) switch any *_inline field to bool
> >> 3) refactor the code to avoid strcmp()
> >
> Beware that the [[inline]] also serves as a filename and you have to add
> extra logic everywhere a file name is printed.

Thanks for the hint! I was just fighting with that :)


Cheers,

--=20
Antonio Quartulli

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYELEvAAoJEJ6F1zG2JyOsmzEP/3Pn+WlDb/JpSfYZE7Q32F1T
95hQqf5rgbsV2lXU8wrZ3jqihOhOG/sjf3QX3v708H0IYKJE5p25R/DsgaNa7rn3
KHeQQF5dGqfjHwOBZW/h3lsoyhaBSM+qr7s/HCZFdi66UHeMVwcdVeZHenZxvsJX
uU1WPMV5FF44pe7tHwjkbchWu9gEnC1jwLnNU/0MreSOzzd5AmJCJV+2WqL7LC5n
1SaO0DDAjKIRNIb5haDEs7RBc8C4ByWmqJu3X+rSU6d3e8mNO2EAZu4ug0nq9ITS
OLipoZIH4S8nYHt247hIrrb+/ZWs0avslfAsJceq6RbDx+7Mzu1Ge8hOd+mSSSJm
c1e8tEU2ZHEtCkWBmRc8c6IaErR8i65OIpu3nqi47wLHPgq57pJgG8jOpCNgCSbw
e9N6QCbpKk8xSpRxoFSBCm1dWdC2Aei4T7UeSmNGYwnFq1Jx+Fx3lulEmOQegwte
Q23NpQ4MxjfjhW2nloXHCJVpEtLRVPjDZBkJn+JKyqY5BVFaMx8W9iv9s6MWmJfq
s3AFOTukCroKEgP4Z4MA2cHb5IXUQnsA0JAx+sE9Y9PYbw1dku4VcqFh0ySQZdp9
R9CGGO730MyVbgSMkbLzP9f44N6h+wJjK9PRU4TTzuOmb6x74CXQam4ZlSJM5rw3
C69Ofp13+NvjjbOKTiv2
=Yyup
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--

