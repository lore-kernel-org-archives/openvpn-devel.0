Date: Thu, 3 Nov 2016 13:26:43 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161103122643.GY28918@...1296...>
References: <f315ec02-c70b-0793-f29f-4fd03794c4eb@...515...>
	<f48dd34a-40c8-f30d-99ae-7261f3d5ee3b@...515...>
	<CAEsd45T+roc4zKmzjhq7uHpEQn-BxVBoYzj2TyzFinPxF3sXrA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AGgF02x1jLHCLk2P"
Content-Disposition: inline
In-Reply-To: <CAEsd45T+roc4zKmzjhq7uHpEQn-BxVBoYzj2TyzFinPxF3sXrA@...278...>
Subject: Re: [Openvpn-devel] Summary of today's (Monday,
 10th Oct 2016) community meeting
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--AGgF02x1jLHCLk2P
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Nov 02, 2016 at 06:19:26AM -0400, Jonathan K. Bullard wrote:
> On Mon, Oct 10, 2016 at 4:26 PM, Samuli Sepp=E4nen <samuli@...515...> wro=
te:
> > Discussed OpenVPN 2.3.13 release. Three things are missing:
> >
> > 1. recursive routing
> > 2. block-outside-dns v2
> > 3. 64MB renegotiation for 64-bit block ciphers
> >
> > Cron2 will take care of 1-2, and syzzer will tackle 3.

2.3.13 has been released, but 1. and 2. are actually still missing - I've
lost track of 2., and 1. did not work out.  3. is in.

2.3.14 will follow "in a few weeks", having 1.+2..  But don't wait for it.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--AGgF02x1jLHCLk2P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBWBstAqkuBuNlUUl1AQIuzQQAnuB0vFuEGyO1kowU8l5T0/KwrDMPqgRC
4UyVfuEcss189B7EDHCi29/gc5dQxN2ec0KU055xxJBXYOLO6Rr1O9uBqCEThcd2
D33sUgRN+szF5irXjfPLaDW+pW08DLQ0bBINjCcU0JNJKEj8CZjTWmxLRwhqy99/
3r2RxD0APTs=
=CjwZ
-----END PGP SIGNATURE-----

--AGgF02x1jLHCLk2P--

