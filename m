Date: Sat, 12 Jan 2013 21:13:32 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20130112201331.GH22465@...1296...>
References: <1357994477-29981-1-git-send-email-matthias.andree@...68...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SJLyQBEGuwGzzkni"
Content-Disposition: inline
In-Reply-To: <1357994477-29981-1-git-send-email-matthias.andree@...68...>
Subject: Re: [Openvpn-devel] [PATCH] Enable TCP_NODELAY configuration on
	FreeBSD.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Matthias Andree <matthias.andree@...68...>
Cc: openvpn-devel@lists.sourceforge.net

--SJLyQBEGuwGzzkni
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jan 12, 2013 at 01:41:17PM +0100, Matthias Andree wrote:
> The missing #include <netinet/tcp.h> causes a defined(TCP_NODELAY) to
> fail.  I have added the patch to the FreeBSD ports OpenVPN 2.2.2 and
> 2.3.0, and confirmed (with strings ... | grep) that the TCP_NODELAY code
> is now part of the executable on amd64, and results in this log output:
>=20
> Sat Jan 12 13:39:18 2013 Listening for incoming TCP connection on [undef]
> Sat Jan 12 13:39:18 2013 Socket flags: TCP_NODELAY=3D1 succeeded
>=20
> Obtained from: https://community.openvpn.net/openvpn/ticket/158
> Credits to: M. Nottebrock
>=20
> Signed-off-by: Matthias Andree <matthias.andree@...68...>

ACK, "obviously logical" - needs a build test across all other platforms
to check whether some obscure OS (like "Linux" or "Solaris" or "MinGW")
chokes if that header is included now, but I don't expect issues.

2.3.1 and master, I'd say :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--SJLyQBEGuwGzzkni
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUPHD66kuBuNlUUl1AQKEGQP9Gv+nLAFJssYZU3DMGh7ZFIK3shaFy4LI
O7kinW+fGhW9z4AX37dzMuDgbwYxIBizaG5JW61RJFXExneKcXNMDsA4LjaQVZEf
E0YE00s3GzE7ETqzcwswv68AxiTVMhOX1ChTCHUpAfRS91AIXQ6V6kApQMB6pfOn
+2MGawjQU8w=
=U2S3
-----END PGP SIGNATURE-----

--SJLyQBEGuwGzzkni--

