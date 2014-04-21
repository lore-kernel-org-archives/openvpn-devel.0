Date: Mon, 21 Apr 2014 11:04:48 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140421090448.GS16637@...1296...>
References: <1393530007-6225-1-git-send-email-steffan.karger@...1435...>
	<53502E71.8070503@...515...> <53511F74.3010708@...1435...>
	<53528943.3090205@...1435...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vjhvBPueKAUfQM0/"
Content-Disposition: inline
In-Reply-To: <53528943.3090205@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] PolarSSL 1.3
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

--vjhvBPueKAUfQM0/
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Apr 19, 2014 at 04:33:39PM +0200, Steffan Karger wrote:
> Ouch, James was totally right. This would always be true, but should
> always be *false* for reasonable input; the check has to be the other
> way around. Attached the same two patches, except for that single
> character...

Merged both, will push soon.=20=20

When test-building, it seems that there is a patch missing to the plugin=20
API bits...

libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I../../../../openvpn/src/plugin=
s/auth-pam -I../../.. -I../../../../openvpn/include -g -O2 -MT auth-pam.lo =
-MD -MP -MF .deps/auth-pam.Tpo -c ../../../../openvpn/src/plugins/auth-pam/=
auth-pam.c  -fPIC -DPIC -o .libs/auth-pam.o
In file included from ../../../../openvpn/src/plugins/auth-pam/auth-pam.c:5=
1:0:
../../../../openvpn/include/openvpn-plugin.h:35:1: error: unknown type name=
 'x509_cert'
make[4]: *** [auth-pam.lo] Fehler 1

(basic "./configure --with-crypto-library=3Dpolarssl && make" on Linux)

Could you...?

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--vjhvBPueKAUfQM0/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBU1TfMKkuBuNlUUl1AQLUrwP/eGRa/BI+PTvXcEvrcDaz1beGueP2bPgJ
R6rex+/kTpzN+kkIiqIr/scw9legrHoJ7mBHkucQPj/Af2kZwBXWc98SfjoC7KTz
Vqo1oAdG5sinUtyy9ZUTbF9o05MEpwuPa+jziGZtzt5QT7+buXskt1vVSY3YnzXx
C0fuuisO60U=
=0otv
-----END PGP SIGNATURE-----

--vjhvBPueKAUfQM0/--

