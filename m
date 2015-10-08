Date: Thu, 8 Oct 2015 10:11:19 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20151008081119.GW22054@...1296...>
References: <1444156707-14087-1-git-send-email-steffan@...1856...>
	<20151008064333.GR22054@...1296...>
	<56161D90.7040101@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c7rykKtsZvepKFKR"
Content-Disposition: inline
In-Reply-To: <56161D90.7040101@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] openssl: be less verbose about cipher
 translation errors
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

--c7rykKtsZvepKFKR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Oct 08, 2015 at 09:38:56AM +0200, Arne Schwabe wrote:
> Am 08.10.15 um 08:43 schrieb Gert Doering:
> > On Tue, Oct 06, 2015 at 08:38:27PM +0200, Steffan Karger wrote:
> >> Translation errors are usually not a real problem, since we don't main=
tain
> >> the complete list of ciphers OpenSSL supports.  So, be less verbose if=
 we
> >> can not find a translation.
> >=20
> > I wonder what the motivation on this one is.  If the user requests a=20
> > certain cipher, and we can't give it to him - shouldn't this be warned
> > about quite prominently?
>=20
> The user request a cipher that exists, but is not our translation table.
> Gets a confusion error message.

But what happens in that case?  PolarSSL build, user requests something
he knows from OpenSSL, we don't have a translation entry for it - will
he receive "the default cipher set" (not what he is asking for) then?

I'm not sure I truly understand the scenarios where a user would trigger
that warning, which is why I'm asking.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--c7rykKtsZvepKFKR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVhYlJqkuBuNlUUl1AQK+cQP+MNvlxqcF47iNpEoBttuDOTqxgZJuqxp5
ZDLbbCylhWXyTJEdsnHbtFAV2XOoaBTEk6xP11B9xoZtewhcnejVV+37Skx/1zKX
dUHkUGmwNfzesyDSS2kHFYI9Dn312ledkbhcQZrYs5/KXQ9m4+rVaZZE+p/9S9Fe
6xAsG0NOLtI=
=7hiS
-----END PGP SIGNATURE-----

--c7rykKtsZvepKFKR--

