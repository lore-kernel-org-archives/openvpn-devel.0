References: <20190411205159.7369-1-chipitsine@...277...>
 <20190411205159.7369-2-chipitsine@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <974b3444-da8b-2bad-a3ad-7852e81892d2@...2080...>
Date: Tue, 16 Apr 2019 19:36:43 +0200
MIME-Version: 1.0
In-Reply-To: <20190411205159.7369-2-chipitsine@...277...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="f2WirIAj4tXYUZd1W8DFRUqyPRStz9bmI"
Subject: Re: [Openvpn-devel] [PATCH 1/1] initial cirrus-ci support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: chipitsine@...277..., openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--f2WirIAj4tXYUZd1W8DFRUqyPRStz9bmI
Content-Type: multipart/mixed; boundary="DLb3Ym6fRiMnTB3No3GzHo24FPnaYLqc6";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: chipitsine@...277..., openvpn-devel@lists.sourceforge.net
Message-ID: <974b3444-da8b-2bad-a3ad-7852e81892d2@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 1/1] initial cirrus-ci support
References: <20190411205159.7369-1-chipitsine@...277...>
 <20190411205159.7369-2-chipitsine@...277...>
In-Reply-To: <20190411205159.7369-2-chipitsine@...277...>

--DLb3Ym6fRiMnTB3No3GzHo24FPnaYLqc6
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 11/04/2019 22:51, chipitsine@...277... wrote:
> From: Ilya Shipitsin <chipitsine@...277...>
>=20
> enabled FreeBSD 12.0 builds
>=20
> Signed-off-by: Ilya Shipitsin <chipitsine@...277...>
Hey,

Just wondering about the value of adding yet another CI into the mix we hav=
e?
We have Travis and buildbot.

Travis doesn't handle all the *BSD flavours but gives us Windows.  Our
buildbot setup does Linux (CentOS, Fedora, Ubuntu, Arch), macOS, FreeBSD (7=
.4,
9.0, 10.3, 11), NetBSD (5.1, 7.0), OpenBSD (4.9, 6.0), OpenSolaris 10 ... I
might have overlooked a few.

The sum of this seems far more than what cirrus-ci provides.  So I really
wonder about the value here.  You can always argue that it's just a text fi=
le
laying there if not being used, but we also want to avoid "dead files" in o=
ur
repository.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--DLb3Ym6fRiMnTB3No3GzHo24FPnaYLqc6--

--f2WirIAj4tXYUZd1W8DFRUqyPRStz9bmI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJcthKwAAoJEIbPlEyWcf3y1g4QALet7nNUfNqQJAapUYX7eQuD
j9uSz9l9+G/0NvXJ5iDqS8k/2nbI580jv5XMe7t3f5KS0l/VBs85ZSSmM0+3Bwzl
KupP84uPury2QHZi6vr2cmSsgrA3Z92iVwm0+ZAJPtkSUVeRDzsD1Zzfacxuenlt
BJreLPlNPwnODmkWc/YKTCB1UNAfcqTq54q39FSIDB46NFZSje/lgRKGRyiunzJi
naixXd2SiME7RZgHR90jXIbfhQE3fKpLP421l8orjjg2Ww5qAOVkR1Q1dFjU18BJ
nRSmxSldy+X+1mg1uhYVcYV9Vl2NSgKYFLMpNVZ5JKCDJFOPQhH7IQhn6vWdnsSj
pvXrY2Y3ETt7fK/6W3/M7BtxJTu95CWVREynulaSXa8kw53ex23IxltIuigtjEXL
5yZL5Hfyjc6kSjoo+52gmxAPDyG1GK31O/T8OZK5ZjgzRVJkNI0+NPY0PBAYZvur
BAjy3RxR2nQ8RcEEgs1n5qcDtNwRjDRK8gWDt5Kw4J2s7X0OR69cR9y+2F/obU+t
/59K3b25vyha+hqVto2X5QaMkDpO7d0+w9mvml/efmIjCf8jl+ZxvRk2uabdc3VW
c6G/IWMSgy85zg3Mr3kNWJADavbp0ocixb+oXjszrURuBNdUYcs1KTVdfqk1wAWJ
Um25NZTg/iG4Tea8R/lP
=Pzx0
-----END PGP SIGNATURE-----

--f2WirIAj4tXYUZd1W8DFRUqyPRStz9bmI--

