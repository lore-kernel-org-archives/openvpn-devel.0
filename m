Date: Wed, 31 Aug 2011 19:44:17 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20110831174417.GM8496@...1296...>
References: <1314801488-25380-1-git-send-email-heiko.hund@...1489...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ioSjixjNNql0JcuU"
Content-Disposition: inline
In-Reply-To: <1314801488-25380-1-git-send-email-heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] [PATCH] lowercase include header name in
	syshead.h
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

--ioSjixjNNql0JcuU
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Aug 31, 2011 at 02:38:08PM +0000, Heiko Hund wrote:
> Cross compiling for Windows is broken since commit
> 739fa9881f12e67dc8b9cadc7230e59e7fe42423 added the mixed
> case header name "NtDDNdis.h" to the file. While this header
> exists in a MinGW build environment it's lowercase there.

ACK, thanks for fixing this for good.  (We had a somewhat lengthy=20
discussion about that header file, but it didn't go anywhere due to
lack of windows cluefulness... and maybe willingness :) ).

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--ioSjixjNNql0JcuU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTl5y8akuBuNlUUl1AQK6fQQAhKSn6glcI2f/I6bD4/AL2dJoAO3vod76
3f307M3HIobCXK2QJykvwm+KNzkHYSNlMaMy0Z+U3Sgju765YBWI54WwK5npbGNe
HrIJTvHXvXAsF3Rxoi48/X1cuRVhs3aqp7ewsSON7eUzZ6KGMZzQvr+VCF6Et7ae
lzdYZsNeulg=
=9meS
-----END PGP SIGNATURE-----

--ioSjixjNNql0JcuU--

