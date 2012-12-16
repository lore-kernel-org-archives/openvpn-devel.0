Date: Sun, 16 Dec 2012 19:57:52 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20121216185752.GC22465@...1296...>
References: <20121214181427.GP22465@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mRZWcJq1s+H2FWyQ"
Content-Disposition: inline
In-Reply-To: <20121214181427.GP22465@...1296...>
Subject: Re: [Openvpn-devel] coverity issue 1 - MF_EXTERNAL_KEY
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--mRZWcJq1s+H2FWyQ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Dec 14, 2012 at 07:14:27PM +0100, Gert Doering wrote:
> Issue #1:  "logical dead code", in options.c, line 2277:

This has already been fixed, I just hit the gap between "fix, ack, forget",
"coverity checks" and "david pushes the fix".

commit feca0900dd005777

-> issue solved.  Easy.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--mRZWcJq1s+H2FWyQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUM4Zr6kuBuNlUUl1AQJi3AP+J/FcGeefixve0dX7l++iVP20XimBtJdi
fFsHMpE60nBeyZ6F5tc5TIZsRREwQYYjRi2nS6yEEaQsLy/loD2sc8dsk54khEQx
iK9kTNw9u7VNcVaFB8meN9vAnaYo4ZwsIlnRNygwNC6dNsjc1VEcwYoHrQkou5Ns
rbEWlUu58W4=
=lP+Z
-----END PGP SIGNATURE-----

--mRZWcJq1s+H2FWyQ--

