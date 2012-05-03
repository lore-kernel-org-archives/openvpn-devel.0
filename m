Date: Thu, 3 May 2012 13:02:53 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120503110253.GO1359@...1296...>
References: <CAAhp1KAp8DDJvgE9CTDST8HEGO4HTiMDmv88sTMpNxtWptyX+g@...278...>
	<CAOazyz35GLCBFFBfZe8KfXZerozZt3ULYD03mFtbhkS6ruxWDg@...278...>
	<CAAhp1KAyH3MkeAn7YS_E1474mUbjzTMeqztFNmc-RKD6JZgTyw@...278...>
	<CAAhp1KCJBqZfjKTRC28wk6g5Bkj=-8cP_oe--cY+cJ82-paNsw@...278...>
	<20120503071459.GM1359@...1296...>
	<CAAhp1KCovS4w-+tvPeaHA8xW8v4+KKmCD+Nt2XVjmkKdSuJG4g@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fayIHV/iA1dFSq+r"
Content-Disposition: inline
In-Reply-To: <CAAhp1KCovS4w-+tvPeaHA8xW8v4+KKmCD+Nt2XVjmkKdSuJG4g@...278...>
Subject: Re: [Openvpn-devel] Does OpenVPN Support Unicode Username and
	Password
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gauri Bhave <gaurib123@...277...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, openvpn-devel@lists.sourceforge.net

--fayIHV/iA1dFSq+r
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, May 03, 2012 at 03:51:27PM +0530, Gauri Bhave wrote:
> Well that's the legacy that i got from the previous developer. So just
> wanted to know if it supports UTF8.=20

No, all versions before 2.3_alpha1 will convert anything non-7bit-ASCII to=
=20
"_" (as you have observed).

> And it will really help if you can
> point out the exact version's of OpenVPN access server and OpenVPN connect
> client which support UTF8 username's and Passwords.

I have no idea.  This list is mainly driven by the community developers,
while OpenVPN Access Server is a commercial product with commercial
support - sharing bits of the code base, but not all of it.  My guess
would be that AS doesn't do UTF8 yet, but you'd really need to ask that
question to your support contacts.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--fayIHV/iA1dFSq+r
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT6Jl3akuBuNlUUl1AQK5BgP9GSF8zs8gamkLMgmwojz1yYqsTrK2dDWc
+rGeVVRr0uFFoD5nrIjVdZoKHLl2IRUH0SNRVyGCEFwqZcCn7e7CIQ0meUstdCZA
fKQd4LyOK+4cBZWck4PQ6DOqEaHAwap2Qc+fvyF4WndfhHxki1IwE0vey5tw53FZ
UdHSkbkPgMA=
=xsrH
-----END PGP SIGNATURE-----

--fayIHV/iA1dFSq+r--

