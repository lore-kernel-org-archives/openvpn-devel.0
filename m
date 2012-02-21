Date: Tue, 21 Feb 2012 22:32:04 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120221213204.GH7024@...1296...>
References: <20120220213246.GV7024@...1296...>
	<1329846253-23464-1-git-send-email-heiko.hund@...1489...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dZHW955j1vPFHE0Q"
Content-Disposition: inline
In-Reply-To: <1329846253-23464-1-git-send-email-heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] [PATCH] mask out X_OK when calling WIN32 API
	_waccess()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

--dZHW955j1vPFHE0Q
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Feb 21, 2012 at 05:44:13PM +0000, Heiko Hund wrote:
> This reverts commit 4ebc587e. Instead of defining X_OK 0 for MSVC,
> this undefined mode value is now simply masked out close to where
> it causes the trouble; in the call to _waccess() as suggested
> during the discussion on the development mailing list:
> http://thread.gmane.org/gmane.network.openvpn.devel/5452
>=20
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>

I suggested this approach, so I should ACK it - but I'm not happy
yet: there really should be a comment in the code explaining why
this is done - without that, this looks like "just random modification
of flag bits", and you need to go to the *git log* to see why this
was done.

A comment like:

 /* Passing X_OK to _(w)access() on windows will cause a crash on
  * Vista and up.  To avoid more complicated code in the calling
  * functions, we just mask out X_OK on windows.  See also
  * http://msdn.microsoft.com/en-us/library/1w06ktdy%28v=3Dvs.100%29.aspx
  */

should be fine.

But maybe I'm just old enough to revisit code 10 years later and ask
myself "why did I do that?"...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--dZHW955j1vPFHE0Q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT0QNVKkuBuNlUUl1AQLeZQQAvtEhlowyWDBUxru5q6XwXdoyeXihlFA3
HRLOLNjjEa/ROyExS99CRtvYj7LIuwp0qNjSUNAiiViSlfuGiqhnqgceC1DS1blv
9OWKPWJGtFb/fF/Fis5FrZvFY+qSyZ491WMm6wj41uFR60H4hkWThLLUAftxjkpJ
8jVuG/O+EdA=
=1CkI
-----END PGP SIGNATURE-----

--dZHW955j1vPFHE0Q--

