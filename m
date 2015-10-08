Date: Thu, 8 Oct 2015 08:43:33 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20151008064333.GR22054@...1296...>
References: <1444156707-14087-1-git-send-email-steffan@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Lez9QO3Seu3ycz0M"
Content-Disposition: inline
In-Reply-To: <1444156707-14087-1-git-send-email-steffan@...1856...>
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
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--Lez9QO3Seu3ycz0M
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Oct 06, 2015 at 08:38:27PM +0200, Steffan Karger wrote:
> Translation errors are usually not a real problem, since we don't maintain
> the complete list of ciphers OpenSSL supports.  So, be less verbose if we
> can not find a translation.

I wonder what the motivation on this one is.  If the user requests a=20
certain cipher, and we can't give it to him - shouldn't this be warned
about quite prominently?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Lez9QO3Seu3ycz0M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVhYQlKkuBuNlUUl1AQK6vwP9Ez1YxSeC7Xo5Ts2CbKugcWGs6xY9b92A
JadhF1BfOXNEAqa2oKZpHXrKFmFpzjyT0mxXTywm29g6F0jhxiaNa9p8Lb72PpWS
wBzuU8wGMp+57DivssOT06ryAsXFrStCCd5IZIRacUu+u32Phd48VVxQ9XqIUMcy
VptsBPkQ7Bg=
=9OB1
-----END PGP SIGNATURE-----

--Lez9QO3Seu3ycz0M--

