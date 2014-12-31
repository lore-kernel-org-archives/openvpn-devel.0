Date: Wed, 31 Dec 2014 10:39:53 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20141231093953.GA8134@...1296...>
References: <1417366536-27057-1-git-send-email-steffan@...1856...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <1417366536-27057-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Remove ENABLE_SSL define (and
	--disable-ssl configure option)
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

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Nov 30, 2014 at 05:55:36PM +0100, Steffan Karger wrote:
> Remove the --disable-ssl configure option and accompanying ENABLE_SSL
> defines in the master/2.4 branch, to reduce the code and testing
> complexity a bit.

"ACK, but..." :-) - the patch doesn't apply cleanly to master, as=20
we merged the pkcs#11 patches in the meantime, and that changes context.

Could you rebase and resend, please?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVKPEaakuBuNlUUl1AQLjGgP/cBCJ4FAoPJa/98PuvK0Xs5nR2lgCVyZt
boQyfyUilAQDeBWX0KFBjS0aFK6P+8PHZtXV758R1b+9lRfVE+87E6fPTL2JxI4a
Eb3SSqR0FxgbNnngq3e3E6HuOwJYqOBlmH+AktNitctmZlfhcdqfGpF8i6kw35MS
wm6KFNU/l3o=
=TSGU
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--

