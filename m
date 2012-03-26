Date: Mon, 26 Mar 2012 13:00:15 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120326110015.GS1359@...1296...>
References: <CAOazyz1yULF1jkPRGOQriuetsdiUo5PbNVJybSURWPAKgQZMNA@...278...>
	<1332758047-30774-1-git-send-email-alon.barlev@...277...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lz5aeKxNMHO5Q25g"
Content-Disposition: inline
In-Reply-To: <1332758047-30774-1-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] build: assume dlfcn is available on all
	supported platforms
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: Openvpn-devel@lists.sourceforge.net

--lz5aeKxNMHO5Q25g
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Mar 26, 2012 at 12:34:07PM +0200, Alon Bar-Lev wrote:
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  configure.ac |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)

Tested on FreeBSD 7.4 -> configure works fine now, make builds, resulting
binary exists...

gert@...1703...:/home/gert/alon/test$ ./src/openvpn/openvpn --version
OpenVPN 2.3_alpha1 amd64-unknown-freebsd7.4 [SSL (OpenSSL)] [eurephia] [MH]=
 [PF_INET6] [IPv6 payload 20110522-1 (2.2.0)] built on Mar 26 2012

(no further tests done, but this is good enough improvement to *ACK* this).

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--lz5aeKxNMHO5Q25g
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT3BMP6kuBuNlUUl1AQI8ggP/b3bKDcBsbjo3ECdAsoMMGlCmLSiEilm/
OZmwufBqxAdjwdC9AGCbDaXyoZCJL5EkZtRZ3EZl0LFQEgQmrSVdTUcbi9AhXfl9
bZMKXmOEuk0DWkkTj7n4pBK/jfiOK+BmV+MTRMN6c87tkffyXyXV/g3kSVOEgTP8
bt1Zfk3b7Z0=
=d+zc
-----END PGP SIGNATURE-----

--lz5aeKxNMHO5Q25g--

